import 'package:covid/screen/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid/bloc/global/global_bloc.dart';
import 'package:covid/bloc/globalTotal/globaltotal_bloc.dart';
import 'package:covid/bloc/indo/indo_bloc.dart';
import 'package:covid/bloc/provinsi/provinsi_bloc.dart';
import 'package:covid/resources/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final IndoBloc _indoBloc = IndoBloc(Repository());
  final GlobaltotalBloc _globaltotalBloc = GlobaltotalBloc(Repository());
  final ProvinsiBloc _provinsiBloc = ProvinsiBloc(Repository());
  final GlobalBloc _globalBloc = GlobalBloc(Repository());

  @override
  void initState() {
    _indoBloc.add(GetDataIndo());
    _provinsiBloc.add(GetDataProvinsi());
    _globaltotalBloc.add(GetDataGlobalTotal());
    _globalBloc.add(GetDataGlobal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IndoBloc>(create: (context) => _indoBloc),
        BlocProvider<GlobaltotalBloc>(create: (context) => _globaltotalBloc),
        BlocProvider<ProvinsiBloc>(
          create: (context) => _provinsiBloc,
        ),
        BlocProvider<GlobalBloc>(
          create: (context) => _globalBloc,
        )
      ],
      child: MaterialApp(
        title: 'Pantau Covid-19',
        theme: ThemeData(
          fontFamily: 'Montserrat Bold',
          primaryColor: Color(0xFF348b7b),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
