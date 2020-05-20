import 'package:covid/widget/custom_icons_icons.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Color colorBox;
  final String namaDaerah;
  final String jumlahPositif;
  final String image;

  CardWidget({
    @required this.colorBox,
    @required this.image,
    @required this.jumlahPositif,
    @required this.namaDaerah,
  });

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Card(
        color: colorBox,
        child: Container(
          width: device.width / 3,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      namaDaerah,
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontFamily: "Montserrat SemiBold",
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$jumlahPositif',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: "Montserrat Bold",
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 15.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(child: Image.asset(image)),
              )
            ],
          ),
        ));
  }
}
