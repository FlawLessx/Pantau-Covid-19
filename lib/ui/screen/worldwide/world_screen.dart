import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/fecth_data/fetch_data_bloc.dart';
import '../../../core/util/value_formatter.dart';
import '../../../main.dart';
import '../../widget/infoBox.dart';
import '../../widget/listDataCard.dart';
import '../../widget/snackbar.dart';
import '../detail/detail_card_screen.dart';

class ListsData extends StatefulWidget {
  const ListsData({Key key}) : super(key: key);

  @override
  _ListsDataState createState() => _ListsDataState();
}

class _ListsDataState extends State<ListsData> {
  ScrollController _scrollController;
  Formatter value = Formatter();
  bool lastStatus = true;
  Completer<void> _refreshCompleter;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<FetchDataBloc>(context).add(GetDataFromAPI());
        return _refreshCompleter.future;
      },
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: isShrink ? Color(0xFF348b7b) : Colors.white,
                expandedHeight: device.height / 3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: isShrink
                      ? Text(
                          'Negara Teratas',
                          style: TextStyle(
                              fontFamily: 'Montserrat Bold', fontSize: 18.0),
                          textScaleFactor: 1.0,
                        )
                      : null,
                  background: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BlocConsumer<FetchDataBloc, FetchDataState>(
                      listener: (context, state) {
                        if (state is FetchDataLoaded) {
                          _refreshCompleter?.complete();
                          _refreshCompleter = Completer();
                        } else if (state is FetchDataError) {
                          Scaffold.of(context).showSnackBar(snackBar(context));
                        }
                      },
                      builder: (context, state) {
                        if (state is FetchDataLoading) {
                          return InfoBox(
                              onTap: null,
                              countryCode: 'ID',
                              countryName: 'Global',
                              jumlahMeninggal: 'Loading',
                              jumlahPositif: 'Loading',
                              jumlahSembuh: 'Loading',
                              isWorldwide: true);
                        } else if (state is FetchDataLoaded) {
                          var data = state.dataGlobalTotal;

                          var jumlahPositif = value.format(data.cases);
                          var jumlahSembuh = value.format(data.recovered);
                          var jumlahMeninggal = value.format(data.deaths);
                          var jumlahAktif = value.format(
                              (data.cases - data.recovered - data.deaths));
                          var percentAktif =
                              ((data.cases - data.recovered - data.deaths) /
                                  data.cases);
                          var percentSembuh = (data.recovered / data.cases);
                          var percentMeninggal = (data.deaths / data.cases);

                          return InfoBox(
                            countryCode: 'ID',
                            countryName: 'Global',
                            jumlahMeninggal: jumlahMeninggal,
                            jumlahPositif: jumlahPositif,
                            jumlahSembuh: jumlahSembuh,
                            isWorldwide: true,
                            onTap: () => Navigator.pushNamed(
                                context, detailCardRoute,
                                arguments: DetailCardArguments(
                                    namaDaerah: 'Global',
                                    jumlahAktif: jumlahAktif,
                                    jumlahMeninggal: jumlahMeninggal,
                                    jumlahPositif: jumlahPositif,
                                    jumlahSembuh: jumlahSembuh,
                                    percentAktif: percentAktif,
                                    percentMeninggal: percentMeninggal,
                                    percentSembuh: percentSembuh)),
                          );
                        } else {
                          return InfoBox(
                              onTap: null,
                              countryCode: 'ID',
                              countryName: 'Global',
                              jumlahMeninggal: 'Error',
                              jumlahPositif: 'Error',
                              jumlahSembuh: 'Error',
                              isWorldwide: true);
                        }
                      },
                    ),
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Visibility(
                      visible: isShrink ? false : true,
                      child: Text(
                        'Negara Teratas',
                        style: TextStyle(
                            fontFamily: 'Montserrat Bold',
                            fontSize: 14.0,
                            color: Color(0xFF348b7b)),
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: device.height * 0.02),
                BlocConsumer<FetchDataBloc, FetchDataState>(
                  listener: (context, state) {
                    if (state is FetchDataLoaded) {
                      _refreshCompleter?.complete();
                      _refreshCompleter = Completer();
                    } else if (state is FetchDataError) {
                      Scaffold.of(context).showSnackBar(snackBar(context));
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchDataLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is FetchDataLoaded) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: state.listDataGlobal.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0.0),
                              itemBuilder: (context, index) {
                                var dataNegara = state.listDataGlobal[index];

                                var jumlahMeninggal =
                                    value.format(dataNegara.totalDeaths);
                                var jumlahSembuh =
                                    value.format(dataNegara.totalRecovered);
                                var jumlahPositif =
                                    value.format(dataNegara.totalConfirmed);
                                var jumlahAktif = value.format(
                                    (dataNegara.totalConfirmed -
                                        dataNegara.totalRecovered -
                                        dataNegara.totalDeaths));
                                var percentAktif = ((dataNegara.totalConfirmed -
                                        dataNegara.totalRecovered -
                                        dataNegara.totalDeaths) /
                                    dataNegara.totalConfirmed);
                                var percentSembuh = (dataNegara.totalRecovered /
                                    dataNegara.totalConfirmed);
                                var percentMeninggal = (dataNegara.totalDeaths /
                                    dataNegara.totalConfirmed);

                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, detailCardRoute,
                                        arguments: DetailCardArguments(
                                            namaDaerah: dataNegara.country,
                                            jumlahAktif: jumlahAktif,
                                            jumlahMeninggal: jumlahMeninggal,
                                            jumlahPositif: jumlahPositif,
                                            jumlahSembuh: jumlahSembuh,
                                            percentAktif: percentAktif,
                                            percentMeninggal: percentMeninggal,
                                            percentSembuh: percentSembuh)),
                                    child: ListDataCard(
                                        countryName:
                                            state.listDataGlobal[index].country,
                                        jumlahMeninggal: jumlahMeninggal,
                                        jumlahPositif: jumlahPositif,
                                        jumlahSembuh: jumlahSembuh),
                                  ),
                                );
                              }));
                    } else {
                      return Center(
                          child: Column(
                        children: <Widget>[
                          Text(
                            'Gagal mengambil data \nTarik ke bawah untuk refresh',
                            style: TextStyle(fontFamily: 'Montserrat SemiBold'),
                          ),
                        ],
                      ));
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
