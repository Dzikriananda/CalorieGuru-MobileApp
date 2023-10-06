import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionManager {
  static final InternetConnectionManager _singleton = InternetConnectionManager._internal();

  factory InternetConnectionManager() {
    return _singleton;
  }

  InternetConnectionManager._internal();

  late StreamSubscription<InternetConnectionStatus> _subscription;

  void init() {
    _subscription = InternetConnectionChecker().onStatusChange.listen(
          (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            print('Jaringan Tersedia');
            break;
          case InternetConnectionStatus.disconnected:
            print('Tidak ada Jaringan');
            break;
        }
      },
    );
  }

  void dispose() {
    _subscription?.cancel();
  }
}