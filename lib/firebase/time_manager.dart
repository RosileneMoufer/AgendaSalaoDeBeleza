import 'dart:async';

import 'package:agendasalaodebeleza/firebase/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeManager extends ChangeNotifier {

  Time time = Time();

  List<Time> listTime = [];
  late String currentUserId;

  TimeManager();

  Future<void> setTime(String chosenTime) async {
    Time time = Time();

    await time.setTime(chosenTime);

    notifyListeners();
  }

  Future<void> delete(Time time) async {
    await time.delete();

    notifyListeners();
  }

  Future<List<Time>> getScheduledTime() async {
    Time time = Time();

    await time.getScheduledTime().then((list) {
      listTime = List.from(list);
    });

    notifyListeners();

    return listTime;
  }

}
