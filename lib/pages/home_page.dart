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
  List<dynamic> scheduleData = [];

  // late List<MyRadio> radios;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchRadios();
    fetchData().then((data) {
      setState(() {
        scheduleData = data;
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
              itemCount: scheduleData.length,
              aspectRatio: 1.0,
              itemBuilder: (context, index) {
                final item = scheduleData[index];
                final imageUrl = item['imageurltemplate'];
                return VxBox(
                  child: ZStack([
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ]),
                ).make();
              },
            ),
          ],
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
