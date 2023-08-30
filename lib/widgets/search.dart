import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app2/blocs/pokemon_cubit.dart';
import 'package:test_app2/models/pokemon.dart';
import 'package:test_app2/widgets/pokemon_card.dart';
import 'dart:math';

class Search extends SearchDelegate {
  Search(this.searchType);
  final String searchType;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isNotEmpty) {
              query = '';
            } else {
              close(context, null);
            }
          },
          icon: const Icon(
            Icons.clear,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final pokemons = context.read<PokemonCubit>().state;
    if (searchType == 'all') {
      return FutureBuilder<Pokemon?>(
        future: Pokemon.getData(query.toLowerCase()),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data != null) {
            return ListView(children: [
              PokemonCard(
                pokemon: data,
                onTap: pokemons.map((e) => e.name).contains(data.name)
                    ? null
                    : () {
                        context.read<PokemonCubit>().add(data);
                        Navigator.of(context).pop();
                      },
              ),
            ]);
          }

          return const Center(child: Text('Nothing found'));
        },
      );
    }
    return FutureBuilder<Pokemon?>(
      future: Pokemon.getData(query.toLowerCase()),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null && pokemons.map((e) => e.name).contains(data.name)) {
          return ListView(children: [
            PokemonCard(
              pokemon: data,
            ),
          ]);
        }

        return const Center(child: Text('No favourite Pokemon'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final pokemons = context.read<PokemonCubit>().state;
    List<String> sug = [];
    int suggestCount = 5;

    if (searchType == 'all') {
      sug = List<String>.generate(
          suggestCount, (int index) => Random().nextInt(898).toString(),
          growable: false);
    } else {
      sug = pokemons.map((e) => e.name.toTitleCase()).toList();
      if (sug.length != suggestCount) {
        for (int i = sug.length - 1; i < suggestCount; i++) {
          sug.add('');
        }
      }
    }

    return ListView.builder(
      itemCount: suggestCount,
      itemBuilder: (context, index) {
        final suggestion = sug[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
          },
        );
      },
    );
  }
}
