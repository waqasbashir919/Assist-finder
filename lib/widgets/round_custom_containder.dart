import 'package:flutter/material.dart';

class RoundCustomContainder extends StatefulWidget {
  final double height;
  final double width;
  final Color color;
  final Column column;
  final double BorderRadius;
  final Color BorderColor;

  RoundCustomContainder(
      {Key? key,
      required this.height,
      required this.width,
      required this.color,
      required this.column,
      required this.BorderRadius,
      required this.BorderColor})
      : super(key: key);

  @override
  _RoundCustomContainderState createState() => _RoundCustomContainderState();
}

class _RoundCustomContainderState extends State<RoundCustomContainder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.BorderRadius),
          border: Border.all(color: widget.BorderColor)),
      child: widget.column,
    );
  }
}
