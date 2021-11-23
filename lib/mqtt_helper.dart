import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_behavioral_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_facial_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_human_detection_model.dart';

//import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MotionModes { FreeMode, ThreeSixtyMode, Stop }

enum RobotDirection { Forward, Back, Right, Left }

enum CameraMovement { Up, Down, Right, Left, ZoomIn, ZoomOut }

class MqttHelper {
  static final MqttHelper _singleton = MqttHelper._internal();

  final client = MqttServerClient.withPort(
      "ws://94.206.14.42", "frontEndClientIdentifier", 9509);

  //final client = MqttBrowserClient.withPort("ws://94.206.14.42", "frontEndClientIdentifier", 9509);

  Stream dataReceived;
  Stream locationReceived;
  Stream incidentReceived;
  Stream batteryReceived;
  Stream accelerationReceived;

  StreamController _streamController;
  StreamController _streamLocationController;
  StreamController _streamIncidnetController;

  StreamController _streamBatteryController;
  StreamController _streamCurrentAccelerationController;

  var pubTopic = 'm2/control';

  var pubBehaviorTopic = 'm2/behavioral_control';
  var pubFacialTopic = 'm2/facial_control';
  var pubHumanTopic = 'm2/human_control';

  var stopTopic = 'm2/stopmove';

  var pubMotionMode = 'm2/motion_mode';
  var pubRobotDirection = 'm2/robot_direction';
  var pubRobotAcceleration = 'm2/robot_acceleration';

  var batteryTopic = "m2/batt";
  var currentAccelerationTopic = "m2/curracc";

  var cameraTitleTopic = "m2/tilting";
  var cameraPanTopic = "m2/panning";
  var cameraZoomTopic = "m2/zooming";

  var locationTopic = "m2/currloc";

  var vehiclePrefix = "m2";

  var testDate = DateTime.now();

  factory MqttHelper() {
    return _singleton;
  }

  initConnection() async {
    client.disconnect();

    batteryTopic = "$vehiclePrefix/batt";
    currentAccelerationTopic = "$vehiclePrefix/curracc";
    pubTopic = '$vehiclePrefix/control';

    pubBehaviorTopic = '$vehiclePrefix/behavioral_control';
    pubFacialTopic = '$vehiclePrefix/facial_control';
    pubHumanTopic = '$vehiclePrefix/human_control';

    pubMotionMode = '$vehiclePrefix/motion_mode';
    pubRobotDirection = '$vehiclePrefix/robot_direction';
    pubRobotAcceleration = '$vehiclePrefix/robot_acceleration';

    cameraTitleTopic = '$vehiclePrefix/tilting';
    cameraPanTopic = '$vehiclePrefix/panning';
    cameraZoomTopic = '$vehiclePrefix/zooming';

    locationTopic = "$vehiclePrefix/currloc";

    stopTopic = "$vehiclePrefix/stopmove";

    if (_streamController == null) {
      _streamController = StreamController<dynamic>();
      _streamLocationController = StreamController<dynamic>();
      _streamIncidnetController = StreamController<dynamic>();
      _streamBatteryController = StreamController<dynamic>();
      _streamCurrentAccelerationController = StreamController<dynamic>();

      dataReceived = _streamController.stream.asBroadcastStream();
      locationReceived = _streamLocationController.stream.asBroadcastStream();
      incidentReceived = _streamIncidnetController.stream.asBroadcastStream();
      batteryReceived = _streamBatteryController.stream.asBroadcastStream();
      accelerationReceived =
          _streamCurrentAccelerationController.stream.asBroadcastStream();
    }
    client.logging(on: false);

    client.onDisconnected = onDisconnected;
    client.port = 9509;
    client.useWebSocket = true;

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client.keepAlivePeriod = 20;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client.onSubscribed = onSubscribed;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client.pongCallback = pong;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier(
            'op' + (DateTime.now().millisecondsSinceEpoch / 1000).toString())
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    if (client.connectionStatus.state != MqttConnectionState.connecting)
      connect();
  }

  void connect() async {
    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      // client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
      // client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      //client.disconnect();
      //exit(-1);
    }

