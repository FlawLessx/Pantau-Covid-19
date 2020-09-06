import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatisticKasus extends StatelessWidget {
  final String jumlahPositif;
  final String jumlahCategory;
  final String percentText;
  final double percent;
  final Color colorTextCategory;
  final String tipeCategory;
  final String image;
  final Color colorArrow;
  final Color colorBox;

  StatisticKasus(
      {@required this.colorTextCategory,
      @required this.jumlahCategory,
      @required this.jumlahPositif,
      @required this.percent,
      @required this.percentText,
      @required this.image,
      @required this.tipeCategory,
      @required this.colorArrow,
      @required this.colorBox});

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Container(
      height: device.height / 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new CircularPercentIndicator(
              radius: 140.0,
              lineWidth: 11.0,
              animation: true,
              percent: percent,
              backgroundColor: Color(0xFFebf4f3),
              center: new Text(
                percentText,
                textScaleFactor: 1.0,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: "Montserrat Bold",
                  color: Color(0xFF267466),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0xFF348b7b),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: device.height / 10,
                  width: device.width / 2.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.white54, Color(0xFFfaeaeb)])),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Positif',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontFamily: "Montserrat Bold",
                                        color: Color(0xFF4d1a1f),
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_up,
                                      color: Color(0xFFe56267),
                                      size: 20.0,
                                    )
                                  ],
                                ),
                                Text(
                                  jumlahPositif,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontFamily: "Montserrat Bold",
                                    color: Color(0xFF4d1a1f),
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: device.height / 17,
                            width: device.width / 5,
                            child: Image.asset(
                              'src/img/red_linechart.png',
                              filterQuality: FilterQuality.medium,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: device.height / 10,
                  width: device.width / 2.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.white54, colorBox])),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      tipeCategory,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontFamily: "Montserrat Bold",
                                        color: colorTextCategory,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_up,
                                      color: colorArrow,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                                Text(
                                  jumlahCategory,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontFamily: "Montserrat Bold",
                                    color: colorTextCategory,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 70,
                            width: device.width / 5,
                            child: Image.asset(
                              image,
                              filterQuality: FilterQuality.medium,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
