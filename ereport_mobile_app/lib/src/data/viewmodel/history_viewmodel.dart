import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:ereport_mobile_app/src/data/models/daily_log_summary.dart';
import 'package:ereport_mobile_app/src/data/models/list_log_model.dart';
import 'package:flutter/material.dart';
import '../../core/constants/result_state.dart';
import '../auth/auth.dart';

class HistoryViewModel extends ChangeNotifier {
  late ResultState _state;
  late Auth auth;
  late Firestore firestore;
  late Map<String,dynamic> _log;
  late DateTime _focusDate;
  late DailyLogSummary _logSummary;
  late List<LogModel> _activityList;
  String? _currentDate;


  HistoryViewModel() {
    _state = ResultState.started;
    auth = Auth();
    firestore = Firestore();
    _focusDate = DateTime.now();
    _currentDate = convertDate(DateTime.now());
    _logSummary = DailyLogSummary.empty();
    _log = {};
    _activityList = [];
  }

  void disposeViewModel(){
    _state = ResultState.started;
    _currentDate = null;
  }

  DateTime get focusDate => _focusDate;
  String? get currentDate => _currentDate;
  Map<String,dynamic> get log => _log;
  ResultState get state => _state;
  DailyLogSummary get logSummary => _logSummary;
  List<LogModel> get activityList => _activityList;

  set focusDate(DateTime inputDate) {
    String date = convertDate(inputDate);
    _focusDate = inputDate;
    _currentDate = date;
    _getLog();
    notifyListeners();
  }

  Future<void> _getLog() async {
    _state = ResultState.loading;
    notifyListeners();
    try {
      final uid = await auth.getCurrentUID();
      _log = await firestore.getLogByDate(uid!, currentDate!);
      if (_log['logList'] == null) {
        _logSummary.setToZero();
        _state = ResultState.noData;
      } else {
        _logSummary = _log['logSummary'];
        _activityList = _log['logList'];
        final remainingCal = ( _logSummary.calorieBudget! - (_logSummary.consumedCalories! - _logSummary.burnedCalories!)).toStringAsFixed(1);
        _logSummary.remainingCalories = double.parse(remainingCal);
        _state = ResultState.hasData;
      }
    }
    catch(e) {
      debugPrint('Error in _getLog (history_viewmodel.dart): $e');
      _state = ResultState.error;
    }
    notifyListeners();
  }



}