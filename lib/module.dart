import 'dart:ui';

import 'package:applaudo_tech_challenge_flutter/app/module_global.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GlobalModule extends Module {
  final globalModule = GlobalModule();
  // TulpayModule() {
  //   final appConfig = Modular.get<AppConfig>();

  //   S.load(
  //     Locale(
  //       appConfig.country.locale!.languageCode!,
  //       appConfig.country.locale!.countryCode,
  //     ),
  //   );
  // }

  @override
  List<Bind> get binds => [
        // Bind((i) => AuthBloc()),

        // Bind(
        //   (i) =>
        //       limtibloc.InfoLimitBloc()..add(limtibloc.GettingQuestionsEvent()),
        // ),
      ];

  @override
  List<ModularRoute> get routes {
    return [
      // ChildRoute(
      //   Modular.initialRoute,
      //   child: (_, args) => const ComunifyApp(),
      //   transition: TransitionType.fadeIn,
      // ),
      ModuleRoute('/', module: globalModule),
      // ChildRoute(
      //   '/registration',
      //   child: (_, args) => const registration.Page(),
      //   transition: TransitionType.fadeIn,
      // ),

      // ChildRoute(
      //   '/state_transaction',
      //   child: (_, args) => state_transaction.Page(
      //     processUid: args.data['processUid'],
      //     screen: args.data['screen'],
      //     cashInStatusResponse: args.data['cashInStatusResponse'],
      //   ),
      //   transition: TransitionType.fadeIn,
      // ),
    ];
  }
}
