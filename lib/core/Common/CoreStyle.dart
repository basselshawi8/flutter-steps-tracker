import 'package:flutter/material.dart';

abstract class CoreStyle {
  static double setWidthPercentage(percentage, context) {
    if (percentage <= 100 || percentage > 0)
      return MediaQuery.of(context).size.width * (percentage / 100);
    else
      return MediaQuery.of(context).size.width;
  }

  static double setHeightPercentage(percentage, context) {
    if (percentage <= 100 || percentage > 0)
      return MediaQuery.of(context).size.height * (percentage / 100);
    else
      return MediaQuery.of(context).size.height;
  }


  static const Color operationBlack2Color = Color(0xFF252424);
  static const Color operationBlackColor = Color(0xFF1D1D1D);
  static const Color operationBorderColor = Color(0xFF4B4B4B);
  static const Color operationBorder2Color = Color(0xFF707070);
  static const Color operationBorder3Color = Color(0xFF6E6E6E);
  static const Color operationGreenBorderColor = Color(0xFF02A76F);
  static const Color operationShadowColor = Color(0xFF828282);
  static const Color operationShadow2Color = Color(0xFFD6D6D6);
  static const Color operationShadow3Color = Color(0xFF4F4F4F);
  static const Color operationGreenContent = Color(0xFF00CB85);

  static const Color restaurantBackground = Color(0xFFFFF5EF);
  static const Color restaurantHeaderColor = Color(0xFF1F1F1F);
  static const Color restaurantShadowColor = Color(0x08000012);
  static const Color restaurantYellowColor = Color(0xFFFFCD3F);
  static const Color restaurantBorderColor = Color(0xFF232323);
  static const Color restaurantMenuSectionColor = Color(0xFF6A6A6A);


  static const Color primaryTheme = Color(0xFFFF7010);
  static const Color primaryValue = Color(0xFF24292E);
  static const Color accentTheme = Color(0xFFFFCD3F);
  static const Color primaryBlue = Color(0xff243672);
  static const Color textColorBlue = Color(0xff243672);
  static const Color accentBlue = Color(0xff002C48);
  static Tween gredientTheme = ColorTween(begin: primaryBlue, end: accentBlue);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);
  static const Color darkGreen = Color(0xFF034A60);

  static const Color tabBarColor = Color(0xffebebeb);
  static const Color White200 = Color(0xffD1D1D1);
  static const Color White400 = Color(0xff8D8D8D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);
  static const Color backGroundColor = Color(0xffFFFFFF);
  static const Color bottomBarBackGroundColor = Color(0xffF3F3F3);
  static const Color bottomBarTextBackGroundColor = Color(0xffA5A5A5);
  static const Color bottomTextBackground = Color(0xff243672);

  static const Color mainBackgroundColor = White200;

  static const Color mainTextColor = primaryDarkValue;
  static const Color textColorWhite = white;
  static const Color textColorGrey = Colors.grey;
  static const Color textColorRed = Colors.red;

  static const Color deliverySuccess = Color.fromARGB(200, 48, 229, 151);
  static const Color deliveryFailed = Color.fromARGB(200, 232, 0, 87);
  static const Color deliveryPending = Color.fromARGB(200, 240, 105, 37);

  static const lightGreenColor = Color(0xff449C45);
  static const lightRedColor = Color(0xffE44E00);
  static const darkRedColor = Color(0xffE82B45);
  static const importantHighlight = Color(0xffffc93c);
}

abstract class CommonTextStyle {
  static const sp32 = 32.0 * 2;
  static const sp28 = 28.0 * 2;
  static const sp22 = 22.0 * 2;
  static const sp18 = 18.0 * 2;
  static const sp16 = 16.0 * 2;
  static const sp14 = 14.0 * 2;
  static const sp12 = 12.0 * 2;
  static const sp9 = 9.0 * 2;

  static const biggestTextSize70dp = 70.0;
  static const lagerTextSize28dp = 28.0;
  static const bigTextSize18dp = 18.0;
  static const normalTextSize16dp = 16.0;
  static const middleTextWhiteSize14dp = 14.0;
  static const smallTextSize14dp = 14.0;
  static const minTextSize12dp = 12.0;
  static const smallestTextSize10dp = 10.0;

  static const textFormFieldUserManagement = const TextStyle(
      color: CoreStyle.primaryTheme,
      decorationThickness: 0,
      decorationColor: CoreStyle.primaryTheme,
      fontSize: CommonTextStyle.smallTextSize14dp);

