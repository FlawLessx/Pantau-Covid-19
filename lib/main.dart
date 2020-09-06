import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/fecth_data/fetch_data_bloc.dart';
import 'core/resources/repository.dart';
import 'core/util/route_generator.dart';
import 'ui/screen/splashscreen/splash_screen.dart';

//
// ROUTE VARIABLES
//
const String splashScreenRoute = '/';
const String homeRoute = '/home';
const String provinsiRoute = '/provinsi';
const String detailCardRoute = '/detail';
const String moreInfoRoute = '/moreInfo';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FetchDataBloc _fecthDataBloc = FetchDataBloc(Repository());

  @override
  void initState() {
    _fecthDataBloc.add(GetDataFromAPI());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchDataBloc>(create: (context) => _fecthDataBloc),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator().onGenerateRoute,
        initialRoute: splashScreenRoute,
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
