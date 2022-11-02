import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabProvider =
    StateNotifierProvider<TabClass, TabType>((ref) => TabClass());

enum TabType {
  menu,
  random,
  saved,
  search,
  categories,
}

MaterialColor tabColor(TabType tab) {
  switch (tab) {
    case TabType.menu:
      return Colors.deepOrange;
    case TabType.random:
      return Colors.blue;
    case TabType.saved:
      return Colors.green;
    case TabType.search:
      return Colors.lime;
    case TabType.categories:
      return Colors.deepPurple;
  }
}

class TabClass extends StateNotifier<TabType> {
  TabClass() : super(TabType.menu);
  void setTab(TabType tab) {
    state = tab;
  }
}
