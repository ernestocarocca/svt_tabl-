import 'package:flutter/material.dart';
import 'package:svt_tabla/tablaObject.dart';

class ShowTabl extends StatelessWidget {
  //final String formattedDate;
  final dynamic child;
  final Tablaobject timeTable;
  final GlobalKey backgroundImagekey = GlobalKey();

  ShowTabl({
    Key? key,
    this.child,
    required this.timeTable,
  }) : super(key: key);
  // required this.formattedDate
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: [
              Flow(
                delegate: _ParallaxFlowDelegate(
                  scrollable: Scrollable.of(context),
                  timeTable: context, // Använd context här
                  backgroundImagekey: backgroundImagekey,
                ),
                children: [
                  Image.network(
                    timeTable.imageUrl,
                    key: backgroundImagekey,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.6, 0.95]),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                top: 3,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ${timeTable.timetableName} ',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor:
                                Colors.purpleAccent.withOpacity(0.5)),
                      ),
                      Text(
                        "Tid: ${timeTable.time}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor:
                                Colors.purpleAccent.withOpacity(0.5)),
                      ),
                      Text(
                        "Datum: ${timeTable.date}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor:
                                Colors.purpleAccent.withOpacity(0.5)),
                      ),
                      Text(
                        "Program: ${timeTable.description}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor:
                                Colors.purpleAccent.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext timeTable;
  final GlobalKey backgroundImagekey;

  _ParallaxFlowDelegate(
      {required this.scrollable,
      required this.timeTable,
      required this.backgroundImagekey})
      : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of the list time within the Viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = timeTable.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.center(Offset.zero),
      ancestor: scrollableBox,
    );
    // Determine the percent position of the list item within the scrollable area
    final vieportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / vieportDimension).clamp(0.0, 1.0);
    // Calculate the vertical alignment of the background based on scroll percent
    final verticalAligment = Alignment(0.0, scrollFraction * 2 - 1);
    final backgroundSize =
        (backgroundImagekey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect = verticalAligment.inscribe(
      backgroundSize,
      Offset.zero & listItemSize,
    );
    // paint the Background
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(covariant _ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        timeTable != oldDelegate.timeTable ||
        backgroundImagekey != oldDelegate.backgroundImagekey;
  }
}
