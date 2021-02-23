import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mylist_flutter/simple_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}