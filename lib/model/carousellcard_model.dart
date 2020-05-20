import 'package:flutter/material.dart';

class CardProvince {
  final Color colorBox;
  final String image;
  final Function onTap;

  CardProvince({@required this.colorBox, @required this.image, this.onTap});
}

class CardSource {
  List tempList = [];

  List<CardProvince> listCardProvince = <CardProvince>[
    CardProvince(
        colorBox: Color(0xFF348b7b),
        image: 'src/img/green_chart.png',
        onTap: () {}),
    CardProvince(colorBox: Color(0xFFff8367), image: 'src/img/red_chart.png'),
    CardProvince(
        colorBox: Color(0xFFfdd262), image: 'src/img/yellow_chart.png'),
  ];

  int getIndexValue(int index) {
    tempList.add(index);
    if (tempList.length == 3) tempList = [];

    return tempList.length;
  }
}
