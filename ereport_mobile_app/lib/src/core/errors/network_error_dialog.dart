// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/status/http_status.dart';

// class NetworkErrorDialog extends GetConnect {
//   final String message;

  // NetworkErrorDialog([this.message = "An Unknown Error occurred. Check your connection and try again"]);

  // factory NetworkErrorDialog.code(int code) {
  //   switch (code) {
  //     case HttpStatus.unauthorized:
  //       return NetworkErrorDialog("$code: Is Unauthorized");
  //     case HttpStatus.badGateway:
  //       return NetworkErrorDialog("$code: Bad Gateway");
  //     case HttpStatus.badRequest:
  //       return NetworkErrorDialog("$code: Bad Request");
  //     case HttpStatus.clientClosedRequest:
  //       return NetworkErrorDialog("$code: Client closed request");
  //     case HttpStatus.conflict:
  //       return NetworkErrorDialog("$code: Conflicted");
  //     case HttpStatus.connectionClosedWithoutResponse:
  //       return NetworkErrorDialog("$code: Connection closed without response");
  //     case HttpStatus.forbidden:
  //       return NetworkErrorDialog("$code: Forbidden");
  //     case HttpStatus.tooManyRequests:
  //       return NetworkErrorDialog("$code: Too many requests");
  //     case HttpStatus.notFound:
  //       return NetworkErrorDialog("$code: Not Found");
  //     case HttpStatus.methodNotAllowed:
  //       return NetworkErrorDialog("$code: Method Not Allowed");
  //     case HttpStatus.insufficientStorage:
  //       return NetworkErrorDialog("$code: Insufficient Storage");
  //     case HttpStatus.requestTimeout:
  //       return NetworkErrorDialog("$code: Request Timeout");
  //     case HttpStatus.internalServerError:
  //       return NetworkErrorDialog("$code: Internal Server Error");
  //     case HttpStatus.unsupportedMediaType:
  //       return NetworkErrorDialog("$code: Unsupported Media Type");
  //     default:
  //       return NetworkErrorDialog();
  //   }
  // }

  // NetworkErrorDialog.popErrorDialog(this.message) {
  //   Get.defaultDialog(
  //     contentPadding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
  //     title: "Error",
  //     titlePadding: const EdgeInsets.only(top: 30),
  //     middleText: message,
  //     confirmTextColor: Colors.white,
  //     cancel: Container(
  //       // margin: EdgeInsets.symmetric(horizontal: 25),
  //       child: FilledButton(
  //         onPressed: () {
  //           Get.back();
  //         },
  //         child: const Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(Icons.close),
  //             Text("Close"),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // NetworkErrorDialog.popErrorSnackbar(this.message) {
  //   Get.showSnackbar(
  //     GetSnackBar(
  //       backgroundColor: ConstColors.redColor,
  //       title: "Error",
  //       message: message,
  //       icon: const Icon(
  //         Icons.close,
  //         color: ConstColors.whiteColor,
  //       ),
  //       duration: const Duration(seconds: 3),
  //     ),
  //   );
  // }
// }
