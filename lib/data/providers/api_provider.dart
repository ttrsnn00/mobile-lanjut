import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/utils/api_endpoints.dart';
import '../models/plant_models.dart';
import '../models/order_models.dart';

class ApiProvider {
  // Menyiapkan header standar
  Map<String, String> _setHeaders({String? token}) {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // 1. Fungsi Login
  Future login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoints.login),
        headers: _setHeaders(),
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Login gagal: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Login: $e');
      rethrow;
    }
  }

  // 2. Fungsi Register
  Future register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoints.register),
        headers: _setHeaders(),
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Register gagal: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Register: $e');
      rethrow;
    }
  }

  // 3. Fungsi Ambil Data Tanaman (Katalog)
  Future<List<PlantModel>> getPlants({String? token}) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.plants),
        headers: _setHeaders(token: token),
      );

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var data = decodedData['data'] as List;
        return data.map((json) => PlantModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil data tanaman');
      }
    } catch (e) {
      print('Error getPlants: $e');
      return [];
    }
  }

  // 4. Fungsi Checkout
  Future<bool> checkout(Map<String, dynamic> orderData, String token) async {
    try {
      final response = await http.post(
        Uri.parse(
          ApiEndPoints.checkout,
        ), // PASTIKAN INI .checkout, BUKAN .orders
        headers: _setHeaders(token: token),
        body: jsonEncode(orderData),
      );

      // Laravel mengembalikan 201 Created saat data berhasil ditambahkan
      if (response.statusCode == 201) {
        return true;
      } else {
        print('====== ERROR CHECKOUT ======');
        print('Status Code: ${response.statusCode}');
        print('Isi Response: ${response.body}');
        print('============================');
        return false;
      }
    } catch (e) {
      print('Exception Checkout: $e');
      return false;
    }
  }

  // 5. Fungsi Ambil Profil User
  Future getUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.user),
        headers: _setHeaders(token: token),
      );

      if (response.statusCode == 200) {
        // Karena endpoint /user mengembalikan objek JSON langsung
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print('Gagal mengambil data user');
        return null;
      }
    } catch (e) {
      print('Error getUserProfile: $e');
      return null;
    }
  }

  // 6. Fungsi Ambil Riwayat Pesanan
  Future<List<OrderModel>> getOrderHistory(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.orders),
        headers: _setHeaders(token: token),
      );

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var data = decodedData['data'] as List;
        return data.map((json) => OrderModel.fromJson(json)).toList();
      } else {
        // TAMPILKAN DETAIL ERROR DI SINI
        print('====== ERROR GET ORDERS ======');
        print('Status Code: ${response.statusCode}');
        print('Isi Response: ${response.body}');
        print('==============================');
        return [];
      }
    } catch (e) {
      print('Error getOrderHistory: $e');
      return [];
    }
  }
}
