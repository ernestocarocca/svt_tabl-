import 'package:flutter/material.dart';
import 'package:svt_tabla/showTabl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'svt tablå',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List _post = [
    'post 1',
    'post 2',
    'post 3',
    'post 4',
    'post 5',
    'post 6',
    'post 7',
    'post 8',
    'post 9',
    'post 10',
    'post 12',
    'post 13',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Svt Tablå"),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            backgroundColor: Colors.purple,
            fontSize: 20.0,
          ),
        ),
        body: ListView.builder(
            itemCount: _post.length,
            itemBuilder: (context, index) {
              return showTabl();
            }));
  }
}

class PresentSvt extends StatelessWidget {
  const PresentSvt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Tablå p4 )(mockdata)"),
        LinearProgressIndicator(
          value: 0.0,
          backgroundColor: Colors.purpleAccent,
        ),
      ],
    );
  }
}
