import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:svt_tabla/pages/audioplayer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:svt_tabla/ai_util.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<dynamic> channelsData = [];
  List<dynamic> programs = [];
  FetchTimeTable getRadioStation = FetchTimeTable();
  late String thisUrl;
  AIColors aiColors = AIColors();
  Color _selectedColor = AIColors.primaryColors.last;
  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
// fetchData when Render of page
    fetchData();
  }

// converts http to https
  String convertHttpToHttps(String url) {
    return url.replaceFirst("http://", "https://");
  }

//fetch data from  using  FetchTimeTable class
  void fetchData() async {
    final data = await getRadioStation.fetchDataRadio();

    if (true) {
      setState(() {
        channelsData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        VxAnimatedBox()
            .animDuration(const Duration(milliseconds: 450))
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
          centerTitle: true,
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
            final radio = channelsData[imagesIndex];

            final imageUrl = radio['image'];
            final radioUrl = radio['liveaudio']['url'];
            final radioName = radio['name'];
            final convertedRadioUrl = convertHttpToHttps(radioUrl);

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
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                          ),
                          iconSize: 75,
                          // When the channel image is pressed, it navigates to the radio page (audioplayer) and passes some parameters.

                          onPressed: () {
                            final thisUrl = convertedRadioUrl;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RadioPlayerPage(
                                    radioUrl: thisUrl,
                                    radioName: radioName,
                                    imageUrl: imageUrl),
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
    ));
  }
}
