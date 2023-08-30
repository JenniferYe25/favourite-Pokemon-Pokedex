import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app2/blocs/pokemon_cubit.dart';
import 'package:test_app2/screens/pokemon_list.dart';
import 'package:test_app2/screens/splash.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokemonCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Splash(),
          '/home': (context) =>
              const PokemonList(title: 'Favourite Only Pokedex'),
        },
      ),
    );
  }
}
