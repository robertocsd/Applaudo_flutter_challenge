import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as general_bloc;
import 'package:applaudo_tech_challenge_flutter/app/pages/menuController/menu.dart';
import 'package:applaudo_tech_challenge_flutter/app/pages/pending/sections/create_new_todo.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class GlobalModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton(
      (i) =>
          general_bloc.ToDoBloc()..add(const general_bloc.CheckingEmptyEvent()),
    ),
  ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        Modular.initialRoute,
        child: (_, args) => const Menu(),
        transition: TransitionType.fadeIn,
      ),
      ChildRoute(
        '/createnewone',
        child: (_, args) => const CreateToDo(),
        transition: TransitionType.fadeIn,
      ),
    ];
  }
}
