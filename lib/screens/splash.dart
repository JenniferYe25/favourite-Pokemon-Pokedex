import 'package:flutter/material.dart';
import 'package:test_app2/screens/pokemon_list.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _LoadingState();
}

class _LoadingState extends State<Splash> {
  void getData() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PokemonList(title: "Favourite Only Pokedex"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final m = MediaQuery.of(context);
    final w = m.orientation == Orientation.portrait ? m.size.width / 2 : 200.0;

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Image.asset('assets/pokeball.png', width: w), //pokemon picture
        ),
      ),
    );
  }
}
