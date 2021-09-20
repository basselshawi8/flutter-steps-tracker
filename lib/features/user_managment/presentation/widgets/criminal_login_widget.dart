import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/map/presentation/screen/polygon_drawer.dart';

class CriminalLogicWidget extends StatefulWidget {
  @override
  _CriminalLogicWidgetState createState() {
    return _CriminalLogicWidgetState();
  }
}

class _CriminalLogicWidgetState extends State<CriminalLogicWidget> {
  @override
  Widget build(BuildContext context) {
    return PolygonDrawer();
  }
}
