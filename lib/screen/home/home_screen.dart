import 'dart:async';
import 'package:covid/bloc/indo/indo_bloc.dart';
import 'package:covid/bloc/provinsi/provinsi_bloc.dart';
import 'package:covid/model/carousellcard_model.dart';
import 'package:covid/model/valueFormatter.dart';
import 'package:covid/screen/detail/detailCard_screen.dart';
import 'package:covid/screen/provinsi/listProvinsi_screen.dart';
import 'package:covid/widget/banner.dart';
import 'package:covid/screen/worldwide/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:covid/model/tab_model.dart';
import 'package:covid/widget/infoBox.dart';
import 'package:covid/widget/carousellcard_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:route_transitions/route_transitions.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage;
  String currentTitle;
  Color currentColor;

  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> listPage = [
    Home(),
    ListsData(
      key: PageStorageKey('Page 2'),
    )
  ];

  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          bottomNavigationBar: CubertoBottomBar(
            inactiveIconColor: Color(0xFF267466),
            tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
            selectedTab:
                currentPage, // By default its NO_DRAWER (Availble START_DRAWER and END_DRAWER as per where you want to how the drawer icon in Cuberto Bottom bar)
            tabs: tabs
                .map((value) => TabData(
                    iconData: value.icon,
                    title: value.title,
                    tabColor: value.color,
                    tabGradient: value.gradient))
                .toList(),
            onTabChangedListener: (position, title, color) {
              setState(() {
                currentPage = position;
                currentTitle = title;
                currentColor = color;
              });
            },
          ),
          body: PageStorage(
              bucket: bucket, child: SafeArea(child: listPage[currentPage]))),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CardSource data = CardSource();
  Formatter value = Formatter();
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<IndoBloc>(context).add(RefreshDataIndo());
        BlocProvider.of<ProvinsiBloc>(context).add(RefreshDataProvinsi());
        return _refreshCompleter.future;
      },
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: device.height * 0.02,
                ),
                BannerLeft(
                    image: 'src/img/person2.png',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => new WebviewScaffold(
                          url: 'https://covid19.go.id/tanya-jawab',
                          appBar: new AppBar(
                            title: const Text('Info Covid-19'),
                          ),
                          withZoom: true,
                          withLocalStorage: true,
                          hidden: true,
                          initialChild: Container(
                            color: Colors.white,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ));
                    },
                    title: 'Cari Tahu Lebih Lanjut \nMengenai Covid-19'),
                SizedBox(height: device.height * 0.03),
                BlocConsumer<IndoBloc, IndoState>(
                  listener: (context, state) {
                    if (state is IndoLoaded) {
                      _refreshCompleter?.complete();
                      _refreshCompleter = Completer();
                    } else if (state is IndoError) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Tarik ke bawah untuk mengambil ulang data'),
                        action: SnackBarAction(
                          label: 'Refresh',
                          onPressed: () {},
                        ),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is IndoLoading) {
                      return InfoBox(
                          onTap: null,
                          countryCode: 'ID',
                          countryName: 'Indonesia',
                          jumlahMeninggal: 'Loading',
                          jumlahPositif: 'Loading',
                          jumlahSembuh: 'Loading',
                          isWorldwide: false);
                    } else if (state is IndoLoaded) {
                      var dataIndo = state.dataIndo;
                      int positif = int.parse(dataIndo.positif
                          .replaceAll(new RegExp(r'[^\w\s]+'), ''));
                      int sembuh = int.parse(dataIndo.sembuh
                          .replaceAll(new RegExp(r'[^\w\s]+'), ''));
                      int meninggal = int.parse(dataIndo.meninggal
                          .replaceAll(new RegExp(r'[^\w\s]+'), ''));

                      var jumlahAktif =
                          value.format((positif - sembuh - meninggal));
                      var percentAktif =
                          ((positif - sembuh - meninggal) / positif);
                      var percentSembuh = (sembuh / positif);
                      var percentMeninggal = (meninggal / positif);

                      return InfoBox(
                        countryCode: 'ID',
                        countryName: 'Indonesia',
                        jumlahMeninggal: state.dataIndo.meninggal,
                        jumlahPositif: state.dataIndo.positif,
                        jumlahSembuh: state.dataIndo.sembuh,
                        isWorldwide: false,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DetailCard(
                                  namaDaerah: 'Indonesia',
                                  jumlahAktif: jumlahAktif,
                                  jumlahMeninggal: dataIndo.meninggal,
                                  jumlahPositif: dataIndo.positif,
                                  jumlahSembuh: dataIndo.sembuh,
                                  percentAktif: percentAktif,
                                  percentMeninggal: percentMeninggal,
                                  percentSembuh: percentSembuh)));
                        },
                      );
                    } else {
                      return InfoBox(
                          onTap: null,
                          countryCode: 'ID',
                          countryName: 'Indonesia',
                          jumlahMeninggal: 'Error',
                          jumlahPositif: 'Error',
                          jumlahSembuh: 'Error',
                          isWorldwide: false);
                    }
                  },
                ),
                SizedBox(height: device.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Provinsi Teratas',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontFamily: "Montserrat Bold",
                        color: Color(0xFF267466),
                        fontSize: 15.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListProvinsi())),
                      child: Text(
                        'Lihat Semua',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontFamily: "Montserrat SemiBold",
                          color: Color(0xFF267466),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                BlocConsumer<ProvinsiBloc, ProvinsiState>(
                  listener: (context, state) {
                    if (state is ProvinsiLoaded) {
                      _refreshCompleter?.complete();
                      _refreshCompleter = Completer();
                    } else if (state is ProvinsiError) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Tarik ke bawah untuk mengambil ulang data'),
                        action: SnackBarAction(
                          label: 'Refresh',
                          onPressed: () {},
                        ),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is ProvinsiLoading)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else if (state is ProvinsiLoaded) {
                      return Container(
                        height: device.height / 4,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0.0),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              int count = data.getIndexValue(index);
                              var dataIndo =
                                  state.dataProvinsi[index].attributes;

                              var jumlahPositif =
                                  value.format(dataIndo.kasusPosi);
                              var jumlahSembuh =
                                  value.format(dataIndo.kasusSemb);
                              var jumlahMeninggal =
                                  value.format(dataIndo.kasusMeni);
                              var jumlahAktif = value.format(
                                  (dataIndo.kasusPosi -
                                      dataIndo.kasusSemb -
                                      dataIndo.kasusMeni));
                              var percentAktif = ((dataIndo.kasusPosi -
                                      dataIndo.kasusSemb -
                                      dataIndo.kasusMeni) /
                                  dataIndo.kasusPosi);
                              var percentSembuh =
                                  (dataIndo.kasusSemb / dataIndo.kasusPosi);
                              var percentMeninggal =
                                  (dataIndo.kasusMeni / dataIndo.kasusPosi);
                              final colorBox =
                                  data.listCardProvince[count].colorBox;
                              final image = data.listCardProvince[count].image;

                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 5.0, bottom: 5.0),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => DetailCard(
                                              namaDaerah: dataIndo.provinsi,
                                              jumlahAktif: jumlahAktif,
                                              jumlahMeninggal: jumlahMeninggal,
                                              jumlahPositif: jumlahPositif,
                                              jumlahSembuh: jumlahSembuh,
                                              percentAktif: percentAktif,
                                              percentMeninggal:
                                                  percentMeninggal,
                                              percentSembuh: percentSembuh))),
                                  child: CardWidget(
                                    colorBox: colorBox,
                                    image: image,
                                    namaDaerah: dataIndo.provinsi,
                                    jumlahPositif: jumlahPositif,
                                  ),
                                ),
                              );
                            }),
                      );
                    } else
                      return Container(
                          child: Center(
                              child: Text(
                        'Gagal mengambil data \nTarik ke bawah untuk refresh',
                        style: TextStyle(fontFamily: 'Montserrat SemiBold'),
                      )));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
