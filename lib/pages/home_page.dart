import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svt_tabla/ai_util.dart';
import 'package:svt_tabla/main.dart';

import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<dynamic> channelsData = [];

  // late List<MyRadio> radios;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchRadios();
    fetchDataRadio().then((data) {
      setState(() {
        channelsData = data;
      });
    });
  }

  //fetchRadios() async {
  //final radioJson = await rootBundle.loadString("assets/radio.json");
  //radios = MyRadioList.fromJson(radioJson).radios;
  //  print(radios);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
              title: 'Svt Radio Tablå'.text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.purple300, secondaryColor: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ).h(100).p16(),
            VxSwiper.builder(
              itemCount: channelsData.length,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              itemBuilder: (context, index) {
                final item = channelsData[index];
                final imageUrl = item['image'];
                final text = item['name'];
                return VxBox(
                        child: ZStack([
                  Align(
                    alignment: Alignment.center,
                    child: VStack([Text(text).text.sm.white.bold.make()]),
                  )
                ]))
                    .bgImage(
                      DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4), BlendMode.darken)),
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.network(
              'https://static-cdn.sr.se/images/166/1cf8d86c-bcca-4b20-ab83-9b8a7e2e75f2.jpg?preset=2048x1152',
              width: 45, // Justera bredden efter ditt behov
              height: 45, // Justera höjden efter ditt behov
            ),
            label: 'Radio',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.holiday_village),
            label: 'Camera',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}

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
