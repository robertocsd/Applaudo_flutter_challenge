import 'dart:io';

import 'package:applaudo_tech_challenge_flutter/app/pages/pending/sections/create_new_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as general_bloc;
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'sections/edit.dart';

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
    context
        .read<general_bloc.ToDoBloc>()
        .add(const general_bloc.CheckingEmptyEvent());
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
              BlocBuilder<general_bloc.ToDoBloc, general_bloc.ToDoState>(
                builder: (context, state) {
                  return CupertinoButton(
                      child: Text(
                        'Mask all as completed',
                        style: TextStyle(fontSize: blockSizeVertical * 1.7),
                      ),
                      onPressed: state.model.pending == 0 ? null : () {
                        context
                            .read<general_bloc.ToDoBloc>()
                            .add(const general_bloc.MarkAllCompletedEvent());
                      });
                },
              ),
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
            return state.model.pending == 0
                ? Column(
                    children: [
                      SizedBox(height: blockSizeVertical * 18),
                      SvgPicture.asset('assets/empty.svg',
                          color: Colors.orange, height: blockSizeVertical * 20),
                      const Text('This is empty... too empty...',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: state.model.todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return state.model.todos[index].type == false
                            ? Column(
                              children: [
                                Slidable(
                                    key: UniqueKey(),
                                    child: CheckboxListTile(
                                      key: UniqueKey(),
                                      title: Text(state.model.todos[index].title),
                                      onChanged: (value) {
                                        context.read<general_bloc.ToDoBloc>().add(
                                              general_bloc.ChangeState(
                                                  state.model.todos[index].id,
                                                  value!),
                                            );
                                      },
                                      value: state.model.todos[index].type,
                                    ),
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
                                                ? CupertinoScaffold
                                                    .showCupertinoModalBottomSheet(
                                                    context: context,
                                                    builder: (context) => EditToDo(
                                                      idToEdit: state
                                                          .model.todos[index].id,
                                                    ),
                                                  )
                                                : showMaterialModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        SingleChildScrollView(
                                                      controller:
                                                          ModalScrollController.of(
                                                              context),
                                                      child: EditToDo(
                                                        idToEdit: state
                                                            .model.todos[index].id,
                                                      ),
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
                                  ),

                                  state.model.todos.length - 1 == index
                                      ? SizedBox(height: blockSizeVertical * 5)
                                      : SizedBox(height: blockSizeVertical * 1),
                              ],
                            )
                            : Container();
                      },
                    ),
                  );
          },
        )
      ]),
    );
  }
}
