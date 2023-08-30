import 'package:flutter/material.dart';
import 'package:test_app2/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback? delete;
  final VoidCallback? onTap;
  final VoidCallback? add;

  const PokemonCard({
    Key? key,
    required this.pokemon,
    this.delete,
    this.onTap,
    this.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final m = MediaQuery.of(context);
    final w =
        m.orientation == Orientation.portrait ? m.size.width * 0.7 : 200.0;
    const lineheight = TextStyle(height: 1.5);

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Name and number
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(pokemon.name, style: const TextStyle(fontSize: 40)),
                    Text('#${pokemon.number ?? '--'}',
                        style: const TextStyle(fontSize: 20)),
                    if (delete != null)
                      FloatingActionButton(
                        onPressed: delete,
                        child: const Icon(Icons.clear),
                        mini: true,
                        elevation: 0.0,
                        backgroundColor:
                            const Color.fromARGB(255, 240, 125, 117),
                      ),
                    if (onTap != null)
                      FloatingActionButton(
                        onPressed: onTap,
                        child: const Icon(Icons.add),
                        mini: true,
                        elevation: 0.0,
                        backgroundColor: Colors.lightGreen,
                      ),
                  ],
                ),
              ),
            ),
            //Type
            Row(
              children: pokemon.types.map((e) => typeBubble(e)).toList(),
            ),
            if (pokemon.art?[0] == 'h')
              Image.network(pokemon.art!, width: w), //pokemon picture
            if (pokemon.art?[0] == 'F' && pokemon.custom != null)
              Image.file(pokemon.custom!),

            const SizedBox(height: 20.0),
            aboutTable(lineheight),
            const SizedBox(height: 8.0),

            // Container(BarGraph()),
          ],
        ),
      ),
    );
  }

  Widget typeBubble(PokemonType type) {
    final colorMap = <PokemonType, Color>{
      PokemonType.normal: const Color(0xFFA8A77A),
      PokemonType.fire: const Color(0XFFEE8130),
      PokemonType.water: const Color(0xff6390F0),
      PokemonType.grass: const Color(0xff7AC74C),
      PokemonType.electric: const Color(0xffF7D02C),
      PokemonType.ice: const Color(0xff96D9D6),
      PokemonType.fighting: const Color(0xffC22E28),
      PokemonType.poison: const Color(0xffA33EA1),
      PokemonType.ground: const Color(0xffE2BF65),
      PokemonType.flying: const Color(0xffA98FF3),
      PokemonType.psychic: const Color(0xffF95587),
      PokemonType.bug: const Color(0xffA6B91A),
      PokemonType.rock: const Color(0xffB6A136),
      PokemonType.ghost: const Color(0xff735797),
      PokemonType.dark: const Color(0xff705746),
      PokemonType.dragon: const Color(0xff6F35FC),
      PokemonType.steel: const Color(0xffB7B7CE),
      PokemonType.fairy: const Color(0xffD685AD),
    };

    final color = colorMap[type];
    if (color != null) {
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        margin: const EdgeInsets.all(7),
        child: Text(type.displayName),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      );
    }
    return Container();
  }

  Padding aboutTable(TextStyle lineheight) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Text(pokemon.description.toString()),
          const SizedBox(
            height: 20,
          ),
          Table(
            children: [
              TableRow(
                children: [
                  Text("Height", style: lineheight),
                  Text('${pokemon.height.toString()} m', style: lineheight)
                ],
              ),
              TableRow(
                children: [
                  Text("Weight", style: lineheight),
                  Text('${pokemon.weight.toString()} Kg', style: lineheight),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
