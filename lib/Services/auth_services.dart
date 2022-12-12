import 'dart:convert';

import 'package:flutterapp/Services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final String token = '';
  static Future<http.Response> register(
      String name, String email, String password, String device_name) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": password,
      "device_name": device_name,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(
      String email, String password, String device_name) async {
    Map data = {
      "email": email,
      "password": password,
      "device_name": device_name,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('token');
    print(response.body);
    var datas = json.decode(response.body);

    save('token', datas['token']);
    save('name', datas['name']);
    return response;
  }

  static Future<http.Response> logout(String token) async {
    var url = Uri.parse(baseURL + 'auth/logout');
    final body = {};
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' '$token',
    };

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);
    return response;
  }

  getKategori() async {
    final url = Uri.parse(baseURL + 'category');
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final token = prefs.getString(key);
    final headers = {
      'Authorization': 'Bearer ' + '$token',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: headers);
    print('kategori');
    print(response.body);
    return response;
  }

  static save(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    // const key = 'token';
    // final value = token;
    prefs.setString(key, data);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
