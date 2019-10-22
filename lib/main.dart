import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:yeah_nah/error.dart';

import 'package:yeah_nah/sucess.dart';

void main() async {
  bool result = await DataConnectionChecker().hasConnection;
  if (result == true) {
    runApp(Main());
  } else {
    runApp(Error());
  }
}
