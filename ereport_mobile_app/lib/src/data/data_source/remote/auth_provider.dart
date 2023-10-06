abstract class AuthProvider {
  // Future<AuthResponse?> userSignin(SigninRequest model);
}

// class AuthProviderImpl extends GetConnect implements AuthProviderInterface {
  // @override
  // Future<AuthResponse?> userSignin(SigninRequest model) async {
  //   FormData formData = FormData(model.toJson());
  //   final response = await post(
  //     Api.signinUrl,
  //     formData,
  //   );

  //   if (response.isOk) {
  //     AuthResponse userData = AuthResponse.fromJson(response.body);
  //     if (userData.status!) {
  //       return userData;
  //     } else {
  //       GeneralFailure.popErrorDialog(userData.message!);
  //       return null;
  //     }
  //   } else {
  //     String errorMess = GeneralFailure.code(response.statusCode ?? 0).message;
  //     GeneralFailure.popErrorDialog(errorMess);
  //     return null;
  //   }
  // }
// }