    /// Ok, lets try a subscription
    print('EXAMPLE::Subscribing to the test/lol topic');
    var topic = '$vehiclePrefix/camerastream'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atLeastOnce);

    var topicIncident = '$vehiclePrefix/incident'; // Not a wildcard topic
    client.subscribe(topicIncident, MqttQos.atLeastOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    ///

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      /// The above may seem a little convoluted for users only interested in the
      /// payload, some users however may be interested in the received publish message,
      /// lets not constrain ourselves yet until the package has been in the wild
      /// for a while.
      /// The payload is a byte buffer, this will be specific to the topic
      ///
      ///

      if (c[0].topic == topic) {
        _streamController.add({"${c[0].topic}": base64Decode(pt)});
        //print((DateTime.now().millisecondsSinceEpoch - this.testDate.millisecondsSinceEpoch)~/1000);
        //this.testDate = DateTime.now();

      } else if (c[0].topic == topicIncident) {
        _streamIncidnetController.add({"${c[0].topic}": json.decode(pt)});
      } else if (c[0].topic == batteryTopic) {
        _streamBatteryController
            .add({"${c[0].topic}": json.decode(pt)["battery"]});
      } else if (c[0].topic == currentAccelerationTopic) {
        _streamCurrentAccelerationController
            .add({"${c[0].topic}": json.decode(pt)["accel"]});
      } else if (c[0].topic == locationTopic) {
        print("location reveived");
        print(json.decode(pt));
        _streamLocationController.add(
            LatLng(json.decode(pt)["latitude"], json.decode(pt)["longitude"]));
      }

      //print(
      // 'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    });

    /// If needed you can listen for published messages that have completed the publishing
    /// handshake which is Qos dependant. Any message received on this stream has completed its
    /// publishing handshake with the broker.
    client.published.listen((MqttPublishMessage message) {
      // print(
      //   'EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
    });

    client.subscribe(pubTopic, MqttQos.atLeastOnce);

    client.subscribe(pubBehaviorTopic, MqttQos.atLeastOnce);
    client.subscribe(pubFacialTopic, MqttQos.atLeastOnce);
    client.subscribe(pubHumanTopic, MqttQos.atLeastOnce);

    client.subscribe(pubMotionMode, MqttQos.atLeastOnce);
    client.subscribe(pubRobotDirection, MqttQos.atLeastOnce);
    client.subscribe(pubRobotAcceleration, MqttQos.atLeastOnce);

    client.subscribe(cameraPanTopic, MqttQos.atLeastOnce);
    client.subscribe(cameraTitleTopic, MqttQos.atLeastOnce);
    client.subscribe(cameraZoomTopic, MqttQos.atLeastOnce);

    client.subscribe(batteryTopic, MqttQos.atLeastOnce);
    client.subscribe(currentAccelerationTopic, MqttQos.atLeastOnce);

    client.subscribe(stopTopic, MqttQos.atLeastOnce);

    client.subscribe(locationTopic, MqttQos.atLeastOnce);

    /// Publish it
    print('EXAMPLE::Publishing our topic');
//client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);

//Future.delayed(Duration(seconds: 20)).then((value) =>
//  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload));

    /// Ok, we will now sleep a while, in this gap you will see ping request/response
    /// messages being exchanged by the keep alive mechanism.
/* print('EXAMPLE::Sleeping....');
    await MqttUtilities.asyncSleep(120);

    /// Finally, unsubscribe and exit gracefully
    print('EXAMPLE::Unsubscribing');
    client.unsubscribe(topic);

    /// Wait for the unsubscribe message from the broker if you wish.
    await MqttUtilities.asyncSleep(2);
    print('EXAMPLE::Disconnecting');
    client.disconnect();*/
  }

  void publishAi(bool value) {
    print("publish ai");
    final builder = MqttClientPayloadBuilder();
    var payloadMap = json.encode({"AI_status": value});
    builder.addString(payloadMap);
    client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishMotionMode(MotionModes value) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap = "";
    switch (value) {
      case MotionModes.FreeMode:
        payloadMap = json.encode({"motion": "q"});
        break;
      case MotionModes.ThreeSixtyMode:
        payloadMap = json.encode({"motion": "w"});
        break;
      case MotionModes.Stop:
        payloadMap = json.encode({"motion": "e"});
        break;
      default:
        break;
    }
    builder.addString(payloadMap);
    client.publishMessage(pubMotionMode, MqttQos.atLeastOnce, builder.payload);
  }

  void publishRobotDirection(RobotDirection value) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap = "";
    switch (value) {
      case RobotDirection.Forward:
        payloadMap = json.encode({"dir": "f"});
        break;
      case RobotDirection.Back:
        payloadMap = json.encode({"dir": "b"});
        break;
      case RobotDirection.Left:
        payloadMap = json.encode({"dir": "l"});
        break;
      case RobotDirection.Right:
        payloadMap = json.encode({"dir": "r"});
        break;
      default:
        break;
    }
    builder.addString(payloadMap);
    client.publishMessage(
        pubRobotDirection, MqttQos.atLeastOnce, builder.payload);
  }

  void publishRobotAcceleration(int value) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap = json.encode({"accel": "$value"});
    builder.addString(payloadMap);
    client.publishMessage(
        pubRobotAcceleration, MqttQos.atLeastOnce, builder.payload);
  }

  void publishHuman(bool value, CreateHumanDetectionModel model) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap =
        json.encode({"human_status": value, "human_config": model});
    print("human");
    builder.addString(payloadMap);
    client.publishMessage(pubHumanTopic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishCameraTilt(int value, CameraMovement movement) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap = movement == CameraMovement.Up
        ? json.encode({"move_up": value})
        : json.encode({"move_down": value});
    builder.addString(payloadMap);
    print(payloadMap.toString());
    client.publishMessage(
        cameraTitleTopic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishCameraPan(int value, CameraMovement movement) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap = movement == CameraMovement.Right
        ? json.encode({"move_right": value})
        : json.encode({"move_left": value});
    print(payloadMap.toString());
    builder.addString(payloadMap);
    client.publishMessage(cameraPanTopic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishCameraZoom(int value, CameraMovement movement) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap = movement == CameraMovement.ZoomIn
        ? json.encode({"zoom_in": value})
        : json.encode({"zoom_out": value});
    print(payloadMap.toString());
    builder.addString(payloadMap);
    client.publishMessage(
        cameraZoomTopic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishFacial(bool value, CreateFacialModel model) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap =
        json.encode({"facial_status": value, "facial_config": model});
    builder.addString(payloadMap);
    client.publishMessage(pubFacialTopic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishStop() {
    final builder = MqttClientPayloadBuilder();
    client.publishMessage(stopTopic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishBehavior(bool value, CreateBehavioralModel model) {
    final builder = MqttClientPayloadBuilder();
    var payloadMap =
        json.encode({"behavioral_status": value, "behavioral_config": model});
    builder.addString(payloadMap);
    client.publishMessage(
        pubBehaviorTopic, MqttQos.atLeastOnce, builder.payload);
  }

  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }

    if (client.connectionStatus.state != MqttConnectionState.connecting)
      connect();
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }

  MqttHelper._internal();
}
