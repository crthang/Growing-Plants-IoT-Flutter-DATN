import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:growing_plants_iot_app/appTheme.dart';
import 'package:growing_plants_iot_app/models/data.dart';
import 'package:growing_plants_iot_app/screens/actions.dart';
import 'package:growing_plants_iot_app/screens/growing_plan.dart';
import 'package:growing_plants_iot_app/widgets/plant_progress_status.dart';
import 'package:response/response.dart';

var response = ResponseUI();

class Test extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Test> {
  List<Data> allData = [];
  var length =0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    DatabaseReference ref = FirebaseDatabase.instance.reference().child('SmartFarm');
    ref.limitToLast(1);
    ref.onChildAdded.forEach((event) => {

      print(event.snapshot.value),
      allData.add(new Data(
        event.snapshot.value["AirTmp"],
        event.snapshot.value["AirHum"],
        event.snapshot.value["SoilTmp"],
        event.snapshot.value["SoilHum"],
        event.snapshot.value["Time"],
      ))
    });
//    .once().then((DataSnapshot snap) {
//      var keys = snap.value.keys;
//      var data = snap.value;
//      allData.clear();
//      for (var key in keys) {
//        Data d = new Data(
//          data[key]['AirTmp'],
//          data[key]['AirHum'],
//          data[key]['SoilTmp'],
//          data[key]['SoilHum'],
//          data[key]['Time'],
//        );
//        print(d.time);
//        allData.add(d);
//      }
    setState(() {
      print('Length1 : ${allData.length}');
      length = allData.length;
      print('Length2 : ${length}');

    });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: response.setWidth(20),
                  vertical: response.setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(
                    transitionOnUserGestures: true,
                    tag: 'backarrow',
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.black, size: response.setHeight(20)),
                  ),
                  Hero(
                      tag: 'sideslame',
                      child: FaIcon(FontAwesomeIcons.ellipsisH,
                          color: Colors.black87))
                ],
              ),
            ),
            SizedBox(height: response.setHeight(10)),
            Text(
              '  Smart Farm',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: response.setFontSize(45),
              ),
            ),
            Container(
              height: response.screenHeight,
              width: response.screenWidth,
              // color: Colors.red,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    left: -15,
                    top: 0,
                    child: Image.asset(
                      'assets/bg.png',
                      scale: response.screenHeight / 400,
                    ),
                  ),
                  Positioned(
                    right: response.setWidth(15),
                    top: response.setHeight(50),
                    child: Container(
                        width: response.setWidth(130),
                        child: allData.length == 0 ? new Text("Null") : new
                        PlantProgressStatus(
                          AirTmp  :  allData[allData.length-1].AirHum,
                          AirHum  :  allData[allData.length-1].AirTmp,
                          SoilTmp :  allData[allData.length-1].SoilHum,
                          SoilHum :  allData[allData.length-1].SoilTmp,
                          time    :  allData[allData.length-1].time,
                          iconAirTmp:FontAwesomeIcons.cloudSun,
                          iconAirHum: FontAwesomeIcons.tint,
                          iconSoilTmp: FontAwesomeIcons.temperatureLow,
                          iconSoilHum: FontAwesomeIcons.pagelines,
                        )
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: response.setHeight(260),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (contex) => PlantActions(),
                          ),
                        );
                      },
                      child: Container(
                        height: response.setHeight(80),
                        width: response.setWidth(160),
                        decoration: BoxDecoration(
                          color: AppTheme.mainGreen,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(response.setHeight(10)),
                            bottomLeft: Radius.circular(response.setHeight(10)),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: response.setWidth(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: Colors.white30, width: 2),
                                ),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.doorClosed,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Text(
                                "Take\nAction",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: response.setFontSize(15),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.chevronRight,
                                color: Colors.white,
                                size: response.setHeight(20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: response.setHeight(160),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GrowingPlan(),
                          ),
                        );
                      },
                      child: Container(
                        height: response.setHeight(70),
                        width: response.setWidth(150),
                        decoration: BoxDecoration(
                          color: AppTheme.mainGreen.withOpacity(0.95),
                          borderRadius: BorderRadius.only(
                            bottomRight:
                            Radius.circular(response.setHeight(10)),
                            topRight: Radius.circular(
                              response.setHeight(10),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: response.setWidth(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                Border.all(color: Colors.white30, width: 2),
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.pagelines,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Text(
                              "View\nHistory",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: response.setFontSize(12),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.longArrowAltDown,
                              color: Colors.white54,
                              size: response.setHeight(18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
