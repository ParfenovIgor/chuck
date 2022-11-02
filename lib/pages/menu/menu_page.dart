import 'package:chuck/pages/saved/saved_jokes_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../random/random_jokes_page.dart';
import '../saved/saved_jokes_page.dart';
import '../search_textfield/search_jokes_textfield_page.dart';
import '../categories_list/categories_jokes_list_page.dart';
import '../../models/tab/tab.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tinder with Chuck Norris')),
      body: Center(
          child: Column(children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              child: Image.asset('assets/images/chuck_orange.png'),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.cloud_download),
                title: const Text('Random Jokes'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  final tab = ref.watch(tabProvider.notifier);
                  tab.setTab(TabType.random);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RandomJokesPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.turned_in),
                title: const Text('Saved Jokes'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  final tab = ref.watch(tabProvider.notifier);
                  tab.setTab(TabType.saved);
                  SavedJokesLogic.fetch();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SavedJokesPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search Jokes'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  final tab = ref.watch(tabProvider.notifier);
                  tab.setTab(TabType.search);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SearchJokesTextfieldPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text('Jokes Categories'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  final tab = ref.watch(tabProvider.notifier);
                  tab.setTab(TabType.categories);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CategoriesJokesListPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Saved'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text("Delete Saved?"),
                        content: const Text(
                            "Do you want to delete all saved jokes?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Yes"),
                            onPressed: () {
                              SavedJokesLogic.delete();
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("All jokes had been deleted")));
                            },
                          ),
                          TextButton(
                            child: const Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ]);
                  },
                ),
              )
            ],
          ),
        ),
      ])),
    );
  }
}
