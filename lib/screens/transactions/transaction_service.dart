// lib/services/transaction_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class TransactionService {
  final String apiUrl = 'http://localhost:3000/fetch-transaction';

  Future<Map<String, dynamic>> fetchTransaction(String transId) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'transId': transId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch transaction');
    }
  }
}
