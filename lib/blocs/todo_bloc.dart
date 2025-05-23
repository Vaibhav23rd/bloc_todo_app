import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super( TodoLoading()) {
    on<FetchTodos>((event, emit) async {
      emit( TodoLoading());
      final prefs = await SharedPreferences.getInstance();
      final cachedTodos = prefs.getStringList('todos') ?? [];
      emit(TodoLoaded(cachedTodos));
    });

    on<AddTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final updatedTodos = List<String>.from((state as TodoLoaded).todos)..add(event.task);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('todos', updatedTodos);
        emit(TodoLoaded(updatedTodos));
      }
    });

    on<RemoveTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final updatedTodos = List<String>.from((state as TodoLoaded).todos)..removeAt(event.index);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('todos', updatedTodos);
        emit(TodoLoaded(updatedTodos));
      }
    });
  }
}