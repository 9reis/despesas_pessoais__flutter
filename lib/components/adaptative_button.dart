import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton(
      {Key? key, required this.label, required this.onPressed})
      : super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Theme.of(context).colorScheme.primary,
            onPressed: onPressed,
          )
        : ElevatedButton(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary),
            onPressed: onPressed,
          );
  }
}
