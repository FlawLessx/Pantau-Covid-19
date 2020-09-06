import 'package:covid/core/bloc/fecth_data/fetch_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget snackBar(BuildContext context) => SnackBar(
      content: Text('Gagal mengambil data'),
      action: SnackBarAction(
        label: 'Refresh',
        onPressed: () => BlocProvider.of(context).add(GetDataFromAPI()),
      ),
    );
