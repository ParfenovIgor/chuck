import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categories_jokes_logic.dart';
import '../../models/joke/joke.dart';
import '../../models/reaction/reaction.dart';
import '../saved/saved_jokes_logic.dart';

class CategoriesJokesPage extends ConsumerStatefulWidget {
  final String category;

  CategoriesJokesPage({super.key, required this.category}) {
    CategoriesJokesLogic.category = category;
  }

  @override
  ConsumerState<CategoriesJokesPage> createState() =>
      CategoriesJokesPageState();
}

class CategoriesJokesPageState extends ConsumerState<CategoriesJokesPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: 1000000, viewportFraction: 0.8);
  }

  Future<bool> _onWillPop() async {
    return true;
  }

  void _onButtonLike() {
    setState(() {
      CategoriesJokesLogic.getJoke(pageController.page!.round())
          .then((joke) => joke.reaction = Reaction.like);
      SavedJokesLogic.store();
      pageController.animateToPage(pageController.page!.round() + 1,
          duration: const Duration(seconds: 1), curve: Curves.elasticInOut);
    });
  }

  void _onButtonBrowser() async {
    Joke? joke =
        await CategoriesJokesLogic.getJoke(pageController.page!.round());
    String? id = joke.id;
    String url = 'https://api.chucknorris.io/jokes/$id';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _onButtonSave() async {
    Joke? joke =
        await CategoriesJokesLogic.getJoke(pageController.page!.round());
    if (!mounted) return;
    await SavedJokesLogic.addJoke(joke).then((n) {
      if (n) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("The joke is saved")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("This joke is already saved")));
      }
    });
  }

  void _onButtonBack() {
    Navigator.of(context).pop();
  }

  void _onButtonCopy() async {
    Joke joke =
        await CategoriesJokesLogic.getJoke(pageController.page!.round());
    await Clipboard.setData(ClipboardData(text: joke.text));
  }

  void _onButtonDislike() {
    setState(() {
      CategoriesJokesLogic.getJoke(pageController.page!.round())
          .then((joke) => joke.reaction = Reaction.dislike);
      SavedJokesLogic.store();
      pageController.animateToPage(pageController.page!.round() + 1,
          duration: const Duration(seconds: 1), curve: Curves.elasticInOut);
    });
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
                  child: Image.asset('assets/images/chuck_purple.png'),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    child: PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, i) {
                        return FutureBuilder<Joke>(
                          future: CategoriesJokesLogic.getJoke(i),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: <Widget>[
                                  Text(
                                    'Id: ${snapshot.data!.id}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  reactionToIcon(snapshot.data!.reaction),
                                  Text(
                                    snapshot.data!.text,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
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
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ])),
            bottomNavigationBar: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _onButtonLike,
                    child: const Icon(Icons.thumb_up),
                  ),
                  ElevatedButton(
                    onPressed: _onButtonBrowser,
                    child: const Icon(Icons.open_in_browser_outlined),
                  ),
                  ElevatedButton(
                    onPressed: _onButtonSave,
                    child: const Icon(Icons.turned_in_not),
                  ),
                  ElevatedButton(
                    onPressed: _onButtonBack,
                    child: const Icon(Icons.arrow_back),
                  ),
                  ElevatedButton(
                    onPressed: _onButtonCopy,
                    child: const Icon(Icons.copy),
                  ),
                  ElevatedButton(
                    onPressed: _onButtonDislike,
                    child: const Icon(Icons.thumb_down),
                  ),
                ])));
  }
}
