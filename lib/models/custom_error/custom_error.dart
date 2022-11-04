import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const CustomError({Key? key, required this.errorDetails}) : super(key: key);

  String errorLog() {
    String message;
    try {
      message = "ERROR\n\n${errorDetails.exception}\n\n";
      List<String> stackTrace = errorDetails.stack.toString().split("\n");
      int length = stackTrace.length > 5 ? 5 : stackTrace.length;
      for (int i = 0; i < length; i++) {
        message += "${stackTrace[i]}\n";
      }
    } catch (e) {
      message = "FATAL ERROR";
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.log(errorLog());
    }
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset('assets/images/chuck_grey.png'),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    'An error has occurred',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(kDebugMode
                      ? errorLog()
                      : "The developer will be notified, when application will be restarted"),
                ),
              ],
            ))));
  }
}
