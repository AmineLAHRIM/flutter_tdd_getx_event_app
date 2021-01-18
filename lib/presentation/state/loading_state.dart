import 'package:equatable/equatable.dart';
import 'package:event_app/core/error/errors.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_state.freezed.dart';

@freezed
abstract class LoadingState<Widget> with _$LoadingState<Widget>   {
  const factory LoadingState(Widget value) = Data<Widget>;

  const factory LoadingState.loading() = _Loading<Widget>;

  const factory LoadingState.empty() = _Empty<Widget>;

  const factory LoadingState.error({String message, MessageType type}) = _Error<Widget>;

  const factory LoadingState.loaded({@required Object value}) = _Loaded<Widget>;
}

/*class Loaded {
  final Object value;

  Loaded({@required this.value});

  @override
  List<Object> get props => [value];
}

class Error {
  String message;
  MessageType type;

  Error({this.message, this.type});
}*/
