import 'package:flutter/material.dart';
import 'package:shopping_app/components/card_widget.dart';

class MyGridContent extends StatelessWidget {
  String img;
  String txt;
  MyGridContent({super.key, required this.img, required this.txt});
// grid view widget contains Row of CardWidget widgets
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CardWidget(
            img: img,
            txt: txt,
          ),
        ),
        Expanded(
          flex: 2,
          child: CardWidget(
            img: img,
            txt: txt,
          ),
        ),
      ],
    );
  }
}
