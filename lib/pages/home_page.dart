import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:svt_tabla/ai_util.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';
import 'package:svt_tabla/heaven.dart';
import 'package:svt_tabla/main.dart';
import 'package:svt_tabla/pages/pagetimetableList.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<dynamic> channelsData = [];
  FetchTimeTable getRadioStation = FetchTimeTable();
  // late List<MyRadio> radios;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  void fetchData() async {
    final data = await getRadioStation.fetchDataRadio();
    if (data != null) {
      setState(() {
        channelsData = data;
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
                .size(context.screenWidth, context.screenHeight)
                .withGradient(
                  LinearGradient(
                      colors: [AIColors.primaryColor1, AIColors.primaryColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                )
                .make(),
            AppBar(
              title: Animate(
                child: 'Radio Tablå'.text.xl4.bold.white.make().shimmer(
                    duration: Duration(seconds: 10),
                    primaryColor: Vx.purple300,
                    secondaryColor: Colors.white),
              ).animate().fade(duration: 1500.ms),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ).h(100).p16(),
            VxSwiper.builder(
              itemCount: channelsData.length,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              itemBuilder: (context, imagesIndex) {
                final item = channelsData[imagesIndex];
                final imageUrl = item['image'];

                //     final text = item['name'];
                return VxBox(
                        child: ZStack([
                  Align(
                      alignment: Alignment.center,
                      child: [
                        const Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.black,
                          size: 65,
                        ),
                        45.heightBox,
                        Animate(
                            effects: [FadeEffect(), SlideEffect()],
                            child: "Double tap to play".text.black.make()),
                      ].vStack())
                ]))
                    .bgImage(
                      DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.darken)),
                    )
                    .border(color: Colors.black, width: 8.0)
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