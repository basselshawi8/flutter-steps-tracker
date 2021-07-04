import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/core/ui/custom_outlined_button.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItemEntity item;
  final bool isLastElement;

  const MenuItemWidget({Key key, this.item, @required this.isLastElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16.h)),
                    child: FadeInImage(
                      placeholder: const AssetImage(IMG_NETWORK_PLACEHOLDER),
                      image: NetworkImage(item.image),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 35.sp,
                              color: CoreStyle.restaurantHeaderColor),
                        ),
                        Text(
                          item.price,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 35.sp,
                              color: CoreStyle.primaryTheme),
                        )
                      ],
                    ),
                  ),
                ),
                CustomOutlinedButton(text: "+ ADD",onPressed: (){},),
                SizedBox(width: 20.w,)
              ],

            ),
          ),
          if(isLastElement==false)
            Container(height: 2,color: CoreStyle.restaurantShadowColor,)
        ],
      ),
    );
  }
}
