import 'package:app_store/models/todos.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TodosView extends StatefulWidget {
  const TodosView({Key? key}) : super(key: key);

  @override
  State<TodosView> createState() => _TodosView();
}

class _TodosView extends State<TodosView> {
  late Future<Todos?> _futureTodos; 

  @override
  void initState() {
    super.initState();
    _futureTodos = fetchTodos();
  }

  Future<Todos?> fetchTodos() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/5'));
      if (response.statusCode == 200) {
        return Todos.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Todos?>(
          future: _futureTodos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text('userId: '),
                      Text('${snapshot.data!.userId}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('id: '),
                      Text('${snapshot.data!.id}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('title: '),
                      Text(snapshot.data!.title),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
