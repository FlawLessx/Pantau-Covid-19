import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/fecth_data/fetch_data_bloc.dart';
import '../../../core/model/carousell_card_model.dart';
import '../../../core/util/value_formatter.dart';
import '../../../main.dart';

import '../../widget/banner.dart';
import '../../widget/carousell_card_widget.dart';
import '../../widget/infoBox.dart';
import '../detail/detail_card_screen.dart';

class IndoPage extends StatefulWidget {
  @override
  _IndoPageState createState() => _IndoPageState();
}

class _IndoPageState extends State<IndoPage> {
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
        BlocProvider.of<FetchDataBloc>(context).add(GetDataFromAPI());
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
                    onTap: () => Navigator.pushNamed(context, moreInfoRoute),
                    title: 'Cari Tahu Lebih Lanjut \nMengenai Covid-19'),
                SizedBox(height: device.height * 0.03),
                BlocConsumer<FetchDataBloc, FetchDataState>(
                  listener: (context, state) {
                    if (state is FetchDataLoaded) {
                      _refreshCompleter?.complete();
                      _refreshCompleter = Completer();
                    } else if (state is FetchDataError) {
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
                    if (state is FetchDataLoading) {
                      return InfoBox(
                          onTap: null,
                          countryCode: 'ID',
                          countryName: 'Indonesia',
                          jumlahMeninggal: 'Loading',
                          jumlahPositif: 'Loading',
                          jumlahSembuh: 'Loading',
                          isWorldwide: false);
                    } else if (state is FetchDataLoaded) {
                      var dataIndo = state.dataIndoTotal;
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
                        jumlahMeninggal: state.dataIndoTotal.meninggal,
                        jumlahPositif: state.dataIndoTotal.positif,
                        jumlahSembuh: state.dataIndoTotal.sembuh,
                        isWorldwide: false,
                        onTap: () => Navigator.pushNamed(
                            context, detailCardRoute,
                            arguments: DetailCardArguments(
                                namaDaerah: 'Indonesia',
                                jumlahAktif: jumlahAktif,
                                jumlahMeninggal: dataIndo.meninggal,
                                jumlahPositif: dataIndo.positif,
                                jumlahSembuh: dataIndo.sembuh,
                                percentAktif: percentAktif,
                                percentMeninggal: percentMeninggal,
                                percentSembuh: percentSembuh)),
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
                      onTap: () => Navigator.pushNamed(context, provinsiRoute),
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
                BlocConsumer<FetchDataBloc, FetchDataState>(
                  listener: (context, state) {
                    if (state is FetchDataLoaded) {
                      _refreshCompleter?.complete();
                      _refreshCompleter = Completer();
                    } else if (state is FetchDataError) {
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
                    if (state is FetchDataLoading)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else if (state is FetchDataLoaded) {
                      return Container(
                        height: device.height / 4,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0.0),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              int count = data.getIndexValue(index);
                              var dataIndo =
                                  state.listDataProvinsi[index].attributes;

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
                                  onTap: () => Navigator.pushNamed(
                                      context, detailCardRoute,
                                      arguments: DetailCardArguments(
                                          namaDaerah: dataIndo.provinsi,
                                          jumlahAktif: jumlahAktif,
                                          jumlahMeninggal: jumlahMeninggal,
                                          jumlahPositif: jumlahPositif,
                                          jumlahSembuh: jumlahSembuh,
                                          percentAktif: percentAktif,
                                          percentMeninggal: percentMeninggal,
                                          percentSembuh: percentSembuh)),
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
