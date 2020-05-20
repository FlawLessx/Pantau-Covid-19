import 'package:flutter/material.dart';

class BannerLeft extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  BannerLeft({
    @required this.image,
    @required this.onTap,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Container(
      height: device.height / 5,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color(0xFFebf4f3),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                )),
            width: double.infinity,
            height: device.height / 6.5,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        width: device.width / 2,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: "Montserrat Bold",
                            color: Color(0xFF267466),
                            fontSize: 15.0,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    GestureDetector(
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Container(
                                height: 5.0,
                                width: 50.0,
                                color: Color(0xCC15aa8d)),
                          ),
                          GestureDetector(
                            onTap: onTap,
                            child: Text(
                              'Klik disini...',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontFamily: "Montserrat SemiBold",
                                color: Color(0xFF267466),
                                fontSize: device.height * 0.015,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      height: device.height / 5,
                      child: Image.asset(
                        image,
                        filterQuality: FilterQuality.high,
                      )),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: device.height * 0.04,
                child: Image.asset(
                  'src/img/covid.png',
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
