import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Time {
  String? id;
  String? time;

  bool loading = false;

  late Map<String, dynamic> data;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Time();

  Time.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    time = documentSnapshot['time'] as String;
  }

  Future<String> setTime(String chosenTime) async {
    DocumentReference doc;

    data = {
      'time': chosenTime,
    };

    doc = await _firestore
        .collection('time')
        .add(data);

    return doc.id;
  }

  Future<void> delete() async {
    await _firestore
        .collection('time').doc(id).delete();
  }

  Future<List<Time>> getScheduledTime() async {
    loading = true;

    List<Time> listTime = [];

    QuerySnapshot querySnapshot;

    querySnapshot = await _firestore
        .collection('time')
        .get();

    if (querySnapshot.size > 0) {
      listTime = querySnapshot.docs
          .map((documentSnapshot) => Time.fromDocument(documentSnapshot))
          .toList();
    }

    loading = false;

    return listTime;
  }

}
