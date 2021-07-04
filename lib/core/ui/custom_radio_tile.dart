import 'package:micropolis_test/core/Common/Common.dart';
import 'package:flutter/material.dart';

class CustomRadioTile extends StatefulWidget {
  final int groupVal;
  final int val;
  final Widget child;
  final Function(int) onChange;
  final double top, bottom;

  const CustomRadioTile(
      {Key key,
      @required this.groupVal,
      @required this.val,
      this.child,
      @required this.onChange,
      this.top,
      this.bottom})
      : super(key: key);

  @override
  _CustomRadioTileState createState() => _CustomRadioTileState();
}

class _CustomRadioTileState extends State<CustomRadioTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: widget.top == null ? 0 : widget.top,
      bottom: widget.bottom == null ? 0 : widget.bottom),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () {
            this._onChangeCalled();
          },
          child: Row(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Radio(
                      onChanged: (_) {},
                      groupValue: widget.groupVal,
                      value: widget.val,
                      activeColor: CoreStyle.accentBlue,
                    ),
                  ),
                ],
              ),
              Container(
                child: widget.child,
              )
            ],
          )),
    );
  }

  _onChangeCalled() {
    widget.onChange(widget.val);
  }
}
