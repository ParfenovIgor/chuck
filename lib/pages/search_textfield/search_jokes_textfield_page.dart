import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/tab/tab.dart';
import '../search/search_jokes_page.dart';

class SearchJokesTextfieldPage extends ConsumerStatefulWidget {
  const SearchJokesTextfieldPage({super.key});

  @override
  ConsumerState<SearchJokesTextfieldPage> createState() =>
      SearchJokesTextfieldPageState();
}

class SearchJokesTextfieldPageState
    extends ConsumerState<SearchJokesTextfieldPage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final tab = ref.watch(tabProvider.notifier);
    tab.setTab(TabType.menu);
    return true;
  }

  void _onSubmitted(String value) {
    if (value.length >= 3 && value.length <= 120) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => SearchJokesPage(searchQuery: value)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The length of the query has to be from 3 to 120")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(title: const Text('Search Jokes')),
          body: Center(
              child: Column(children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  child: Image.asset('assets/images/chuck_yellow.png'),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      Text(
                        "Enter search query",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _textEditingController,
                        onSubmitted: _onSubmitted,
                      )
                    ]))),
          ])),
        ));
  }
}
