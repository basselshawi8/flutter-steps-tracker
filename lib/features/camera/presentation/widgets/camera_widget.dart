import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraWidget extends StatefulWidget {
  final String url;
  final Offset position;
  final Size size;
  final bool isMini;
  final Function switchCamera;

  const CameraWidget({
    Key key,
    this.url,
    this.isMini,
    this.switchCamera,
    @required this.position,
    @required this.size,
  }) : super(key: key);

  @override
  _CameraWidgetState createState() {
    return _CameraWidgetState();
  }
}

class _CameraWidgetState extends State<CameraWidget> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _configureCamera();
  }

  @override
  void didUpdateWidget(covariant CameraWidget oldWidget) {
    if (_controller.dataSource != widget.url) {
      _configureCamera();
    }

    super.didUpdateWidget(oldWidget);
  }

  _configureCamera() {
    _controller = VideoPlayerController.network(widget.url ??
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.addListener(() {
      if (!mounted) return;
      setState(() {});
    });

    _controller.setLooping(false);
    _controller.play();
    _controller.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.position.dx,
        top: widget.position.dy,

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
    if (widget.isMini != null && widget.isMini == true) {
      return Column(
        children: [
          Container(
            width: widget.size.width,
            height: widget.size.height,
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
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 40.h,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  widget?.switchCamera();
                },
                splashColor: CoreStyle.primaryTheme,
                child: Container(
                  width: widget.size.width,
                  decoration: BoxDecoration(
                      color: CoreStyle.operationBlackColor,
                      border: Border.all(
                          color: CoreStyle.operationBorderColor,
                          width: 2.w),
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 40,
                            offset: Offset(0, 10),
                            color: CoreStyle.operationShadowColor)
                      ]),
                  child: Center(
                    child: Text(
                      "Switch",
                      style: TextStyle(color: CoreStyle.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
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
        width: widget.size.width,
        height: widget.size.height,
      );
    }
  }
}
