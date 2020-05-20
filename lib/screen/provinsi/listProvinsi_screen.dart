import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid/bloc/provinsi/provinsi_bloc.dart';
import 'package:covid/widget/listDataCard.dart';
import 'package:covid/model/valueFormatter.dart';
import 'package:covid/screen/detail/detailCard_screen.dart';

class ListProvinsi extends StatefulWidget {
  @override
  _ListProvinsiState createState() => _ListProvinsiState();
}

class _ListProvinsiState extends State<ListProvinsi> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<ProvinsiBloc>(context).add(RefreshDataProvinsi());
        return _refreshCompleter.future;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Provinsi'),
        ),
        body: BlocConsumer<ProvinsiBloc, ProvinsiState>(
            listener: (context, state) {
          if (state is ProvinsiLoaded) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        }, builder: (context, state) {
          if (state is ProvinsiLoading)
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          else if (state is ProvinsiLoaded) {
            Formatter value = Formatter();

            return Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Expanded(
                    child: ListView.builder(
                        itemCount: state.dataProvinsi.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        itemBuilder: (context, index) {
                          var dataProvinsi =
                              state.dataProvinsi[index].attributes;

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
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailCard(
                                          namaDaerah: dataProvinsi.provinsi,
                                          jumlahAktif: jumlahAktif,
                                          jumlahMeninggal: jumlahMeninggal,
                                          jumlahPositif: jumlahPositif,
                                          jumlahSembuh: jumlahSembuh,
                                          percentAktif: percentAktif,
                                          percentMeninggal: percentMeninggal,
                                          percentSembuh: percentSembuh))),
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
