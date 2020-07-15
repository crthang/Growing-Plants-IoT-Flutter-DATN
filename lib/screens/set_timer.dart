import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:response/response.dart';

import 'home.dart';

class SetTimer extends StatefulWidget {
  @override
  _SetTimerState createState() => _SetTimerState();
}

class _SetTimerState extends State<SetTimer> {
  String _date = "Not set";
  String _timeStart = "Not set";
  String _timeEnd = "Not set";
  int _radioValue = 0;
  String control = "light";

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          control = "light";
          break;
        case 1:
          control = "pump";
          break;
      }
    });
  }
  void sendData(int radioValue, String date, String timeStart, String timeEnd) {
    if(radioValue == 0){//control LIGHT
      DatabaseReference timerRef = FirebaseDatabase.instance.reference().child('light/timer').push();
      timerRef.set({
        "date": date,
        "timeStart": timeStart,
        "timeEnd": timeEnd,
        "status": 0,
      });
    }else if(radioValue ==1){//control PUMP
      DatabaseReference timerRef = FirebaseDatabase.instance.reference().child('pump/timer').push();
      timerRef.set({
        "date": date,
        "timeStart": timeStart,
        "timeEnd": timeEnd,
        "status": 0,
      });
    }else{
      print("erro put data");
    }
  }


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (ctx) => Stack(
          children: <Widget>[
            Positioned(
              top: 9,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: response.setHeight(9),
                          horizontal: response.setWidth(30)),
                      height: response.setHeight(50),
                      width: response.setWidth(50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: 'backarrow',
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: response.setHeight(22),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 150,
              top: response.screenHeight * 0.12,
              child: Text(
                "Set Timer",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: response.setFontSize(28),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                 RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2022, 12, 31),
                        onConfirm: (date) {
                          print('confirm $date');
                          _date = '${date.year}-${date.month}-${date.day}';
                          setState(() {});
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.vi);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  child: Row(
                                      children: <Widget>[
                                        Icon(
                                            Icons.date_range,
                                            size: 18.0,
                                            color: Color(0xff1CA953),
                                        ),
                                        Text(
                                            " $_date",
                                            style: TextStyle(
                                                color: Color(0xff1CA953),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                        ),
                                      ],
                                  ),
                              ),
                          ],
                        ),
                        Text(
                          "  Change Date",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        ],
                    ),
                  ),
                  color: Colors.white,
                ),

                SizedBox(height: 20.0,),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                      DatePicker.showTimePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        onConfirm: (time) {
                          print('confirm $time');
                          _timeStart = '${time.hour}:${time.minute}:${time.second}';
                          setState(() {});
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.vi);
                    setState(() {});
                    },
                      child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 18.0,
                                            color: Color(0xff1CA953),
                                          ),
                                        Text(
                                          " $_timeStart",
                                          style: TextStyle(
                                              color: Color(0xff1CA953),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                          ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "  Time Start",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                        ],
                  ),
                ),
                color: Colors.white,
                ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            onConfirm: (time) {
                              print('confirm $time');
                              _timeEnd = '${time.hour}:${time.minute}:${time.second}';
                              setState(() {});
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.vi);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        size: 18.0,
                                        color: Color(0xff1CA953),
                                      ),
                                      Text(
                                        " $_timeEnd",
                                        style: TextStyle(
                                            color: Color(0xff1CA953),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "  Time End",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            new Text('Light'),
                            new Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                            ),
                            new Text('Pump'),
                            new Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                            ),
                ],
              ),
                    const SizedBox(height: 30),
                    RaisedButton(
                      color: Colors.green[300],
                      padding: const EdgeInsets.all(15.0),
                      onPressed: () {
                        print("time $_timeEnd || $_timeStart date $_date control $control");
                        sendData(_radioValue, _date, _timeStart,_timeEnd );
                        Scaffold.of(ctx).showSnackBar(new SnackBar(
                          content: _radioValue == 0 ? new Text("Timer Light Successfully") :  new Text("Timer Light Successfully"),
                        ));
                      },

                      child: const Text('Submit', style: TextStyle(fontSize: 20, color: Colors.white),),
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

