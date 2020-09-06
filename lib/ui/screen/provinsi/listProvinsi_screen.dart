import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/fecth_data/fetch_data_bloc.dart';
import '../../../core/util/value_formatter.dart';
import '../../../main.dart';
import '../../widget/listDataCard.dart';
import '../detail/detail_card_screen.dart';

class ListProvinsi extends StatefulWidget {
  @override
  _ListProvinsiState createState() => _ListProvinsiState();
}

class _ListProvinsiState extends State<ListProvinsi> {
  Completer<void> _refreshCompleter;
  Formatter value = Formatter();

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<FetchDataBloc>(context).add(GetDataFromAPI());
        return _refreshCompleter.future;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Provinsi'),
        ),
        body: BlocConsumer<FetchDataBloc, FetchDataState>(
            listener: (context, state) {
          if (state is FetchDataLoaded) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        }, builder: (context, state) {
          if (state is FetchDataLoading)
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          else if (state is FetchDataLoaded) {
            return Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Expanded(
                    child: ListView.builder(
                        itemCount: state.listDataProvinsi.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        itemBuilder: (context, index) {
                          var dataProvinsi =
                              state.listDataProvinsi[index].attributes;

                          var jumlahMeninggal =
                              value.format(dataProvinsi.kasusMeni);
                          var jumlahSembuh =
                              value.format(dataProvinsi.kasusSemb);
                          var jumlahPositif =
                              value.format(dataProvinsi.kasusPosi);
                          var jumlahAktif = value.format(
                              (dataProvinsi.kasusPosi -
                                  dataProvinsi.kasusSemb -
                                  dataProvinsi.kasusMeni));
                          var percentAktif = ((dataProvinsi.kasusPosi -
                                  dataProvinsi.kasusSemb -
                                  dataProvinsi.kasusMeni) /
                              dataProvinsi.kasusPosi);
                          var percentSembuh =
                              (dataProvinsi.kasusMeni / dataProvinsi.kasusPosi);
                          var percentMeninggal =
                              (dataProvinsi.kasusMeni / dataProvinsi.kasusPosi);

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15.0),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, detailCardRoute,
                                  arguments: DetailCardArguments(
                                      namaDaerah: dataProvinsi.provinsi,
                                      jumlahAktif: jumlahAktif,
                                      jumlahMeninggal: jumlahMeninggal,
                                      jumlahPositif: jumlahPositif,
                                      jumlahSembuh: jumlahSembuh,
                                      percentAktif: percentAktif,
                                      percentMeninggal: percentMeninggal,
                                      percentSembuh: percentSembuh)),
                              child: ListDataCard(
                                  countryName: dataProvinsi.provinsi,
                                  jumlahMeninggal: jumlahMeninggal,
                                  jumlahPositif: jumlahPositif,
                                  jumlahSembuh: jumlahSembuh),
                            ),
                          );
                        })),
              ],
            );
          } else {
            return Container(child: Center(child: Text('Failed load data')));
          }
        }),
      ),
    );
  }
}
