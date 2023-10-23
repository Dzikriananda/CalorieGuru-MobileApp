
import 'package:internet_connection_checker/internet_connection_checker.dart';
import "dart:core";
import 'package:age_calculator/age_calculator.dart';


Future<bool> checkConnection() async {
  final bool isConnected = await InternetConnectionChecker().hasConnection;
  return isConnected;
}

int calculateAge(String bod) {
    final birthdate = DateTime.parse(bod);
    final int age = AgeCalculator.age(birthdate).years;
    return age;
}


// final StreamSubscription<InternetConnectionStatus> listener =
// InternetConnectionChecker().onStatusChange.listen(
//       (InternetConnectionStatus status) {
//     switch (status) {
//       case InternetConnectionStatus.connected:
//       // ignore: avoid_print
//         print('Data connection is available.');
//         break;
//       case InternetConnectionStatus.disconnected:
//       // ignore: avoid_print
//         print('You are disconnected from the internet.');
//         break;
//     }
//   },
// );
