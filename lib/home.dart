// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'jokes.dart';

class PrepJoke {
  BuildContext context;
  late HomePageState Show;
  Jokes joke = Jokes();

  // Constructor which takes context and the Show
  PrepJoke(this.context, this.Show);

  // Get a random joke and fetch the json into a joke object
  void get_joke() {
    String url = 'https://api.chucknorris.io/jokes/random';

    // collect the Joke from the API

    void collect_joke() async {
      try {
        var response = await Dio().get(url);
        joke = Jokes.fromJson(jsonDecode(response.toString()));
        Show.test_update(joke.value!, joke.url!, joke.iconUrl!);
      } catch (e) {
        //print(e);
      }
    }

    collect_joke();
  }

  void show_in_browser() => Show.relates_img_url('Show Joke');

  void ShowPhotos() => Show.relates_img_url('Show Photos');
}

//Abstract class to connect with the Show
abstract class Show {
  void test_update(String value, String joke_url, String imageUrl);

  void relates_img_url(String type);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> implements Show {
  late PrepJoke viewer;

  late String joke_val = 'Joke';
  late String joke_url = 'Url';
  late String img_url = 'Url';

  @override
  void initState() {
    super.initState();

    // Initializing an instance of the constructor
    viewer = PrepJoke(context, this);

    //Getting the first joke from the API
    viewer.get_joke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 141, 63, 46),
          toolbarHeight: 30,
          title: const Text('Tinder with Chuck Norris'),
        ),
        body: Center(
            child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://d50-a.sdn.cz/d_50/c_img_E_G/Q18EK/chuck-norris.jpeg"),
                fit: BoxFit.cover),
          ),
          child: SizedBox(
            width: 1000,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7.8, 7.8, 7.8, 70.0),
                    child: Text(
                      joke_val,
                      style: TextStyle(
                        fontSize: 20.0,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 0.9
                          ..color = Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: viewer.get_joke,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 141, 63, 46),
                            minimumSize: const Size(150.0, 50.0)),
                        child: const Text('Switch'),
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: viewer.ShowPhotos,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 141, 63, 46),
                            minimumSize: const Size(150.0, 50.0)),
                        child: const Text('Related Images'),
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: viewer.show_in_browser,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 141, 63, 46),
                            minimumSize: const Size(150.0, 50.0)),
                        child: const Text('Show in Browser'),
                      )),
                ],
              ),
            ),
          ),
        )));
  }

  // change the text aftr updating the joke
  @override
  void test_update(String value, url, imageUrl) {
    setState(() {
      joke_val = value;
      joke_url = url;
      img_url = imageUrl;
    });
  }

  @override
  void relates_img_url(String type) {
    //Open related images of the joke on chrome
    if (type == 'Show Photos') {
      String jokeContent = joke_val.replaceAll(' ', '+');
      String photosUrl =
          'https://www.google.com/search?q=$jokeContent&tbm=isch';

      url_launcher.launch(
        photosUrl,
        forceSafariVC: false,
      );
    }
    // Show the joke on the website
    else if (type == 'Show Joke') {
      url_launcher.launch(
        joke_url,
        forceSafariVC: false,
      );
    }
  }
}
