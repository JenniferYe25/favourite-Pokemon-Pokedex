import 'package:flutter/material.dart';
import 'package:test_app2/widgets/ManualMenu.dart';

import '../widgets/searchbar.dart';

class Adder extends StatelessWidget {
  const Adder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Search', 'Manuel'];

    return DefaultTabController(
      length: tabs.length, // This is the group of tabs.
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('New Pokémon'),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: tabs.map((String name) => Tab(text: name)).toList(),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              SearchBar(),
              ManualMenu(),
            ],
          ),
        ),
      ),
    );
  }
}

class ManualMenu extends StatefulWidget {
  const ManualMenu({Key? key}) : super(key: key);

  @override
  State<ManualMenu> createState() => ManualMenuState();
}

extension IterableExtension on Iterable {
  List<List<T>> chunkBy<T>(int group) {
    final typeList = <List<T>>[];
    var temp = <T>[];

    for (final ele in this) {
      if (temp.length != group) {
        temp.add(ele);
      } else {
        typeList.add(temp);

        temp = [];
        temp.add(ele);
      }
    }

    typeList.add(temp);

    return typeList;
  }
}
