import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class CountdownProvider with ChangeNotifier {
  Duration countdownDuration = Duration.zero;
  late Timer timer;

  CountdownProvider() {
    _fetchInitialCountdown();
  }

  Future<void> _fetchInitialCountdown() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('countdowns').doc('timer').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        DateTime endTime = (data['endTime'] as Timestamp).toDate();
        countdownDuration = endTime.difference(DateTime.now());
        _startTimer();
      }
    } catch (e) {
      print('Error fetching countdown: $e');
    }
  }

  Future<void> setCountdownTimestamp(DateTime endTime) async {
    try {
      await FirebaseFirestore.instance
          .collection('countdowns')
          .doc('timer')
          .set({'endTime': endTime});
      countdownDuration = endTime.difference(DateTime.now());
      _startTimer();
      notifyListeners();
    } catch (e) {
      print('Error setting countdown timestamp: $e');
    }
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => _updateCountdown());
  }

  void _updateCountdown() {
    countdownDuration -= Duration(seconds: 1);
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
