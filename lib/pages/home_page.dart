//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:svt_tabla/pages/audioplayer.dart';
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
                setState(() {
                  colorIndex = index % AIColors.primaryColors.length;
                  _selectedColor = aiColors.getColor(colorIndex);
                });
              },
              itemBuilder: (context, imagesIndex) {
                final item = channelsData[imagesIndex];
                final imageUrl = item['image'];
                print(imageUrl.length);

                return VxBox(
                        child: ZStack([
                  Align(
                    alignment: Alignment.center,
                    child: VStack(
                      [
                        CircleAvatar(
                            radius: 50,
                            backgroundColor: ShimmerEffect.defaultColor,
                            child: IconButton(
                              color: Colors.black,
                              icon: Icon(
                                Icons.play_arrow_rounded,
                              ),
                              iconSize: 75,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RadioPlayerPage(),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: [
                        10.heightBox,
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
