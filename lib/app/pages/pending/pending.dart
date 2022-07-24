import 'dart:io';

import 'package:applaudo_tech_challenge_flutter/app/pages/pending/create_new_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as general_bloc;
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<general_bloc.ToDoBloc>(),
      //We use Platform to get the OS type and show an native modalsheet style
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 30, left: 16),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Pending',
              style: TextStyle(
                fontFamily: 'Inter',
                color: Color(0xff272727),
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.88,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                  child: const Text('Mask all todos as completed'),
                  onPressed: () {
                    print('SIU');
                  }),
              CupertinoButton(
                  child: const Text('Add new todo'),
                  onPressed: () {
                    Platform.isIOS
                        ? CupertinoScaffold.showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => const CreateToDo(),
                          )
                        : showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: CreateToDo(),
                            ),
                          );
                  })
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Slidable(
                child: const ListTile(title: Text('Slide me')),
                key: const ValueKey(0),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (e) {
                        print('siu');
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (e) {
                        print('siu');
                      },
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
