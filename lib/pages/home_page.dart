//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:svt_tabla/ai_util.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';


//import 'package:flutter_radio_player/flutter_radio_player.dart';

//FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  //AudioPlayer audioPlayer = AudioPlayer();
  //bool isPlaying = false;
  
  List<dynamic> channelsData = [];
  List<dynamic> programs = [];
  FetchTimeTable getRadioStation = FetchTimeTable();

  AIColors aiColors = AIColors();
  Color _selectedColor = AIColors.primaryColors.last;
  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
   
    fetchData();
  }

  void fetchData() async {
    final data = await getRadioStation.fetchDataRadio();
    //  final dataP2 = await getRadioStation.fetchDataP2();
    if (true) {
      setState(() {
        channelsData = data;
        // programs = dataP2;
        print(programs);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          // ignore: sort_child_properties_last
          children: [
            VxAnimatedBox()
                .animDuration(Duration(milliseconds: 450))
                .size(context.screenWidth, context.screenHeight)
                .withGradient(LinearGradient(
                    colors: [_selectedColor, AIColors.primaryColors.first],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight))
                .make(),
            AppBar(
              title: 'Radio Tablå'.text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.purple300, secondaryColor: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ).h(100).p16(),
            VxSwiper.builder(
              itemCount: channelsData.length,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              onPageChanged: (index) {
                //   final currentColor = channelsData[index];
                // final hexColor = currentColor['color'];
                //final colorValue = int.tryParse('0x$hexColor') ?? 0xFF000000;

                setState(() {
                  colorIndex = index % AIColors.primaryColors.length;
                  _selectedColor = aiColors.getColor(colorIndex);
                  print(colorIndex);
                });
              },
              itemBuilder: (context, imagesIndex) {
                final item = channelsData[imagesIndex];
                final imageUrl = item['image'];

                //   fetchadColor = item['color'];

                //     final text = item['name'];
                return VxBox(
                        child: ZStack([
                  const Align(
                    alignment: Alignment.center,
                    child: VStack(
                      [
                        const Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.black,
                          size: 65,
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: [
                        10.heightBox,
                        "Double tap to play".text.black.make(),
                      ].vStack())
                ]))
                    .bgImage(
                      DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.darken)),
                    )
                    .border(color: Colors.black, width: 5.0)
                    .withRounded(value: 60.0)
                    .make()
                    .p16()
                    .centered();
              },
            ),
          ],
          fit: StackFit.expand,
        ),
      ),
    );
  }
}

/*
Future<List<dynamic>> fetchDataRadio() async {
  var getFetchUrl = "http://api.sr.se/api/v2/channels?&format=json";
  String date = "&date=2018-09-25";
  String json = "&format=json";
  final dio = Dio();
  try {
    final response = await dio.get(getFetchUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      List<dynamic> channels = data['channels'];
      return channels;
    } else {
      throw Exception('Failed to load data from the API');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
*/
