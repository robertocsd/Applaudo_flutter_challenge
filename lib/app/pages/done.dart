import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
