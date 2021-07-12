import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/restaurants/presentation/widgets/menu_item_widget.dart';

class MenuSectionWidget extends StatelessWidget {
  final MenuSectionEntity section;

  const MenuSectionWidget({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.menu,
          style: TextStyle(
              color: CoreStyle.restaurantMenuSectionColor,
              fontWeight: FontWeight.w700,
              fontSize: 45.sp),
        ),
        SizedBox(
          height: 40.h,
        ),
        Container(
          decoration: BoxDecoration(
              color: CoreStyle.white,
              borderRadius: BorderRadius.all(Radius.circular(30.h)),
              boxShadow: [
                BoxShadow(
                    color: CoreStyle.restaurantShadowColor,
                    offset: Offset(0, 5.h),
                    spreadRadius: 5.r,
                    blurRadius: 8.r)
              ]),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return MenuItemWidget(
                item: section.items[index],
                isLastElement: index == section.items.length - 1,
              );
            },
            itemCount: section.items.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        )
      ],
    );
  }
}
