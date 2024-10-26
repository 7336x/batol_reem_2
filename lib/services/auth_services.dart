import 'package:batol_reem_2/models/user.dart';
import 'package:batol_reem_2/services/pet.dart';
import 'package:batol_reem_2/services/tips_services.dart';
// import 'package:batol_reem_2/services/pets.dart';
import 'package:dio/dio.dart';

class AuthServices {
  Future<String> signup({required User user}) async {
    late String token;
    try {
      Response response =
          await DioClient.dio.post('/signup', data: user.toJson());
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
          await DioClient.dio.post('/signin', data: user.toJson());
      token = response.data["token"];
    } on DioError catch (error) {
      print(error);
    }
    return token;
  }
}
