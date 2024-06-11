import 'package:flutter/material.dart';

class CustomHorizontalList extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  CustomHorizontalList({
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          itemCount,
          (index) => SizedBox(
            child: itemBuilder(context, index),
          ),
        ),
      ),
    );
  }
}
