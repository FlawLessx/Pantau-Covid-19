import 'package:flutter/material.dart';

class ListDataCard extends StatelessWidget {
  const ListDataCard({
    Key key,
    @required this.countryName,
    @required this.jumlahMeninggal,
    @required this.jumlahPositif,
    @required this.jumlahSembuh,
  }) : super(key: key);

  final String countryName;
  final String jumlahPositif;
  final String jumlahSembuh;
  final String jumlahMeninggal;

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Container(
      height: device.height / 7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color(0xFFebf4f3)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                
                Text(
                  countryName,
                  style: TextStyle(
                      fontFamily: 'Montserrat Bold',
                      fontSize: device.height * 0.021,
                      color: Color(0xFF348b7b)),
                  textScaleFactor: 1.0,
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Positif',
                      style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: device.height * 0.02,
                          color: Color(0xFFffa825)),
                      textScaleFactor: 1.0,
                    ),
                    Text(
                      jumlahPositif,
                      style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: device.height * 0.02,
                          color: Color(0xFFffa825)),
                      textScaleFactor: 1.0,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Sembuh',
                      style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: device.height * 0.02,
                          color: Color(0xFF15aa8d)),
                      textScaleFactor: 1.0,
                    ),
                    Text(
                      jumlahSembuh,
                      style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: device.height * 0.02,
                          color: Color(0xFF15aa8d)),
                      textScaleFactor: 1.0,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Meninggal',
                      style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: device.height * 0.02,
                          color: Color(0xFFe56267)),
                      textScaleFactor: 1.0,
                    ),
                    Text(
                      jumlahMeninggal,
                      style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: device.height * 0.02,
                          color: Color(0xFFe56267)),
                      textScaleFactor: 1.0,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
