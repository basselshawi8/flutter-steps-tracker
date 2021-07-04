import 'package:micropolis_test/core/Common/Common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget listWaitingWidget(BuildContext context, bool withImage) {
  return Container(
    height: CoreStyle.setHeightPercentage(100, context),
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(5),
              bottom: ScreenUtil().setHeight(5)),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            elevation: 5.0,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                withImage ? Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: Container(
                    height: ScreenUtil().setHeight(270),
                    width: 100,
                    color: Colors.white,
                  ),
                ) : Container(),
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:
                      ScreenUtil().setHeight(20),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: Container(
                        margin:
                        EdgeInsetsDirectional.only(
                            start: 5),
                        height:
                        ScreenUtil().setHeight(50),
                        width: CoreStyle
                            .setWidthPercentage(
                            40, context),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height:
                      ScreenUtil().setHeight(20),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: Container(
                        margin:
                        EdgeInsetsDirectional.only(
                            start: 5),
                        height:
                        ScreenUtil().setHeight(50),
                        width: CoreStyle
                            .setWidthPercentage(
                            40, context),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height:
                      ScreenUtil().setHeight(20),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: Container(
                        margin:
                        EdgeInsetsDirectional.only(
                            start: 5),
                        height:
                        ScreenUtil().setHeight(50),
                        width: CoreStyle
                            .setWidthPercentage(
                            40, context),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height:
                      ScreenUtil().setHeight(20),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      itemCount: 4,
    ),
  );
}