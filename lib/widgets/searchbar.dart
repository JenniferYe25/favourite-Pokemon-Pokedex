import 'package:flutter/material.dart';
import 'package:test_app2/widgets/search.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  onTap: () =>
                      showSearch(context: context, delegate: Search('all')),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      hintText: 'Name or Pokedex number',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 18),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
