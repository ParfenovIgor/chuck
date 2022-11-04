import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chuck/models/joke/joke.dart';
import 'package:chuck/models/joke_json/joke_json.dart';

class Fetcher {
  static Future<Joke> fetchJoke() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        JokeJson jokeJson = JokeJson.fromJson(data);
        return Joke.fromJson(jokeJson);
      } else {
        throw Exception("Could not retrieve data");
      }
    } on SocketException catch (_) {
      throw Exception("Could not connect");
    }
  }

  static Future<List<String>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.chucknorris.io/jokes/categories'));
      if (response.statusCode == 200) {
        final List<String> data = json.decode(response.body).cast<String>();
        return data;
      } else {
        throw Exception("Could not retrieve data");
      }
    } on SocketException catch (_) {
      throw Exception("Could not connect");
    }
  }

  static Future<List<Joke>> fetchSearchJokes(String searchQuery) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.chucknorris.io/jokes/search?query=$searchQuery'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> data2 = data['result'].cast<Map<String, dynamic>>();
        List<Joke> data3 = [];
        for (var i in data2) {
          JokeJson jokeJson = JokeJson.fromJson(i);
          data3.add(Joke.fromJson(jokeJson));
        }
        return data3;
      } else {
        throw Exception("Could not retrieve data");
      }
    } on SocketException catch (_) {
      throw Exception("Could not connect");
    }
  }

  static Future<Joke> fetchCategoryJoke(String category) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.chucknorris.io/jokes/random?category=$category'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        JokeJson jokeJson = JokeJson.fromJson(data);
        return Joke.fromJson(jokeJson);
      } else {
        throw Exception("Could not retrieve data");
      }
    } on SocketException catch (_) {
      throw Exception("Could not connect");
    }
  }
}
