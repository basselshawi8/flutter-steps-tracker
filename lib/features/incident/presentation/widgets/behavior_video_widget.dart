import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BehaviorVideoWidget extends StatefulWidget {
  final String videoURL;

  const BehaviorVideoWidget({Key key, this.videoURL}) : super(key: key);

  @override
  _BehaviorVideoWidgetState createState() {
    return _BehaviorVideoWidgetState();
  }
}

class _BehaviorVideoWidgetState extends State<BehaviorVideoWidget> {
  final _videoURL =
      "https://incidentapi.herokuapp.com/incident/behavioral/612df485d949b90016b3cc02";

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;


  @override
  void initState() {
    super.initState();
    _configureCamera();
  }

  @override
  void didUpdateWidget(covariant BehaviorVideoWidget oldWidget) {
    if (_controller.dataSource != widget.videoURL) {
      _configureCamera();
    }

    super.didUpdateWidget(oldWidget);
  }

  _configureCamera() {
    print(widget.videoURL);
    _controller = VideoPlayerController.network(widget.videoURL ?? _videoURL);

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.addListener(() {
      if (!mounted) return;
      setState(() {});
    });

    _controller.setLooping(true);
    _controller.play();
    _controller.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 600.w,
        top: 105.h,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _getParentContainer();
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(() {});
    _controller?.dispose();
  }

  Widget _getParentContainer() {
    return Column(
      children: [
        InkWell(
          onTap: (){

          },
          child: Container(
            width: 300.w,
            height: 300.w,
            decoration: BoxDecoration(
                border: Border.all(
                    color: CoreStyle.operationGreenBorderColor, width: 5.w),
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 40,
                      offset: Offset(0, 10),
                      color: CoreStyle.operationShadowColor)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Stack(
                children: <Widget>[
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size?.width ?? 0,
                        height: _controller.value.size?.height ?? 0,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  //FURTHER IMPLEMENTATION
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
