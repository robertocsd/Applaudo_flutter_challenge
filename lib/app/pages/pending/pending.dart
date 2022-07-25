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

import 'edit.dart';

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
    MediaQueryData _mediaQueryData;
    double screenHeight;
    double blockSizeVertical;
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    blockSizeVertical = screenHeight / 100;
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 30, left: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Pending',
              style: TextStyle(
                fontFamily: 'Inter',
                color: const Color(0xff272727),
                fontSize: blockSizeVertical * 5,
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
                  child: Text(
                    'Mask all as completed',
                    style: TextStyle(fontSize: blockSizeVertical * 1.7),
                  ),
                  onPressed: () {
                    print('SIU');
                  }),
              CupertinoButton(
                  child: Text(
                    'Add new todo',
                    style: TextStyle(fontSize: blockSizeVertical * 1.7),
                  ),
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
                              child: const CreateToDo(),
                            ),
                          );
                  })
            ],
          ),
        ),
        BlocBuilder<general_bloc.ToDoBloc, general_bloc.ToDoState>(
          builder: (context, state) {
            return state.model.todos.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: state.model.todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return state.model.todos[index].type == false
                            ? Slidable(
                                child: CheckboxListTile(
                                  title: Text(state.model.todos[index].title),
                                  onChanged: (value) {},
                                  value: state.model.todos[index].type,
                                ),
                                key: UniqueKey(),
                                startActionPane: ActionPane(
                                  key: UniqueKey(),
                                  motion: const ScrollMotion(),
                                  dismissible: DismissiblePane(
                                      key: UniqueKey(),
                                      onDismissed: () {
                                        context
                                            .read<general_bloc.ToDoBloc>()
                                            .add(
                                                general_bloc.DeletingAToDoEvent(
                                                    state.model.todos[index]
                                                        .id));
                                      }),
                                  children: [
                                    SlidableAction(
                                      onPressed: (e) {
                                        context
                                            .read<general_bloc.ToDoBloc>()
                                            .add(
                                                general_bloc.DeletingAToDoEvent(
                                                    state.model.todos[index]
                                                        .id));
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: (e) {

                                         Platform.isIOS
                        ? CupertinoScaffold.showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) =>  EditToDo(idToEdit: state.model.todos[index].id,),
                          )
                        : showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child:  EditToDo(idToEdit: state.model.todos[index].id,),
                            ),
                          );
                                        

                                      },
                                      backgroundColor: const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                              )
                            : Container();
                      },
                    ),
                  )
                : Text('PUTA ESTO ESTÁ VACIO');
          },
        )
      ]),
    );
  }
}
