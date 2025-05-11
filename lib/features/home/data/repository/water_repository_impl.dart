import 'package:calorify/features/home/domain/repositories/water_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class WaterRepositoryImpl extends WaterRepository{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addWaterToDb(int milliliters, DateTime date) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return;

    final dateKey = DateFormat('yyyy-MM-dd').format(date);

    final userDoc = firestore.collection('users').doc(currentUser.uid);
    final dayDoc = userDoc.collection('days').doc(dateKey);

    // Упевнюємося, що документ дня існує
    await dayDoc.set({'exists': true}, SetOptions(merge: true));

    final daySummaryRef = dayDoc.collection('totals').doc('summary');

    await daySummaryRef.set({
      'water': FieldValue.increment(milliliters),
    }, SetOptions(merge: true));
  }

  @override
  Future<int> getWaterForDay(DateTime date) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return 0;

    final dateKey = DateFormat('yyyy-MM-dd').format(date);

    final summaryDoc = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('days')
        .doc(dateKey)
        .collection('totals')
        .doc('summary')
        .get();

    final data = summaryDoc.data();
    return (data != null && data['water'] != null) ? data['water'] as int : 0;
  }

  @override
  Future<void> removeWaterFromDb(int milliliters, DateTime date) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return;

    final dateKey = DateFormat('yyyy-MM-dd').format(date);

    final userDoc = firestore.collection('users').doc(currentUser.uid);
    final dayDoc = userDoc.collection('days').doc(dateKey);

    // Переконуємось, що документ дня існує
    await dayDoc.set({'exists': true}, SetOptions(merge: true));

    final daySummaryRef = dayDoc.collection('totals').doc('summary');

    await daySummaryRef.set({
      'water': FieldValue.increment(-milliliters),
    }, SetOptions(merge: true));
  }



}