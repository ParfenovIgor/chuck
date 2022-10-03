import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'joke.dart';
import 'joke_controller.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Program',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomePage(title: 'Tinder with Chuck Norris'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final JokeController _jokeController = JokeController();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage:
            1000000, // PageView does not support negative indexes. So instead used huge offset.
        viewportFraction: 0.8);
  }

  void _onButtonLike() {
    setState(() {
      _jokeController.jokes[_pageController.page!.round()]
          ?.then((joke) => joke.reaction = Reaction.like);
      _pageController.animateToPage(_pageController.page!.round() + 1,
          duration: const Duration(seconds: 1), curve: Curves.elasticInOut);
    });
  }

  void _onButtonBrowser() async {
    Joke? joke = await _jokeController.jokes[_pageController.page!.round()];
    String? id = joke?.id;
    String url;
    if (id != null) {
      url = 'https://api.chucknorris.io/jokes/$id';
    } else {
      url = 'https://api.chucknorris.io';
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _onButtonCopy() async {
    var joke = await _jokeController.jokes[_pageController.page!.round()];
    await Clipboard.setData(ClipboardData(text: joke!.text));
  }

  void _onButtonDislike() {
    setState(() {
      _jokeController.jokes[_pageController.page!.round()]
          ?.then((joke) => joke.reaction = Reaction.dislike);
      _pageController.animateToPage(_pageController.page!.round() + 1,
          duration: const Duration(seconds: 1), curve: Curves.elasticInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/top_picture.png'),
              ),
              PageView.builder(
                controller: _pageController,
                itemBuilder: (context, i) {
                  return FutureBuilder<Joke>(
                    future: _jokeController.getJoke(i),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 400,
                              child: Text(
                                snapshot.data!.text,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Text(
                              'Id: ${snapshot.data!.id}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            snapshot.data!.reaction == Reaction.like
                                ? const Icon(Icons.thumb_up)
                                : snapshot.data!.reaction == Reaction.dislike
                                    ? const Icon(Icons.thumb_down)
                                    : const SizedBox.shrink(),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        ElevatedButton(
          onPressed: _onButtonLike,
          child: const Icon(Icons.thumb_up),
        ),
        ElevatedButton(
          onPressed: _onButtonBrowser,
          child: const Icon(Icons.open_in_browser_outlined),
        ),
        ElevatedButton(
          onPressed: _onButtonCopy,
          child: const Icon(Icons.copy),
        ),
        ElevatedButton(
          onPressed: _onButtonDislike,
          child: const Icon(Icons.thumb_down),
        ),
      ]),
    ));
  }
}
