abstract class TodoEvent {
  const TodoEvent();
}

class FetchTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String task;
  const AddTodo(this.task);
}

class RemoveTodo extends TodoEvent {
  final int index;
  const RemoveTodo(this.index);
}