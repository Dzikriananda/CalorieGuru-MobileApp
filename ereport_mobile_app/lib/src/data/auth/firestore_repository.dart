import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/models/daily_log_summary.dart';
import 'package:ereport_mobile_app/src/data/models/list_log_model.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class Firestore {
  final db = FirebaseFirestore.instance;

  Future<UserModel?> getUserData(String UID) async {
    final docRef = db.collection("user");
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: UID).get();
      for (var docSnapshot in querySnapshot.docs) {
        final user = UserModel.fromMap(docSnapshot.data());
        return user;
      }
    } catch(e){
      debugPrint('error in getUserData $e');
      return null;
    }


  }

  Future<bool?> hasFilledData(String UID) async{
    final docRef = db.collection("user");
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: UID).get();
      print(querySnapshot.docs);
      for (var docSnapshot in querySnapshot.docs) {
        print(docSnapshot.data());
         return docSnapshot.data()['hasFilledData'];
      }
    } catch(e){
      print("error in hasFilledData : $e");
      return null;
    }
  }

  Future<void> addUser(String uid) async{
    final data = {"uid": uid,"hasFilledData":false};
    try{
      await db.collection("user").add(data).then((documentSnapshot) =>
          debugPrint("Added Data with ID: ${documentSnapshot.id}"));
      await db.collection("log").add({"uid":uid}).then((documentSnapshot) =>
          debugPrint("Added Data with ID: ${documentSnapshot.id}"));
    }
    catch(e){
      debugPrint('error while addUser : $e');
    }
  }

  Future<bool> addLog(bool isMeal,String uid,Map<String,dynamic> log) async {
    const dataSource = Source.server;
    final docRef = db.collection("log");
    int number = 0;
    // late double consumedCalorie;
    String? docId;
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
      for (var docSnapshot in querySnapshot.docs) {
        docId = docSnapshot.id;
      }
      final todayLog = await docRef.doc(docId).collection(getTodayDate());
      final latestLog = await todayLog.orderBy('no',descending: true).limit(1).get();
      for (var docSnapshot in latestLog.docs) {
        number = docSnapshot.data()['no'];
      }
      if(number == null || number == 0){
        // number = 0;
        final user = await getUserData(uid);
        print(user!.calorieNeed);
        final calorieNeed = user!.calorieNeed;
        await todayLog.doc(number.toString()).set({'no':number,'calorieBudget':calorieNeed,'consumedCalories':0.0,'burnedCalories':0.0});
      }
      number++;
      await todayLog.doc(number.toString()).set({'no':number,...log});
      final docZero = await todayLog.doc('0').get();
      if (isMeal) {
        final beforeCalorie = docZero.data()!['consumedCalories'];
        final afterCalorieString = beforeCalorie + log['calories'];
        final value = afterCalorieString.toStringAsFixed(1);
        final afterCalorie = double.parse(value);
        await todayLog.doc('0').update({'consumedCalories':afterCalorie});
      }
      else {
        final beforeCalorie = docZero.data()!['burnedCalories'];
        final afterCalorieString = beforeCalorie + log['calories'];
        final value = afterCalorieString.toStringAsFixed(1);
        final afterCalorie = double.parse(value);
        await todayLog.doc('0').update({'burnedCalories':afterCalorie});
      }
      return true;
    } catch(e) {
      debugPrint('error in addLog $e');
      return false;
    }
  }

  Future<Map<String,dynamic>?> getTodayCalorie(String uid) async{
    const dataSource = Source.server;
    final docRef = db.collection("log");
    String? docId;

    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
      for (var docSnapshot in querySnapshot.docs) {
        docId = docSnapshot.id;
      }
      final todayLog = await docRef.doc(docId).collection(getTodayDate()).doc('0').get();
      return todayLog.data();
    }
    catch(e){
      debugPrint('error in getTodayCalorie $e');

    }
  }

  Future<List<LogModel>> getListLog(String uid) async {
    const dataSource = Source.server;
    final docRef = db.collection("log");
    List<LogModel> logList=[];
    int i = 0;
    String? docId;
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
      for (var docSnapshot in querySnapshot.docs) {
        docId = docSnapshot.id;
      }
      final todayLog = await docRef.doc(docId).collection(getTodayDate()).get();
      for (var docSnapshot in todayLog.docs) {
        if(i!=0){
          logList.add(LogModel.fromMap(docSnapshot.data()));
        }
        i++;
      }
      return logList;
    } catch(e){
      debugPrint('error in getListLog $e');
      return logList;
    }


  }

  // Future<void> getTodayLog(String uid) async {
  //   const dataSource = Source.server;
  //   final docRef = db.collection("log");
  //   String? docId;
  //   try{
  //     final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
  //     for (var docSnapshot in querySnapshot.docs) {
  //       docId = docSnapshot.id;
  //     }
  //     print('mendapatkan firebase');
  //     docRef.doc(docId).collection('02-11-2023').doc('01').get().then((value) => print(value.data()));
  //   } catch(e){
  //     print("error while fetching : $e");
  //   }
  // }

  Future<void> getTodayLatestLog(String uid) async {
    const dataSource = Source.server;
    final docRef = db.collection("log");
    String? docId;
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
      for (var docSnapshot in querySnapshot.docs) {
        docId = docSnapshot.id;
      }
      final latestLog = await docRef.doc(docId).collection('04-11-2023').orderBy('no',descending: true).limit(1).get();
      for (var docSnapshot in latestLog.docs) {
        print(docSnapshot.data());
      }
    } catch(e){
      debugPrint('error in getTodayLatestLog $e');
    }


  }

  Future<bool> updateLog(String uid,int no,Map<String,dynamic> data,bool isMeal) async {
    const dataSource = Source.server;
    final docRef = db.collection("log");
    String? docId;
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
      for (var docSnapshot in querySnapshot.docs) {
        docId = docSnapshot.id;
      }
      final task1 = await docRef.doc(docId).collection(getTodayDate()).doc('0').get();
      final task2 = await docRef.doc(docId).collection(getTodayDate()).doc('$no').get();
      final calorieBefore = task2.data()!['calories'];
      if(isMeal) {
        final consumedCaloriesBefore = task1.data()!['consumedCalories'];
        await docRef.doc(docId).collection(getTodayDate()).doc('$no').update(data);
        final consumedCaloriesAfter = consumedCaloriesBefore - (calorieBefore - data['calories']);
        await docRef.doc(docId).collection(getTodayDate()).doc('0').update({'consumedCalories' : consumedCaloriesAfter});
      }
      else {
        final burnedCaloriesBefore = task1.data()!['burnedCalories'];
        await docRef.doc(docId).collection(getTodayDate()).doc('$no').update(data);
        final burnedCaloriesAfter = burnedCaloriesBefore - (calorieBefore - data['calories']);
        await docRef.doc(docId).collection(getTodayDate()).doc('0').update({'burnedCalories' : burnedCaloriesAfter});
      }
      return true;
    } catch(e) {
      debugPrint('error in updateLog $e');
      return false;
    }
  }

  Future<bool> deleteLog(String uid,int no,bool isMeal) async {
    const dataSource = Source.server;
    final docRef = db.collection("log");
    String? docId;
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
      for (var docSnapshot in querySnapshot.docs) {
        docId = docSnapshot.id;
      }
      final task1 = await docRef.doc(docId).collection(getTodayDate()).doc('0').get();
      final task2 = await docRef.doc(docId).collection(getTodayDate()).doc('$no').get();
      final calorieBefore = task2.data()!['calories'];
      if(isMeal) {
        final consumedCaloriesBefore = task1.data()!['consumedCalories'];
        await docRef.doc(docId).collection(getTodayDate()).doc('$no').delete();
        final consumedCaloriesAfter = consumedCaloriesBefore - calorieBefore;
        await docRef.doc(docId).collection(getTodayDate()).doc('0').update({'consumedCalories' : consumedCaloriesAfter});
      }
      else {
        final burnedCaloriesBefore = task1.data()!['burnedCalories'];
        await docRef.doc(docId).collection(getTodayDate()).doc('$no').delete();
        final burnedCaloriesAfter = burnedCaloriesBefore - calorieBefore;
        await docRef.doc(docId).collection(getTodayDate()).doc('0').update({'burnedCalories' : burnedCaloriesAfter});
      }
      return true;
    } catch(e) {
      debugPrint('error in deleteLog $e');
      return false;
    }


  }

  Future<Map<String,dynamic>> getLogByDate(String uid,String date) async {
    const dataSource = Source.server;
    final docRef = db.collection("log");
    String? docId;
    List<LogModel> logList=[];
    DailyLogSummary? dailyLogSummary;
    int i = 0;
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
      for (var docSnapshot in querySnapshot.docs) {
        docId = docSnapshot.id;
      }
      final dateLog = await docRef.doc(docId).collection(date).get();
      if(dateLog.size != 0) {
        for (var docSnapshot in dateLog.docs) {
          print(docSnapshot.data());
          if(i!=0){
            logList.add(LogModel.fromMap(docSnapshot.data()));
          }
          else {
            dailyLogSummary = DailyLogSummary.fromMap(docSnapshot.data());
          }
          i++;
        }
        return {
          'logSummary' : dailyLogSummary,
          'logList' : logList,
        };
      }
      else return {};
    } catch(e) {
      return {};
      debugPrint('error in getLogByDate $e');
    }

  }


  Future<bool> updateUser(String uid, UserModel data) async{
    const dataSource = Source.server;
    final docRef = db.collection("user");
    String? docId;
    try{
      final querySnapshot = await docRef.where("uid", isEqualTo: uid).get(const GetOptions(source: dataSource));
      for (var docSnapshot in querySnapshot.docs) {
          docId = docSnapshot.id;
      }
      docRef.doc(docId).update(data.toMap());
      return true;

    } catch(e){
      debugPrint('error in update User $e');
      return false;
    }

  }


}