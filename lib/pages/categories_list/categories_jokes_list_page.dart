import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chuck/models/fetcher/fetcher.dart';
import 'package:chuck/models/tab/tab.dart';
import 'package:chuck/pages/categories/categories_jokes_page.dart';

class CategoriesJokesListPage extends ConsumerStatefulWidget {
  const CategoriesJokesListPage({super.key});

  @override
  ConsumerState<CategoriesJokesListPage> createState() =>
      CategoriesJokesListPageState();
}

class CategoriesJokesListPageState
    extends ConsumerState<CategoriesJokesListPage> {
  late Future<List<String>> list;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    list = Fetcher.fetchCategories();
  }

  Future<bool> _onWillPop() async {
    final tab = ref.watch(tabProvider.notifier);
    tab.setTab(TabType.menu);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(title: const Text('Jokes Categories')),
            body: Center(
              child: Column(children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      child: Image.asset('assets/images/chuck_purple.png'),
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: FutureBuilder<List<String>>(
                        future: list,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              prototypeItem:
                                  ListTile(title: Text(snapshot.data!.first)),
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: Text(snapshot.data![index]),
                                    trailing:
                                        const Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  CategoriesJokesPage(
                                                      category: snapshot
                                                          .data![index])));
                                    });
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              "Could not download joke: Chuck Norris had stolen your data packets",
                              style: Theme.of(context).textTheme.headline6,
                            );
                          }
                          return const Center(
                              child: SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(),
                          ));
                        })),
              ]),
            )));
  }
}
