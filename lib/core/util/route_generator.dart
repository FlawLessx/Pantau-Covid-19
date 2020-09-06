import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../main.dart';
import '../../ui/screen/detail/detail_card_screen.dart';
import '../../ui/screen/home/home_screen.dart';
import '../../ui/screen/provinsi/listProvinsi_screen.dart';
import '../../ui/screen/splashscreen/splash_screen.dart';

class RouteGenerator {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenRoute:
        return MaterialPageRoute(
            builder: (_) => SplashScreen(), settings: settings);
        break;
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => MyHomePage(), settings: settings);
        break;
      case provinsiRoute:
        return MaterialPageRoute(
            builder: (_) => ListProvinsi(), settings: settings);
        break;

      case detailCardRoute:
        final args = settings.arguments as DetailCardArguments;
        return MaterialPageRoute(
            builder: (_) => DetailCard(
                jumlahAktif: args.jumlahAktif,
                jumlahMeninggal: args.jumlahMeninggal,
                jumlahPositif: args.jumlahPositif,
                jumlahSembuh: args.jumlahSembuh,
                percentAktif: args.percentAktif,
                percentMeninggal: args.percentMeninggal,
                percentSembuh: args.percentSembuh,
                namaDaerah: args.namaDaerah),
            settings: settings);
        break;
      case moreInfoRoute:
        return MaterialPageRoute(
            builder: (_) => WebviewScaffold(
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
            settings: settings);
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ),
            settings: settings);
    }
  }
}
