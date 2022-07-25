import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as general_bloc;

class EditToDo extends StatelessWidget {
  final int idToEdit;
  const EditToDo({Key? key, required this.idToEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData;
    double screenHeight;
    double blockSizeVertical;
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;

    blockSizeVertical = screenHeight / 100;
    return BlocProvider.value(
      value: Modular.get<general_bloc.ToDoBloc>(),
      child: BlocBuilder<general_bloc.ToDoBloc, general_bloc.ToDoState>(
        builder: (context, state) {
          return SizedBox(
            height: blockSizeVertical * 70,
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Edit this to-do',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xff272727),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.9,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: blockSizeVertical * 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Platform.isAndroid
                        ? TextField(
                           maxLength: 20,

                            onChanged: (e) {
                              context.read<general_bloc.ToDoBloc>().add(
                                    general_bloc.ChangingTitle(e),
                                  );
                            },
                            decoration: const InputDecoration(
                              hintText: 'Title',
                            ),
                          )
                        : CupertinoTextField(
                           maxLength: 20,
                            onChanged: (value) {
                              context.read<general_bloc.ToDoBloc>().add(
                                    general_bloc.ChangingTitle(value),
                                  );
                            },
                            placeholder: 'ToDo',
                          ),
                  ),
                  SizedBox(height: blockSizeVertical * 5),
                  CupertinoButton(
                      child: const Text('Create'),
                      onPressed: state.model.title == ''
                          ? null
                          : () {
                              Navigator.pop(context);
                              context.read<general_bloc.ToDoBloc>().add(
                                    general_bloc.EditAToDoEvent(
                                        idToEdit, state.model.title!),
                                  );
                            }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
