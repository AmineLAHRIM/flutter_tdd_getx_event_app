import 'package:equatable/equatable.dart';
import 'package:event_app/core/error/errors.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_state.freezed.dart';

@freezed
abstract class LoadingState with _$LoadingState {

  const factory LoadingState.loading() = _Loading;

  const factory LoadingState.empty() = _Empty;

  const factory LoadingState.error({String message, MessageType type}) = _Error;

  const factory LoadingState.loaded() = _Loaded;
}