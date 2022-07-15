import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kidslingo_game/model/bear_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;
  List<Bear> bear = [
    Bear(size:"assets/medium-teddy-bear.png",weight: 10 ),
    Bear(size:"assets/small-teddy-bear.png",weight: 5 ),
    Bear(size: "assets/small-teddy-bear.png",weight: 5 ),
    Bear(size:"assets/small-teddy-bear.png",weight: 5 ),
    Bear(size:"assets/medium-teddy-bear.png",weight: 10 ),
  ];
  List<Bear> acceptBear=[
    //Bear(size:"assets/small-teddy-bear.png",type: "drop" ),
  ];
  double angle=-20;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this,
        value: 0,
        upperBound: 1,);
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
                          Transform.rotate(
                            angle:angle/180 *  pi,
                            child: Container(
                              //color: Colors.white,
                              child:Stack(
                               // fit: StackFit.passthrough,
                                alignment: Alignment.centerLeft,
                                children: [
                                Container(
                                  padding:EdgeInsets.only(bottom: 85),
                                  child: Image.asset(
                                    "assets/large-teddy-bear.png",
                                    scale: 5,
                                  ),
                                ),
                                Image.asset(
                                  "assets/line.png",
                                  scale:1.3,
                                   color: Colors.brown.shade100,
                                ),
                                  Positioned(
                                    right: 1,
                                    top: 100,
                                    child: Container(
                                      height: 100,
                                      child: DragTarget<Bear>(

                                        builder: (context , data ,reject){
                                          return Container(
                                            width: 160,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children:  acceptBear
                                                  .map((e) => Container(
                                                width: 40,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 10),
                                                child: Draggable<Bear>(
                                                    onDragStarted: ()async{
                                                      acceptBear.remove(e);
                                                      for(double i=0;i<e.weight;i++){
                                                       await Future.delayed(Duration(microseconds: 9000),(){
                                                          setState(() {
                                                            angle=angle-1;
                                                          });
                                                        });
                                                      }
                                                      //angle=angle-e.weight;
                                                      if(angle==0){
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType: DialogType.SUCCES,
                                                          animType: AnimType.SCALE,
                                                          title: 'Congratulation',
                                                          desc: "you win",
                                                          body: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Image.asset(
                                                                "assets/large-teddy-bear.png",
                                                                scale: 5,
                                                              ),
                                                              Text("="),
                                                              Container(
                                                                width: 160,
                                                                height: 90,
                                                                child: ListView(
                                                                  scrollDirection: Axis.horizontal,
                                                                  children: acceptBear.map((e) => Container(
                                                                    width: 40,
                                                                    child: Image.asset(e.size),)).toList(),),
                                                              )
                                                            ],),
                                                          btnOkOnPress: () {
                                                            // Navigator.pop(context,false);
                                                          },
                                                        )..show().then((value) {
                                                          angle=-20;
                                                          acceptBear.clear();
                                                          setState(() {

                                                          });
                                                        });
                                                      }
                                                      setState(() {
                                                      });
                                                    },
                                                    feedback:
                                                    Image.asset(e.size, scale: 13),
                                                    child: Image.asset(
                                                      e.size,
                                                      scale: 13,
                                                    )),
                                              )).toList(),
                                            ),
                                          );
                                        },
                                        onWillAccept: (data){
                                          //print("accep" + accept.toString());
                                          print(data);
                                          return  true;
                                        },
                                        onAccept: (data)async{

                                          //  print(data);
                                          acceptBear.add(data);
                                          //bear.removeWhere((element) => data==element);
                                          for(double i=0;i<data.weight;i++){
                                          await  Future.delayed(Duration(microseconds: 9000 ),(){
                                              setState(() {
                                          angle=angle+1;
                                              });
                                            });
                                          }
                                          print(angle);
                                          setState(() {});
                                          if(angle==0){
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.SUCCES,
                                              animType: AnimType.SCALE,
                                              title: 'Congratulation',
                                              desc: "you win",
                                              body: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                Image.asset(
                                                  "assets/large-teddy-bear.png",
                                                  scale: 5,
                                                ),
                                                Text("="),
                                                Container(
                                                  width: 160,
                                                  height: 90,
                                                  child: ListView(
                                                    scrollDirection: Axis.horizontal,
                                                    children: acceptBear.map((e) => Container(
                                                      width: 40,
                                                      child: Image.asset(e.size),)).toList(),),
                                                )
                                              ],),
                                              btnOkOnPress: () {
                                               // Navigator.pop(context,false);
                                              },
                                            )..show().then((value) {
                                              angle=-20;
                                              acceptBear.clear();
                                              setState(() {

                                              });
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                              ],) ,
                            ),
                          ),
                          Container(
                            child: Image.asset(
                              "assets/clock.png",
                              scale: 12,
                              color: Colors.brown.shade300,
                            ),
                          ),
                          // bottom bear list
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
                                          child: Draggable<Bear>(
                                            data: e,
                                              feedback:
                                                  Image.asset(e.size, scale: 13),
                                              child: Image.asset(
                                                e.size,
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
