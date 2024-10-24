import 'dart:io';
import 'package:batol_reem_2/services/pets.dart';
import 'package:dio/dio.dart';
import 'package:batol_reem_2/models/user.dart';
import 'package:batol_reem_2/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String token = "";
  late User user;

  void signup({required User user}) async {
    // token = await AuthServices().signup(user: user);
    // print(token);
    token = await AuthServices().signup(user: user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    setToken(token);
    notifyListeners();
  }

  void signin({required User user}) async {
    // token = await AuthServices().signin(user: user);
    // print(token);
    // notifyListeners();
    token = await AuthServices().signin(user: user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    setToken(token);
    notifyListeners();
  }

  bool isAuth() {
    // checking the expiry
    if (token.isNotEmpty && !Jwt.isExpired(token)) {
      user = User.fromJson(Jwt.parseJwt(token));
      DioClient.client.options.headers = {
        HttpHeaders.authorizationHeader: "Bearer $token",
      };
      return true;
    }

    return false;
  }

  Future<void> initializeAuth() async {
    await getToken();
  }

  Future<void> signout() async {
    token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    notifyListeners();
  }

  void setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }
}
