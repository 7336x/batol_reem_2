import 'dart:io';
import 'package:batol_reem_2/services/pet.dart';
import 'package:dio/dio.dart';
import 'package:batol_reem_2/models/user.dart';
import 'package:batol_reem_2/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String token = "";
  late User user; // Keep track of the user

  Future<bool> signup({required User user}) async {
    try {
      token = await AuthServices().signup(user: user);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      setToken(token);
      this.user = user; // Save user details after signup
      notifyListeners();
      return true; // Signup successful
    } catch (e) {
      // Handle exceptions (e.g., show an error message)
      return false; // Signup failed
    }
  }

  Future<bool> signin({required User user}) async {
    try {
      token = await AuthServices().signin(user: user);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      setToken(token);
      this.user = user; // Save user details after signin
      notifyListeners();
      return true; // Signin successful
    } catch (e) {
      // Handle exceptions (e.g., show an error message)
      return false; // Signin failed
    }
  }

  bool isAuth() {
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
    await prefs.setString('token', token);
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }
}
