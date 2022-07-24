part of 'bloc.dart';

abstract class ToDoState extends Equatable {
  final Model model;
  const ToDoState(this.model);

  @override
  List<Object> get props => [model];
}

class MenuInitial extends ToDoState {
  const MenuInitial(Model model) : super(model);
}

class MenuChangedState extends ToDoState {
  const MenuChangedState(Model model) : super(model);
}

class Model extends Equatable {
  final int? pageSelected;

  const Model({
    this.pageSelected = 0,
  });

  Model copyWith({
    int? pageSelected,
  }) =>
      Model(
        pageSelected: pageSelected,
      );

  @override
  List<Object?> get props => [pageSelected];
}
