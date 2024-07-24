import 'dart:convert';
import 'package:api_veri/product/utility/constants/string_constants.dart';
import 'package:http/http.dart' as http;

mixin ApiServiceMixin {
  Future<T> getRequest<T>(String url, Function(dynamic data) fromJson) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        return fromJson(data) as T;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<T> postRequest<T>(
      String url, dynamic body, Function(dynamic data) fromJson) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {AppString.contentType: AppString.header},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        return fromJson(data) as T;
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error posting data: $e');
    }
  }

  Future<T> putRequest<T>(
      String url, dynamic body, Function(dynamic data) fromJson) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {AppString.contentType: AppString.header},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        return fromJson(data) as T;
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      throw Exception('Error updating data: $e');
    }
  }

  Future<void> deleteRequest(String url) async {
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }
}
