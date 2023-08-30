import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app2/blocs/pokemon_cubit.dart';
import 'package:test_app2/screens/add.dart';
import 'package:test_app2/widgets/search.dart';
import 'package:test_app2/widgets/pokemon_card.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key, required this.title, this.names})
      : super(key: key);

  final String title;
  final List? names;

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    final pokemons = context.watch<PokemonCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search('list'));
            },
            icon: const Icon(Icons.search),
            splashColor: Colors.transparent,
            splashRadius: 0.1,
          )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: pokemons
              .map((e) => PokemonCard(
                  pokemon: e,
                  delete: () {
                    context.read<PokemonCubit>().delete(e);
                  }))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Adder()));
        },
        tooltip: 'New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
