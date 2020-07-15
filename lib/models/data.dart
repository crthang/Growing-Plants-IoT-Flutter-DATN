import 'package:firebase_database/firebase_database.dart';

class Data {

  String AirHum,AirTmp, SoilTmp, SoilHum, time;
  Data(this.AirHum, this.AirTmp,this.SoilHum,this.SoilTmp, this.time);

  Data.fromSnapshot(DataSnapshot snapshot):
        AirHum  = snapshot.value["AirHum"],
        AirTmp  = snapshot.value["AirTmp"],
        SoilTmp = snapshot.value["SoilTmp"],
        SoilHum = snapshot.value["SoilHum"],
        time    = snapshot.value["Time"];
  toJson() {
    return {
      "AirHum": AirHum,
      "AirTmp": AirTmp,
      "SoilTmp": SoilTmp,
      "SoilHum": SoilHum,
      "Time": time,
    };
  }

}