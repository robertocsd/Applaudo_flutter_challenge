import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as generalBloc;
import 'package:applaudo_tech_challenge_flutter/app/menuController/menu.dart';
import 'package:applaudo_tech_challenge_flutter/app/pages/pending/create_new_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class GlobalModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind((i) => warehouse_bloc.Bloc()),
    Bind.singleton(
      (i) => generalBloc.ToDoBloc(),
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
      // ChildRoute(
      //   '/register',
      //   child: (context, args) => const  CupertinoScaffold.showCupertinoModalBottomSheet(
      //             enableDrag: false,
      //             context: ,
      //             builder: (context) => const ElectionPageModal(),
      //           ),
      //   transition: TransitionType.fadeIn,
      // // ),
      // ChildRoute(
      //   '/register_admin',
      //   child: (_, args) => const AdminRegisterFlow(),
      //   transition: TransitionType.fadeIn,
      // ),
      // ChildRoute(
      //   '/election',
      //   child: (_, args) => const ElectionPageModal(),
      //   transition: TransitionType.fadeIn,
      // ),

      // ModuleRoute('/b2b', module: B2BModule()),
      // ModuleRoute(
      //   '/address',
      //   module: AddressModule(),
      // ),
      // ModuleRoute(
      //   '/auth',
      //   module: AuthModule(),
      // ),
      // ModuleRoute(
      //   '/payments_methods',
      //   module: PaymentMethodsModule(),
      // ),
      // ChildRoute(
      //   '/dashboard_b2c',
      //   child: (_, args) => const b2c.DashboardPage(),
      //   transition: TransitionType.fadeIn,
      // ),
      // ChildRoute(
      //   '/terms/:type',
      //   child: (_, args) => terms.Page(
      //     type: args.params['type'],
      //     showFaqs: (args.data ?? {})['showFaqs'] ?? false,
      //     blocProvider: (args.data ?? {})['bloc'] ?? Modular.get<terms.Bloc>(),
      //     guest: (args.data ?? {})['guest'] ?? false,
      //     title: (args.data ?? {})['title'],
      //     titleSize: (args.data ?? {})['titleSize'] ?? 16.0,
      //   ),
      //   transition: TransitionType.fadeIn,
      // ),
    ];
  }
}
