import 'package:firebase_database/firebase_database.dart';

class Status {

  int status;
  Status(this.status);

  Status.fromSnapshot(DataSnapshot snapshot):
        status  = snapshot.value;

  toJson() {
    return {
      status
    };
  }

}