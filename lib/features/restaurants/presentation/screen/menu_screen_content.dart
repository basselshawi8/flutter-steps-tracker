import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/ui/error_widget.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';
import 'package:micropolis_test/features/restaurants/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/restaurants/presentation/widgets/menu_section_widget.dart';
import 'package:micropolis_test/features/restaurants/presentation/widgets/restaurant_list_item.dart';

class MenuScreenContent extends StatefulWidget {
  final RestaurantMenuEntity menu;

  const MenuScreenContent({Key key, this.menu}) : super(key: key);

  @override
  _MenuScreenContentState createState() {
    return _MenuScreenContentState();
  }
}

class _MenuScreenContentState extends State<MenuScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(60.w, 0.h, 60.w, 24.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.only(top:index==0 ? 30.h : 0 ),
                child: MenuSectionWidget(section: widget.menu.sections[index]),
              );
            },
            shrinkWrap: true,
            itemCount: widget.menu.sections.length,
          ),
        )
      ]),
    );
  }
}
