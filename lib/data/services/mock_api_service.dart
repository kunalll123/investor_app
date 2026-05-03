import 'dart:convert';
import 'package:flutter/services.dart';

class MockApiService {
  Future<List<dynamic>> fetchDeals() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API delay

    final String response = await rootBundle.loadString(
      'lib/data/mock/deals.json',
    );

    return jsonDecode(response);
  }
}
