import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applaudo_tech_challenge_flutter/app/bloc/bloc.dart'
    as general_bloc;
import 'package:flutter_slidable/flutter_slidable.dart';

class DonePage extends StatelessWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 30, left: 16),
        child: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Completed',
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
      BlocBuilder<general_bloc.ToDoBloc, general_bloc.ToDoState>(
        builder: (context, state) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.model.todos!.length,
              itemBuilder: (BuildContext context, int index) {
                return state.model.todos![index].type == true
                    ? Slidable(
                        child: CheckboxListTile(
                          title: Text(state.model.todos![index].title),
                          onChanged: (value) {
                            print(value);
                          },
                          value: state.model.todos![index].type,
                        ),
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
                    : Container();
              },
            ),
          );
        },
      )
      // Row(
      //     mainAxisSize: MainAxisSize.min,

      //   children: [
      //     CupertinoButton(
      //         child: const Text('Mask all todos as completed'),
      //         onPressed: () {
      //           print('SIU');
      //         })
      //   ],
      // )
    ]);
  }
}
