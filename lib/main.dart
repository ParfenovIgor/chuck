import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utilities/firebase/firebase_options.dart';

import 'models/joke/joke.dart';
import 'models/custom_error/custom_error.dart';
import 'models/tab/tab.dart';
import 'models/reaction/reaction.dart';
import 'pages/menu/menu_page.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await Hive.initFlutter();
    Hive
      ..registerAdapter(ReactionAdapter())
      ..registerAdapter(JokeAdapter());
    runApp(const ProviderScope(child: App()));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(tabProvider);
    return MaterialApp(
        title: 'Tinder with Chuck Norris',
        theme: ThemeData(primarySwatch: tabColor(tab)),
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomError(errorDetails: errorDetails);
          };
          return widget!;
        },
        home: const SafeArea(child: MenuPage()));
  }
}
