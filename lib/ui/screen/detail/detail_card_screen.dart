import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/banner.dart';
import '../../widget/statistic.dart';

class DetailCardArguments {
  final String namaDaerah;
  final String jumlahPositif;
  final String jumlahSembuh;
  final String jumlahMeninggal;
  final String jumlahAktif;
  final double percentAktif;
  final double percentSembuh;
  final double percentMeninggal;

  DetailCardArguments(
      {@required this.jumlahAktif,
      @required this.jumlahMeninggal,
      @required this.jumlahPositif,
      @required this.jumlahSembuh,
      @required this.percentAktif,
      @required this.percentMeninggal,
      @required this.percentSembuh,
      @required this.namaDaerah});
}

class DetailCard extends StatefulWidget {
  final String namaDaerah;
  final String jumlahPositif;
  final String jumlahSembuh;
  final String jumlahMeninggal;
  final String jumlahAktif;
  final double percentAktif;
  final double percentSembuh;
  final double percentMeninggal;

  DetailCard(
      {@required this.jumlahAktif,
      @required this.jumlahMeninggal,
      @required this.jumlahPositif,
      @required this.jumlahSembuh,
      @required this.percentAktif,
      @required this.percentMeninggal,
      @required this.percentSembuh,
      @required this.namaDaerah});

  @override
  _DetailCardState createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFF348b7b),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 30.0,
                      width: 30.0,
                      child: Center(
                          child:
                              Icon(Icons.chevron_left, color: Colors.white54)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: Colors.white54))),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.namaDaerah,
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontFamily: "Montserrat Bold",
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.jumlahPositif,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontFamily: "Montserrat SemiBold",
                            color: Colors.white,
                            fontSize: 45.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(Icons.arrow_upward, color: Colors.white54)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: device.height * 0.75,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Detail Kasus',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontFamily: "Montserrat Bold",
                              color: Color(0xFF267466),
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      IndexedStack(
                        index: _currentIndex,
                        children: <Widget>[
                          StatisticKasus(
                            colorTextCategory: Color(0xFFffa825),
                            colorBox: Color(0xCCebf4f3),
                            jumlahCategory: widget.jumlahAktif,
                            jumlahPositif: widget.jumlahPositif,
                            percent: widget.percentAktif,
                            percentText:
                                '${(widget.percentAktif * 100).round()}%',
                            tipeCategory: 'Aktif',
                            image: 'src/img/orange_linechart.png',
                            colorArrow: Color(0xFFfcac42),
                          ),
                          StatisticKasus(
                            colorBox: Color(0xFFebf4f3),
                            colorTextCategory: Color(0xFF15aa8d),
                            jumlahCategory: widget.jumlahSembuh,
                            jumlahPositif: widget.jumlahPositif,
                            percent: widget.percentSembuh,
                            percentText:
                                '${(widget.percentSembuh * 100).round()}%',
                            tipeCategory: 'Sembuh',
                            image: 'src/img/green_linechart.png',
                            colorArrow: Color(0xFF15aa8d),
                          ),
                          StatisticKasus(
                            colorBox: Color(0xFFfaeaeb),
                            colorTextCategory: Color(0xFF4d1a1f),
                            jumlahCategory: widget.jumlahMeninggal,
                            jumlahPositif: widget.jumlahPositif,
                            percent: widget.percentMeninggal,
                            percentText:
                                '${(widget.percentMeninggal * 100).round()}%',
                            tipeCategory: 'Meninggal',
                            image: 'src/img/red_linechart.png',
                            colorArrow: Color(0xFFe56267),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            color:
                                _currentIndex == 0 ? Color(0xCCebf4f3) : null,
                            onPressed: () {
                              setState(() {
                                _currentIndex = 0;
                              });
                            },
                            child: Text(
                              'Aktif',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontFamily: "Poppins SemiBold",
                                color: _currentIndex == 0
                                    ? Color(0xFF267466)
                                    : Color(0xB3267466),
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          FlatButton(
                            color:
                                _currentIndex == 1 ? Color(0xCCebf4f3) : null,
                            onPressed: () {
                              setState(() {
                                _currentIndex = 1;
                              });
                            },
                            child: Text(
                              'Sembuh',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontFamily: "Poppins SemiBold",
                                color: _currentIndex == 1
                                    ? Color(0xFF267466)
                                    : Color(0xB3267466),
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          FlatButton(
                            color:
                                _currentIndex == 2 ? Color(0xCCebf4f3) : null,
                            onPressed: () {
                              setState(() {
                                _currentIndex = 2;
                              });
                            },
                            child: Text(
                              'Meninggal',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontFamily: "Poppins SemiBold",
                                color: _currentIndex == 2
                                    ? Color(0xFF267466)
                                    : Color(0xB3267466),
                                fontSize: 13.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      BannerLeft(
                          image: 'src/img/doctor.png',
                          onTap: () async {
                            final _url =
                                'https://kitabisa.com/campaign/melawancoronavirus';
                            if (await canLaunch(_url))
                              await launch(_url);
                            else
                              throw 'Gagal menjalankan $_url';
                          },
                          title:
                              'Yuk Donasi Untuk \nMasyarakat Yang \nTerdampak Covid-19'),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
