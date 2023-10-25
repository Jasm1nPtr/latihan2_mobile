import 'dart:convert';
import 'package:app_store/models/todos.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodosController extends GetxController {
  //TODO: Implement ApiServiceController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Todos> fetchTodos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/5'));
    if (response.statusCode == 200) {
      return Todos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}

