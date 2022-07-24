import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class CreateToDo extends StatelessWidget {
  const CreateToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Scaffold(
    
            
                      body: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Create new todo',
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
                            child: Platform.isAndroid ? const TextField(
                              decoration: InputDecoration(
                                hintText: 'ToDo',
                              ),
                            ) : CupertinoTextField(
                              placeholder: 'ToDo',
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
