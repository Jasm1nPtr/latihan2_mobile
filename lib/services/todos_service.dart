import 'package:app_store/views/todos_view.dart';
import 'package:get/get.dart';

class TodosService extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodosView>(
      () => TodosView(),
    );
  }
}
