import 'package:batol_reem_2/models/user.dart';
import 'package:batol_reem_2/services/yoga.dart';
// import 'package:batol_reem_2/services/pets.dart';
import 'package:dio/dio.dart';

class AuthServices {
  Future<String> signup({required User user}) async {
    late String token;
    try {
      Response response =
          await DioClient.client.post('/signup', data: user.toJson());
      token = response.data["token"];
    } on DioError catch (error) {
      print(error);
    }
    return token;
  }

  Future<String> signin({required User user}) async {
    late String token;
    try {
      Response response =
          await DioClient.client.post('/signin', data: user.toJson());
      token = response.data["token"];
    } on DioError catch (error) {
      print(error);
    }
    return token;
  }
}
