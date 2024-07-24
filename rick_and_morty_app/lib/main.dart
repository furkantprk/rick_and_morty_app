import 'package:api_veri/product/database/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:api_veri/feature/characters/bloc/characters_page_bloc.dart';
import 'package:api_veri/feature/locations/bloc/locations_page_bloc.dart';
import 'package:api_veri/feature/home_page/view_model/home_page_view_model.dart';
import 'package:api_veri/product/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveManager().initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageViewModel()),
        BlocProvider<CharactersBloc>(create: (context) => CharactersBloc()),
        BlocProvider<LocationsPageBloc>(
            create: (context) => LocationsPageBloc()),
      ],
      child: MaterialApp.router(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        routerConfig: goRouter,
      ),
    );
  }
}
