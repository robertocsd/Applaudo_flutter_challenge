import 'package:flutter_modular/flutter_modular.dart';

class GlobalModule extends Module {
  final globalModule = GlobalModule();

  @override
  List<ModularRoute> get routes {
    return [
      ModuleRoute('/', module: globalModule),
    ];
  }
}
