import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/data/params/incident_param.dart';
import 'package:micropolis_test/features/camera/presentation/bloc/incident_bloc.dart';
import 'package:micropolis_test/features/camera/presentation/bloc/incident_event.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/ai_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/camera_direction_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/camera_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/incidents_container_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/incidents_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/main_navigation_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/pinned_list_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/pinned_widget.dart';
import 'package:micropolis_test/features/map/presentation/screen/robot_location_map.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MainWindowScreen extends StatefulWidget {
  static const routeName = '/mainWindow';

  @override
  _MainWindowScreenState createState() {
    return _MainWindowScreenState();
  }
}

class _MainWindowScreenState extends State<MainWindowScreen>
    with SingleTickerProviderStateMixin {
  var urls = ['ws://192.168.1.104:9509/sub', 'ws://192.168.1.104:9510/sub'];
  AnimationController _animationController;
  Animation _incidentsPanelAnimationMain;
  Animation _incidentsPanelAnimationSub;
  var _firstState = true;

  WebSocketChannel _incidentsChannel;

  @override
  void initState() {
    _incidentsChannel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.1.104:9511/sub'),
    );


    /*WidgetsBinding.instance.addObserver(ResizeNotifier(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

        if (mounted) Phoenix.rebirth(context);
      });
    }));*/

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _incidentsPanelAnimationSub = Tween<double>(begin: 1920.w, end: 1200.w)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linearToEaseOut));

    _incidentsPanelAnimationMain = Tween<double>(begin: 0, end: 1920.w - 1200.w)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.fastOutSlowIn));

    _animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: _incidentsChannel.stream,
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData == true &&
                  json.decode(snapshot.data) is Map<String, dynamic>) {
                var id = json.decode(snapshot.data["id"]);
                BlocProvider.of<IncidentsBloc>(context)
                    .add(GetIncident(IncidentParam(incidentID: id), null));
              }
              print(snapshot?.data);
              return Consumer<ActionsChangeNotifier>(
                builder: (context, state, _) {
                  if (_firstState == false) {
                    if (state.showIncidentsPanel == false) {
                      _animationController.reverse();
                    } else {
                      _animationController.forward();
                    }
                  }
                  _firstState = false;
                  return Stack(
                    children: [
                      Positioned(
                          left: _incidentsPanelAnimationSub.value,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            color: CoreStyle.operationBlackColor,
                            child: IncidentsContainerWidget(),
                          )),
                      Positioned(
                        left: 0,
                        top: 0,
                        right: _incidentsPanelAnimationMain.value,
                        bottom: 0,
                        child: Stack(
                          children: [
                            CameraWidget(
                              position: Offset(0, 0),
                              size: Size(1920.w, 1080.h),
                              url: urls[0],
                            ),
                            CameraWidget(
                              position: Offset(32, 32),
                              size: Size(217.h, 217.h),
                              isMini: true,
                              url: urls[1],
                              switchCamera: () {
                                urls = urls.reversed.toList();
                                setState(() {});
                              },
                            ),
                            MainNavigationWidget(),
                            CameraDirectionWidget(),
                            IncidentsWidget(),
                            AIWidget(),
                            PinnedListWidget(),
                            PinnedWidget(),
                            Positioned(
                                right: 60.w,
                                top: 30.h,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(RobotLocationMap.routeName);
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                      width: 220.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                          color: CoreStyle.operationBlackColor
                                              .withOpacity(0.77),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            IMG_ROBOT,
                                            width: 35.w,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            "DPAP Grand",
                                            style: TextStyle(
                                                color: CoreStyle.white,
                                                fontSize: 20.sp),
                                          )
                                        ],
                                      )),
                                ))
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class ResizeNotifier with WidgetsBindingObserver {
  final Function callBack;

  ResizeNotifier(this.callBack);

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    callBack();
  }
}
