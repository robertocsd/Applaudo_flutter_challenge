import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as general_bloc;

class CreateToDo extends StatelessWidget {
  const CreateToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData;
    double screenWidth;
    double screenHeight;
    double blockSizeHorizontal;
    double blockSizeVertical;
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    return BlocProvider.value(
      value: Modular.get<general_bloc.ToDoBloc>(),
      child: BlocBuilder<general_bloc.ToDoBloc, general_bloc.ToDoState>(
        builder: (context, state) {
          return SizedBox(
            height: blockSizeVertical * 40,
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create new to-do',
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Platform.isAndroid
                        ? TextField(
                            onChanged: (e) {
                              context.read<general_bloc.ToDoBloc>().add(
                                    general_bloc.ChangingTitle(e),
                                  );
                            },
                            decoration: InputDecoration(
                              hintText: 'Title',
                            ),
                          )
                        : CupertinoTextField(
                            onChanged: (value) {
                              context.read<general_bloc.ToDoBloc>().add(
                                    general_bloc.ChangingTitle(value),
                                  );
                            },
                            placeholder: 'ToDo',
                          ),
                  ),
                  CupertinoButton(
                      child: Text('Create'),
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<general_bloc.ToDoBloc>().add(
                              general_bloc.NewTodoEvent(),
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
