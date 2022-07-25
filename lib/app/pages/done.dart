import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as general_bloc;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class DonePage extends StatelessWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
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
              'Completed',
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
        BlocBuilder<general_bloc.ToDoBloc, general_bloc.ToDoState>(
          builder: (context, state) {
            return state.model.completed == 0
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
                        return state.model.todos[index].type == true
                            ? Slidable(
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
                                  ],
                                ),
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
