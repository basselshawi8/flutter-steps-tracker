import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final Widget title;
  final Color color;
  final Icon icon;
  final Function onClick;
  final double borderRadius;
  final bool withIconBackground;

  const GlobalButton(
      {Key key,
      this.title,
      this.color,
      this.icon,
      this.onClick,
      this.borderRadius,
      this.withIconBackground})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            this.borderRadius == null ? 30.0 : this.borderRadius,
          ),
        ),
        onPressed: this.onClick,
        textColor: Colors.white,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: title == null
              ? Container(
                  child: icon,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    icon == null
                        ? Container()
                        : Container(
                            child: icon,
                            decoration: BoxDecoration(
                              color: withIconBackground != null &&
                                      withIconBackground
                                  ? Colors.white
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                    title
                  ],
                ),
        ));
  }
}
