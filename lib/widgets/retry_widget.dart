// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RetryWidget extends HookWidget {
  Function onRetry;

  // ignore: use_key_in_widget_constructors
  RetryWidget(this.onRetry);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Failed to load items.',
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            child: const Text('Tap to retry'),
            onPressed: () => onRetry(),
          )
        ],
      ),
    );
  }
}
