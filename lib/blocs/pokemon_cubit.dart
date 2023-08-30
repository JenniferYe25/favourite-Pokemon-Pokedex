import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:test_app2/models/pokemon.dart';

class PokemonCubit extends HydratedCubit<List<Pokemon>> {
  PokemonCubit() : super([]);

  void add(Pokemon pokemon) => emit([...state, pokemon]);
  void delete(Pokemon pokemon) {
    emit(state.where((e) => e != pokemon).toList());
  }

  bool contains(Pokemon pokemon) => state.contains(pokemon) ? true : false;

  @override
  List<Pokemon>? fromJson(Map<String, dynamic> json) {
    final st = (json['pokemons'] as List<dynamic>)
        .map((m) => Pokemon.fromHidratedMap(m as Map<String, dynamic>))
        .toList();

    return st;
  }

  @override
  Map<String, dynamic>? toJson(List<Pokemon> state) {
    final mp = {
      'pokemons': state.map((e) => e.toHidratedMap()).toList(),
    };

    return mp;
  }
}
