import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

extension NavigateAndTheme on BuildContext {
  //push
  push({Widget? screen}) {
    return Navigator.of(this)
        .push(MaterialPageRoute(builder: (BuildContext context) => screen!));
  }

  pushRoot({Widget? screen}) {
    return Navigator.of(this,)
        .push(MaterialPageRoute(builder: (BuildContext context) => screen!));
  }
  pop() {
    return Navigator.of(this,)
        .pop();
  }
  pushReplacement({Widget? screen}) {
    return Navigator.of(this,)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => screen!));
  }
}


Logger logger = Logger(
  printer: PrettyPrinter(),
);