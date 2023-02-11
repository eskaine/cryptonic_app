import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class CryptoService with ChangeNotifier {
  Future<Map<String, dynamic>> fetchCurrencies(String currency) async {
    final response = await http.get(Uri.parse(API_CURRENCIES + currency));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['data']['rates'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
