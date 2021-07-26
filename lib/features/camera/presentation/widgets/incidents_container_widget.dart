import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';

class IncidentsContainerWidget extends StatefulWidget {
  @override
  _IncidentsContainerWidgetState createState() {
    // TODO: implement createState
    return _IncidentsContainerWidgetState();
  }
}

class _IncidentsContainerWidgetState extends State<IncidentsContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
        ),
        Container(
          height: 200.w,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return IncidentsContainerItemWidget();
            },
            itemCount: 20,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 200.w,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return IncidentsContainerItemWidget();
            },
            itemCount: 20,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 200.w,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return IncidentsContainerItemWidget();
            },
            itemCount: 20,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 200.w,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return IncidentsContainerItemWidget();
            },
            itemCount: 20,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}

class IncidentsContainerItemWidget extends StatefulWidget {
  @override
  _IncidentsContainerItemWidgetState createState() {
    // TODO: implement createState
    return _IncidentsContainerItemWidgetState();
  }
}

class _IncidentsContainerItemWidgetState
    extends State<IncidentsContainerItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 200.w,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: CoreStyle.operationBlackColor,
          boxShadow: [
            BoxShadow(
                color: CoreStyle.operationShadowColor,
                blurRadius: 2.h,
                offset: Offset(0, 1.h)),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10.h))),
    );
  }
}
