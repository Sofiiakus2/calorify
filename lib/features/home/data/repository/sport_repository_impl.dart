import 'package:calorify/features/home/domain/entities/sport.dart';
import 'package:calorify/features/home/domain/repositories/sport_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

///Sport repository Implementation
class SportRepositoryImpl extends SportRepository{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addSport(Sport sport) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return;
    final date = DateTime.now();

    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    final userDoc = firestore.collection('users').doc(currentUser.uid);
    final dayDoc = userDoc.collection('days').doc(dateKey);

    await dayDoc.set({'exists': true}, SetOptions(merge: true));

    final sportsCollection = dayDoc.collection('sports');
    final newSportRef = sportsCollection.doc(sport.id.toString());

    final batch = firestore.batch();

    batch.set(newSportRef, sport.toJson());

    final daySummaryRef = dayDoc.collection('totals').doc('summary');
    batch.set(daySummaryRef, {
      'burnedCalories': FieldValue.increment(sport.calories),
    }, SetOptions(merge: true));

    await batch.commit();
  }

  @override
  Future<void> deleteSport(Sport sport) async {

    final currentUser = auth.currentUser;
    if (currentUser == null) return;

    final date = DateTime.now();
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    final userDoc = firestore.collection('users').doc(currentUser.uid);
    final dayDoc = userDoc.collection('days').doc(dateKey);

    final sportsCollection = dayDoc.collection('sports');
    final sportDoc = sportsCollection.doc(sport.id.toString());

    final batch = firestore.batch();

    batch.delete(sportDoc);

    final daySummaryRef = dayDoc.collection('totals').doc('summary');
    batch.set(daySummaryRef, {
      'burnedCalories': FieldValue.increment(-sport.calories),
    }, SetOptions(merge: true));

    await batch.commit();
  }


  @override
  Future<List<Sport>> getSport() async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return [];

    final date = DateTime.now();
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    final userDoc = firestore.collection('users').doc(currentUser.uid);
    final dayDoc = userDoc.collection('days').doc(dateKey);

    final sportsCollection = dayDoc.collection('sports');
    final querySnapshot = await sportsCollection.get();

    List<Sport> sportsList = querySnapshot.docs.map((doc) {
      final data = doc.data();

      return Sport.fromJson(data);
    }).toList();

    return sportsList;
  }



}