  static const textFormFieldSearch = const TextStyle(
      color: Colors.black,
      decorationThickness: 0,
      decorationColor: CoreStyle.white,
      fontSize: CommonTextStyle.smallTextSize14dp);

  static const textFormFieldAddAddress = const TextStyle(
      color: Colors.black87,
      decorationThickness: 0,
      decorationColor: Colors.black87,
      fontSize: CommonTextStyle.smallTextSize14dp);

  static const labelUserManagement = const TextStyle(
      color: CoreStyle.primaryTheme,
      decorationThickness: 0,
      decorationColor: CoreStyle.primaryTheme,
      fontSize: CommonTextStyle.minTextSize12dp);

  static const labelAddAddress = const TextStyle(
      color: Colors.black87,
      decorationThickness: 0,
      decorationColor: CoreStyle.primaryDarkValue,
      fontSize: CommonTextStyle.smallTextSize14dp);

  static const labelSearch = const TextStyle(
      color: CoreStyle.primaryTheme,
      decorationThickness: 0,
      decorationColor: CoreStyle.White200,
      fontSize: CommonTextStyle.smallTextSize14dp);

  static const minText = const TextStyle(
    color: CoreStyle.subLightTextColor,
    fontSize: minTextSize12dp,
  );

  static const smallTextWhite = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: smallTextSize14dp,
  );

  static const miniTextWhite = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: 12,
  );

  static const smallTextGrey = const TextStyle(
    color: CoreStyle.textColorGrey,
    fontSize: smallTextSize14dp,
  );

  static const semiSmallTextGrey = const TextStyle(
    color: CoreStyle.textColorGrey,
    fontSize: 15.0,
  );

  static const smallTextWithLineGrey = const TextStyle(
    color: CoreStyle.textColorGrey,
    fontSize: smallTextSize14dp,
    decoration: TextDecoration.lineThrough,
  );

  static const medTextWithLineGrey = const TextStyle(
    color: CoreStyle.textColorGrey,
    fontSize: bigTextSize18dp,
    decoration: TextDecoration.lineThrough,
  );

  static const medBoldTextWithLineGrey = const TextStyle(
      color: CoreStyle.textColorGrey,
      fontSize: bigTextSize18dp,
      decoration: TextDecoration.lineThrough,
      fontWeight: FontWeight.w600);

  static const normalMedTextBlue = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: bigTextSize18dp,
  );

  static const smallTextRed = const TextStyle(
    color: CoreStyle.textColorRed,
    fontSize: smallTextSize14dp,
  );

  static const medBoldRedText = const TextStyle(
    color: CoreStyle.textColorRed,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.w600,
  );

  static const boldBigTextPrimary = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.w600,
  );

  static const miniText = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: minTextSize12dp,
  );

  static const smallText = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: smallTextSize14dp,
  );

  static const smallTextBold = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: smallTextSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = const TextStyle(
    color: CoreStyle.subLightTextColor,
    fontSize: smallTextSize14dp,
  );

  static const smallActionLightText = const TextStyle(
    color: CoreStyle.accentTheme,
    fontSize: smallTextSize14dp,
  );

  static const smallMiLightText = const TextStyle(
    color: CoreStyle.White200,
    fontSize: smallTextSize14dp,
  );

  static const smallSubText = const TextStyle(
    color: CoreStyle.subTextColor,
    fontSize: smallTextSize14dp,
  );

  static const middleText = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: middleTextWhiteSize14dp,
  );

  static const bigTransBlackText = const TextStyle(
      color: Colors.black45,
      fontSize: bigTextSize18dp,
      fontWeight: FontWeight.w200);

  static const medBlackNormalText = const TextStyle(
    color: Colors.black,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.w200,
  );

  static const bigBlackNormalText = const TextStyle(
    color: Colors.black,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.w200,
  );

  static const medBlackBoldText = const TextStyle(
    color: Colors.black,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.w600,
  );

  static const smallLightBlackNormalText = const TextStyle(
    color: Colors.black45,
    fontSize: smallTextSize14dp,
    fontWeight: FontWeight.w200,
  );

  static const middleTextWhite = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: middleTextWhiteSize14dp,
  );
  static const minTextWhite = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: minTextSize12dp,
  );

  static const middleSubText = const TextStyle(
      color: Colors.grey,
      fontSize: middleTextWhiteSize14dp,
      fontWeight: FontWeight.w100);

  static const middleSubLightText = const TextStyle(
    color: CoreStyle.subLightTextColor,
    fontSize: middleTextWhiteSize14dp,
  );

  static const middleTextBold = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: middleTextWhiteSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: middleTextWhiteSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = const TextStyle(
    color: CoreStyle.subTextColor,
    fontSize: middleTextWhiteSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const normalText = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: normalTextSize16dp,
  );

  static const normalTextBold = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.bold,
  );

  static const normalTextBoldForMessage = TextStyle(
      color: CoreStyle.mainTextColor,
      fontSize: normalTextSize16dp,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);

  static const normalSubText = const TextStyle(
    color: CoreStyle.subTextColor,
    fontSize: normalTextSize16dp,
  );

  static const normalTextWhite = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: normalTextSize16dp,
  );

  static const normalTextMitWhiteBold = const TextStyle(
    color: CoreStyle.White200,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.bold,
  );

  static const normalTextMitWhite = const TextStyle(
    color: Colors.white70,
    fontSize: normalTextSize16dp,
  );

  static const normalTextActionWhiteBold = const TextStyle(
    color: CoreStyle.accentTheme,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = const TextStyle(
    color: CoreStyle.primaryLightValue,
    fontSize: normalTextSize16dp,
  );

  static const largeText = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: bigTextSize18dp,
  );

  static const largeTextBold = const TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: bigTextSize18dp,
  );

  static const largeTextWhiteBold = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhiteBold = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: lagerTextSize28dp,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: lagerTextSize28dp,
  );

  static const largeLargeText = const TextStyle(
    color: CoreStyle.primaryValue,
    fontSize: lagerTextSize28dp,
    fontWeight: FontWeight.bold,
  );

  static const biggestTextWhite = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: biggestTextSize70dp,
  );

  static const categoryBottomText = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.w700,
  );

  static const boldBlueSmallText = const TextStyle(
    color: CoreStyle.textColorBlue,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.bold,
  );

  static const boldBlueBigText = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.bold,
  );

  static const normalBlueSmallText = const TextStyle(
    color: CoreStyle.textColorBlue,
    fontSize: smallTextSize14dp,
  );

  static const normalBlueMedText = const TextStyle(
    color: CoreStyle.textColorBlue,
    fontSize: normalTextSize16dp,
  );

  static const semiBoldBlueSmallText = const TextStyle(
    color: CoreStyle.textColorBlue,
    fontSize: smallTextSize14dp,
    fontWeight: FontWeight.w600,
  );

  static const boldWhiteMedText = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: smallTextSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const normalWhiteMedText = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: smallTextSize14dp,
  );

  static const boldWhiteSmallMedText = const TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: smallTextSize14dp,
    fontWeight: FontWeight.w800,
  );

  static const normalGreySmallText = const TextStyle(
    color: CoreStyle.textColorGrey,
    fontSize: normalTextSize16dp,
  );

  static const normalGreyMedText = const TextStyle(
    color: CoreStyle.textColorGrey,
    fontSize: bigTextSize18dp,
  );

  static const boldGreyMedText = const TextStyle(
    color: CoreStyle.textColorGrey,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.bold,
  );

  static const boldPrimaryMedText = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.w700,
  );

  static const smallNormalGrey = const TextStyle(
      color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.w100);

  static const SemiBoldPrimaryMedText = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.w700,
  );

  static const normalPrimaryMedText = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: bigTextSize18dp,
  );

  static const normalPrimarySmallText = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: normalTextSize16dp,
  );

  static const normalPrimaryMinText = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: smallTextSize14dp,
  );

  static const normalPrimaryMinWithUnderLineText = const TextStyle(
      color: CoreStyle.primaryTheme,
      fontSize: smallTextSize14dp,
      decoration: TextDecoration.underline);

  static const normalDarkBlue = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: normalTextSize16dp,
  );

  static const normalBoldDarkBlue = const TextStyle(
    color: CoreStyle.primaryTheme,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.w800
  );

}

class AddVerticalSpace extends StatelessWidget {
  final double h;

  AddVerticalSpace(this.h);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
    );
  }
}

class AddHorizontalSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 5,
    );
  }
}

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final top, bottom;

  const CustomText(this.text, {Key key, this.textStyle, this.top, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: top == null ? 4 : top, bottom: bottom == null ? 4 : bottom),
      child: Text(
        this.text,
        style: textStyle == null ? null : textStyle,
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
      ),
    );
  }
}
