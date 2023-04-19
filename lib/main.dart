import 'package:flutter/material.dart';
import 'package:goquotes/detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var text = "my quotes for today";
  var author = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64),
          child: Column(children: [
            Container(
              constraints: const BoxConstraints.tightFor(),
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Color.fromARGB(255, 88, 178, 252),
                  //       offset: Offset(2, 0),
                  //       blurRadius: 18,
                  //       spreadRadius: 1,
                  //       blurStyle: BlurStyle.normal),
                  //   BoxShadow(
                  //       color: Color.fromARGB(255, 238, 231, 132),
                  //       offset: Offset(0, 2),
                  //       blurRadius: 18,
                  //       spreadRadius: 1,
                  //       blurStyle: BlurStyle.normal)
                  // ],
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 88, 178, 252),
                    Color.fromARGB(255, 238, 231, 132),
                  ])),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Text(text: text),
                  const SizedBox(height: 8),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: _Text(text: author)),
                ],
              )),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                ),
                onPressed: () async {
                  final url = Uri.parse(
                      'https://goquotes-api.herokuapp.com/api/v1/random?count=1');
                  var response = await http.get(url);
                  var json = jsonDecode(response.body);
                  var jsonText = json['quotes'][0]['text'];
                  var jsonAuthor = json['quotes'][0]['author'];

                  setState(() {
                    text = jsonText;
                    author = "- " + jsonAuthor;
                  });

                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return SecondScreen();
                  // }));
                },
                child: const Text('Get Quote'))
          ]),
        ));
  }
}

class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.quattrocento(
            color: Colors.black, fontStyle: FontStyle.italic));
  }
}
