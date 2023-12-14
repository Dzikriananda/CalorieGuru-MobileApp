import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/models/feedback_model.dart';
import 'package:flutter/material.dart';
import '../../core/constants/result_state.dart';
import '../auth/auth.dart';
import '../auth/firestore_repository.dart';

class FeedBackViewModel extends ChangeNotifier{

  late ResultState _state;
  late Auth auth;
  String? _feedbackMessage;
  late Firestore firestore;
  int? _emojiIndex;
  String? _message;
  late bool _isOptionEmpty;

  ResultState get state => _state;
  String? get message => _message;

  FeedBackViewModel({required this.auth,required this.firestore}){
    _state = ResultState.started;
    _isOptionEmpty = false;

  }

  set pressed(int index) {
    (_emojiIndex == index) ? _emojiIndex = null : _emojiIndex = index;
    notifyListeners();
  }

  bool get isOptionEmpty => _isOptionEmpty;

  Color getColor(int index) {
    switch(index) {
      case 1 :
        return (index == _emojiIndex) ? Colors.blue : Colors.black;
      case 2 :
        return (index == _emojiIndex) ? Colors.blue : Colors.black;
      case 3 :
        return (index == _emojiIndex) ? Colors.blue : Colors.black;
      default :
        return Colors.black;
    }
  }

  set feedback(String inputFeedback){
    _feedbackMessage = inputFeedback;
  }

  Future<void> sendFeedback() async {
    _state = ResultState.loading;
    notifyListeners();
    try{
      final uid = await auth.getCurrentUID();
      if(_emojiIndex == null) {
        _state = ResultState.started;
        _isOptionEmpty = true;
        _message = TextStrings.feedbackScreen_11;
        notifyListeners();
      }
      else {
        _isOptionEmpty = false;
        notifyListeners();
        final feedback = FeedBackModel(uid: uid!,feedback: _feedbackMessage!,satisficationLevel: _emojiIndex!);
        if(await checkConnection()) {
          await firestore.sendFeedback(feedback);
          _message = TextStrings.feedbackScreen_10;
          _state = ResultState.success;
        }
        else {
          _message = TextStrings.noConnection;
          _state = ResultState.noConnection;
        }
      }
    }
    catch (e) {
      debugPrint(TextStrings.errorRuntime('sendFeedback', 'feedback_viewmodel.dart', e.toString()));
      _message = 'Error : $e';
      _state = ResultState.error;
    }
    notifyListeners();
  }

  void disposeViewModel() {
    _state = ResultState.started;
    _feedbackMessage = null;
    _emojiIndex = null;
    _message = null;
  }

}