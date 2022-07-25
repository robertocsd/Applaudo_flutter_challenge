import 'package:dio/dio.dart';

class Repository {
  Repository();

  Future<Response> postTodo(String title) async {
    final response = await Dio().post(
        "https://jsonplaceholder.typicode.com/todos",
        data: {"userId": 1, "id": 1, "title": title, "completed": false});

    return response;
  }
}
