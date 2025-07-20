import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();
  @override
  List<Object?> get props => [];
}

abstract class BaseState extends Equatable {
  const BaseState();
  @override
  List<Object?> get props => [];
}

abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBloc(S initialState) : super(initialState);
}
