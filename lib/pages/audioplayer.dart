import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:svt_tabla/dateconverter.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';
import 'package:svt_tabla/tablaObject.dart';

class RadioPlayerPage extends StatefulWidget {
  final String radioUrl;
  final String radioName;
  RadioPlayerPage({required this.radioUrl, required this.radioName});
  @override
  _RadioPlayerPageState createState() => _RadioPlayerPageState();
}

class _RadioPlayerPageState extends State<RadioPlayerPage> {
  final audioPlayer = AudioPlayer();
  List<Tablaobject> radioList = [];

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  List<dynamic> channelsData = [];
  FetchTimeTable getRadioStation = FetchTimeTable();
  int counter = 0;
  @override
  void initState() {
    super.initState();
    // Anropa _play här för att starta uppspelningen när sidan skapas
    fetchData();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
        print(isPlaying);
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
        print('Duration $duration + $counter');
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
        //  isPlaying = audioPlayer.state == PlayerState.PLAYING;
      });
    });
  }

  void fetchData() async {
    final data = await getRadioStation.fetchDataRadio();
    //  final dataP2 = await getRadioStation.fetchDataP2();
    if (true) {
      setState(() {
        channelsData = data;

        // programs = dataP2;
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/radio.jpg',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Svt Radio Spelare',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.radioName,
              style: TextStyle(fontSize: 20),
            ),
            Slider(
              min: 0,
              max: max(1.0, duration.inSeconds.toDouble()),
              value: min(position.inSeconds.toDouble(),
                  max(1.0, duration.inSeconds.toDouble())),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formattedTime(position)),
                  Text(formattedTime(duration - position)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                iconSize: 50,
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.play(widget.radioUrl);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formattedTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}
