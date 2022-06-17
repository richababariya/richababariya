// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  const AdaptiveFlatButton(this.text, this.handler, {Key? key})
      : super(key: key);
  final text;
  final handler;

  @override
  Widget build(BuildContext context) {
    return
        // Platform.isIOS
        //     ? CupertinoButton(
        //         //color: Colors.purple,
        //         onPressed: () {
        //           handler;
        //         },
        //         child: Text(
        //           text,
        //           style: const TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontFamily: 'DancingScript',
        //             fontSize: 28,
        //           ),
        //         ),
        //       )
        //
        //     :
        // ignore: deprecated_member_use
        FlatButton(
      textColor: Theme.of(context).primaryColor,
      onPressed: handler,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'DancingScript',
          fontSize: 28,
        ),
      ),
    );
  }
}
