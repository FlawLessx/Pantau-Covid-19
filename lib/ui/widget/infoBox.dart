import 'package:flutter/material.dart';
import 'package:flag/flag.dart';

class InfoBox extends StatelessWidget {
  final String countryCode;
  final String countryName;
  final String jumlahPositif;
  final String jumlahSembuh;
  final String jumlahMeninggal;
  final bool isWorldwide;
  final Function onTap;

  InfoBox(
      {@required this.countryCode,
      @required this.countryName,
      @required this.jumlahMeninggal,
      @required this.jumlahPositif,
      @required this.jumlahSembuh,
      @required this.isWorldwide,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF222b45),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          )),
      width: double.infinity,
      height: device.height / 3.5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Visibility(
                      visible: !isWorldwide,
                      child: Flag(countryCode,
                          height: device.height * 0.03,
                          width: device.height * 0.045,
                          fit: BoxFit.fill),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      countryName,
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontFamily: "Poppins Bold",
                        color: Colors.white,
                        fontSize: device.height * 0.021,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Divider(
              color: Colors.grey,
              thickness: 1.5,
            ),
            SizedBox(height: 5.0),
            Container(
              height: device.height / 8,
              decoration: BoxDecoration(
                  color: Color(0xFF1f273d),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
              child: Container(
                  child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Positif',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: "Poppins SemiBold",
                            color: Color(0xFFffa825),
                            fontSize: device.height * 0.022,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          jumlahPositif,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: "Poppins Bold",
                            color: Colors.white,
                            fontSize: device.height * 0.025,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sembuh',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: "Poppins SemiBold",
                            color: Color(0xFF0fed9d),
                            fontSize: device.height * 0.022,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          jumlahSembuh,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: "Poppins Bold",
                            color: Colors.white,
                            fontSize: device.height * 0.025,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Meninggal',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: "Poppins SemiBold",
                            color: Color(0xFFff5252),
                            fontSize: device.height * 0.022,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          jumlahMeninggal,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: "Poppins Bold",
                            color: Colors.white,
                            fontSize: device.height * 0.025,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Detail',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontFamily: "Poppins Bold",
                          color: Color(0xFF3051ad),
                          fontSize: device.height * 0.018,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF3051ad),
                        size: device.height * 0.018,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
