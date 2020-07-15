import 'package:firebase_database/firebase_database.dart';

class Timer {

  String date, timeStart, timeEnd;
  int status;

  Timer(this.date, this.status, this.timeStart, this.timeEnd);

  Timer.fromSnapshot(DataSnapshot snapshot):
        date  = snapshot.value["date"],
        status  = snapshot.value["status"],
        timeStart  = snapshot.value["timeStart"],
        timeEnd  = snapshot.value["timeEnd"];
  toJson() {
    return {
      "date": date,
      "status": status,
      "timeStart": timeStart,
      "timeEnd": timeEnd,
    };
  }

}