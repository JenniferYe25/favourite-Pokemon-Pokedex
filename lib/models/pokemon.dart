import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Pokemon {
  final String? art; //image url
  final String name;
  final int? number;
  final List<PokemonType> types;
  final double? weight;
  final double? height;
  final List? stats;
  final File? custom;
  final String? description;
  final bool? isLegendary;
  final bool? isMythical;

  const Pokemon({
    required this.name,
    this.art,
    this.number,
    this.types = const [],
    this.weight,
    this.height,
    this.stats,
    this.custom,
    this.description,
    this.isLegendary,
    this.isMythical,
  });

  Map<String, dynamic> toHidratedMap() {
    return <String, dynamic>{
      'art': art,
      'number': number,
      'weight': weight,
      'height': height,
      'types': types.map((e) => e.name).toList(),
      'name': name,
    };
  }

  static Pokemon fromHidratedMap(Map<String, dynamic> map) {
    return Pokemon(
      art: map['art'] as String?,
      number: map['number'] as int?,
      weight: map['weight'] as double?,
      height: map['height'] as double?,
      types: (map['types'] as List<dynamic>)
          .map<PokemonType>(
            (e) => PokemonType.values.firstWhere((v) => v.name == e),
          )
          .toList(),
      name: map['name'] as String,
    );
  }

  static Pokemon fromMap(Map mapDetail, Map mapBasic) {
    String des = '';
    String finalname = '';

    final types = (mapBasic['types'] as List<dynamic>)
        .map<String>((t) => t['type']['name'] as String)
        .map<PokemonType>(
          (e) => PokemonType.values.firstWhere((v) => v.name == e),
        )
        .toList();

    final statName = (mapBasic['stats'] as List<dynamic>)
        .map<String>((t) => t['stat']['name'] as String);

    final statVal = (mapBasic['stats'] as List<dynamic>)
        .map<int>((t) => t['base_stat'] as int);

    final stat = Map.fromIterables(statName, statVal);

    for (Map map in mapDetail['flavor_text_entries']) {
      if (map['language']['name'] == 'en') {
        des = map['flavor_text'].toString().replaceAll('\n', ' ');
        break;
      }
    }

    if (mapBasic['name'].toString().contains('-')) {
      String temp = mapBasic['name'].toString();
      finalname = temp.substring(0, temp.indexOf('-'));
    } else {
      finalname = mapBasic['name'].toString();
    }

    const String legedary = '✨';
    const String mythical = '🌟';
    String special = '';

    if (mapDetail['is_legendary']) {
      special = legedary;
    } else if (mapDetail['is_mythical'] == true) {
      special = mythical;
    }

    return Pokemon(
      art: mapBasic['sprites']['other']['official-artwork']['front_default']
          as String,
      name: special + finalname.toTitleCase() + special,
      number: mapBasic['id'] as int,
      types: types,
      weight: (mapBasic['weight'] as int) / 10,
      height: (mapBasic['height'] as int) / 10,
      description: des,
      isLegendary: mapDetail['is_legendary'],
      isMythical: mapDetail['is_mythical'],
    );
  }

  static Future<Pokemon?> getData(String name) async {
    const String basicUrl = 'https://pokeapi.co/api/v2';
    const String basic = 'pokemon';
    const String detail = 'pokemon-species';
    try {
      final String basicEndpoint = '$basicUrl/$basic/${name.toLowerCase()}';
      final String detailEndpoint = '$basicUrl/$detail/${name.toLowerCase()}';
      final basicResponse = await http.get(Uri.parse(basicEndpoint));
      final detailResponse = await http.get(Uri.parse(detailEndpoint));

      return Pokemon.fromMap(
          jsonDecode(detailResponse.body), jsonDecode(basicResponse.body));
    } catch (e) {
      // print('error: $e');
    }

    return null;
  }
}

enum PokemonType {
  normal,
  fire,
  water,
  grass,
  electric,
  ice,
  fighting,
  poison,
  ground,
  flying,
  psychic,
  bug,
  rock,
  ghost,
  dark,
  dragon,
  steel,
  fairy,
}

extension PokemonTypeExtension on PokemonType {
  String get displayName => name.toTitleCase();
}

extension StringExtension on String {
  String toTitleCase() {
    return this[0].toUpperCase() + substring(1);
  }
}
