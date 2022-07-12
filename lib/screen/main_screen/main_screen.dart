import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;
  List bear = [
    "assets/medium-teddy-bear.png",
    "assets/small-teddy-bear.png",
    "assets/small-teddy-bear.png",
    "assets/small-teddy-bear.png",
    "assets/medium-teddy-bear.png"
  ];
  List acceptBear=[
    "assets/small-teddy-bear.png",
  ];
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this,
        value: 0.93,
        lowerBound: 0.95,
        upperBound: 0.96);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _controller.forward();

    super.initState();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width;
    var height = media.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "assets/background.jpg",
                ) as ImageProvider,
                fit: BoxFit.cover,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                              top: 107,
                              left: 200,
                              child: Container(
                                child: Image.asset(
                                  "assets/large-teddy-bear.png",
                                  scale: 5,
                                ),
                              )),
                          RotationTransition(
                              turns: _animation,
                              child: Image.asset(
                                "assets/line.png",
                                scale: 1.5,
                                color: Colors.brown.shade100,
                              )),
                          Container(
                            child: Image.asset(
                              "assets/clock.png",
                              scale: 12,
                              color: Colors.brown.shade300,
                            ),
                          ),
                          Positioned(
                            left:400 ,
                            top: 90,
                            child: Container(
                              height: 100,
                              child: Row(
                                children: [
                                  DragTarget(

                                    builder: (context ,acceptdata,rejectdata){
                                      return Container(
                                       width: 500,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children:  acceptBear
                                              .map((e) => Container(
                                            width: 100,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 10),
                                            child: Draggable(
                                                feedback:
                                                Image.asset(e, scale: 13),
                                                child: Image.asset(
                                                  e,
                                                  scale: 13,
                                                )),
                                          )).toList(),
                                        ),
                                      );
                                    },
                                    onWillAccept: (data){
                                    return  true;
                                    },
                                  onAccept: (data){
                                    acceptBear.add(data);
                                  },
                                    onLeave: (data){
                                      acceptBear.removeWhere((element) => data==element);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 7,
                            child: Container(
                              width: width * 0.6,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.brown.shade400,
                                border: Border.all(
                                    color: Colors.brown.shade700, width: 4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: bear
                                    .map((e) => Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 10),
                                          child: Draggable(
                                              feedback:
                                                  Image.asset(e, scale: 13),
                                              child: Image.asset(
                                                e,
                                                scale: 13,
                                              )),
                                        ))
                                    .toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
