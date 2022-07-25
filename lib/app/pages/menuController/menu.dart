import 'dart:io';

import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as general_bloc;
import 'package:applaudo_tech_challenge_flutter/app/pages/done.dart';
import 'package:applaudo_tech_challenge_flutter/app/pages/menuController/widgets/nav_bar.dart';
import 'package:applaudo_tech_challenge_flutter/app/pages/pending/pending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _ToDoState createState() => _ToDoState();
}
//Genesis principal fork origin route

class _ToDoState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<general_bloc.ToDoBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<general_bloc.ToDoBloc, general_bloc.ToDoState>(
          builder: (context, state) {
            return Stack(
              children: [
                _navigationControl(state.model.pageSelected!),
                NavBarCustom(
                  children: [
                    NavBarCustomChildren(
                        title: 'Pending',
                        path: "assets/todopending.svg",
                        color: state.model.pageSelected == 0
                            ? Colors.orange
                            : Colors.grey,
                        onTap: () => context
                            .read<general_bloc.ToDoBloc>()
                            .add(const general_bloc.OnChangePage(0))),
                    NavBarCustomChildren(
                        title: 'Completed',
                        path: "assets/completed.svg",
                        color: state.model.pageSelected == 1
                            ? Colors.orange
                            : Colors.grey,
                        onTap: () => context
                            .read<general_bloc.ToDoBloc>()
                            .add(const general_bloc.OnChangePage(1))),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _navigationControl(int index) {
    switch (index) {
      case 0:
        // checking PLatform to show iOS bottomsheet style or Android modal style
        return Platform.isIOS
            ? const CupertinoScaffold(body: PendingPage())
            : const PendingPage();

      case 1:
        return Platform.isIOS
            ? const CupertinoScaffold(body: DonePage())
            : const DonePage();

      default:
        return Platform.isIOS
            ? const CupertinoScaffold(body: PendingPage())
            : const PendingPage();
    }
  }
}
