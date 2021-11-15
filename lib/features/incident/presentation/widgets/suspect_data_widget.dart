import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:provider/provider.dart';

class SuspectDataWidget extends StatefulWidget {
  @override
  _SuspectDataWidgetState createState() {
    return _SuspectDataWidgetState();
  }
}

class _SuspectDataWidgetState extends State<SuspectDataWidget> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    var styleTitle = TextStyle(
        color: CoreStyle.white, fontSize: 14.sp, fontWeight: FontWeight.w300);
    var styleContent = TextStyle(
        color: CoreStyle.white, fontSize: 17.sp, fontWeight: FontWeight.w600);
    var suspect = Provider.of<IncidentsChangeNotifier>(context, listen: false)
        .suspects
        ?.data[_index];
    return Positioned(
        top: (512 - 300).h,
        left: 200.w,
        child: Container(
          width: 500.w,
          height: 600.h,
          decoration: BoxDecoration(
              color: CoreStyle.operationBlack2Color,
              borderRadius: BorderRadius.circular(12.r)),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 50.h,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<IncidentsChangeNotifier>(context,
                                  listen: false)
                              .showSubjectData = false;
                        },
                        child: Icon(
                          Icons.close,
                          color: CoreStyle.white,
                          size: 32.w,
                        ),
                      ),
                      if (suspect != null) ...[
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          "Name",
                          style: styleTitle,
                        ),
                        Text(
                          "${suspect.name} ${suspect.surname}",
                          style: styleContent,
                        ),
                        SizedBox(height: 12.h),
                        Text("Nationality", style: styleTitle),
                        Text("${suspect.nationality}", style: styleContent),
                        SizedBox(height: 12.h),
                        Text("ID Type", style: styleTitle),
                        Text("${suspect.idType}", style: styleContent),
                        SizedBox(height: 12.h),
                        Text("ID Number", style: styleTitle),
                        Text("${suspect.idNo}", style: styleContent),
                        SizedBox(height: 12.h),
                        Text("Date of Birth", style: styleTitle),
                        Text("${suspect.dateOfBirth}", style: styleContent),
                        SizedBox(height: 12.h),
                        Text("Gender", style: styleTitle),
                        Text("${suspect.gender}", style: styleContent),
                        SizedBox(height: 12.h),

                      ],
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_index > 0) {
                            setState(() {
                              _index -= 1;
                            });
                          }
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: CoreStyle.white,
                          size: 50.w,
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
