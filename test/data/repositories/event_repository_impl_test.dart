import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/exceptions.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/core/network/network_info.dart';
import 'package:event_app/data/datasources/local/repositories/local_event_repository.dart';
import 'package:event_app/data/datasources/local/shared_prefs_constant.dart';
import 'package:event_app/data/datasources/remote/repositories/remote_event_repository.dart';
import 'package:event_app/data/datasources/remote/rest_api.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/repositories/event_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';

class MockRemoteEventRepository extends Mock implements RemoteEventRepository {}

class MockLocalEventRepository extends Mock implements LocalEventRepository {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

main() {
  MockRemoteEventRepository mockRemoteEventRepository;
  MockLocalEventRepository mockLocalEventRepository;
  MockNetworkInfo mockNetworkInfo;
  EventRepositoryImpl eventRepositoryImpl;

  setUp(() {
    mockRemoteEventRepository = MockRemoteEventRepository();
    mockLocalEventRepository = MockLocalEventRepository();
    mockNetworkInfo = MockNetworkInfo();

    eventRepositoryImpl = EventRepositoryImpl(
      remoteEventRepository: mockRemoteEventRepository,
      localEventRepository: mockLocalEventRepository,
      networkInfo: mockNetworkInfo,
    );
  });

  group('event_repository', () {
    final tEvent = Event.fromJson(json.decode(fixture('event.json')));
    final tEvents = (json.decode(fixture('events.json')) as List<dynamic>).map((e) => Event.fromJson(e)).toList();

    group('[findAll] function', () {
      test('should return [a list events] on [findAll] when [device is online && remote repo return a list events]', () async {
        // ARRANGE
        final isConnected = Future.value(true);
        when(mockNetworkInfo.isConnected).thenAnswer((_) => isConnected);
        when(mockRemoteEventRepository.findAll()).thenAnswer((_) async => tEvents);
        // ACT
        final result = await eventRepositoryImpl.findAll();

        // ASSERT
        verify(mockRemoteEventRepository.findAll());
        expect(result, Right(tEvents));
      });

      test('should cache [a list events] on [findAll] when [device is online && remote repo return a list events]', () async {
        // ARRANGE
        final isConnected = Future.value(true);
        when(mockNetworkInfo.isConnected).thenAnswer((_) => isConnected);
        when(mockRemoteEventRepository.findAll()).thenAnswer((_) async => tEvents);
        // ACT
        await eventRepositoryImpl.findAll();

        // ASSERT
        verify(mockRemoteEventRepository.findAll());
        verify(mockLocalEventRepository.cacheAll(tEvents));
      });

      test('should throw a [ServerFailure] on [findAll] when [device is online && remote repo return throw a ServerException]', () async {
        // ARRANGE
        final isConnected = Future.value(true);
        when(mockNetworkInfo.isConnected).thenAnswer((_) => isConnected);
        when(mockRemoteEventRepository.findAll()).thenThrow(ServerException());
        // ACT
        final result = await eventRepositoryImpl.findAll();

        // ASSERT
        //verify(mockRemoteEventRepository.findAll());
        expect(result, Left(ServerFailure()));
      });

      test('should return [a list events]  on [findAll] when [device is offline]', () async {
        // ARRANGE
        final isConnected = Future.value(false);
        when(mockNetworkInfo.isConnected).thenAnswer((_) => isConnected);
        when(mockLocalEventRepository.findAll()).thenAnswer((_) async => tEvents);
        // ACT
        final result = await eventRepositoryImpl.findAll();

        // ASSERT
        verify(mockLocalEventRepository.findAll());
        verifyZeroInteractions(mockRemoteEventRepository);
        expect(result, Right(tEvents));
      });
    });

    group('[findById] function', () {
      test('should return [event] on [findById] when [device is online && remote repo return an event]', () async {
        // ARRANGE
        final isConnected = Future.value(true);
        when(mockNetworkInfo.isConnected).thenAnswer((_) => isConnected);
        when(mockRemoteEventRepository.findById(any)).thenAnswer((_) async => tEvent);
        // ACT
        final result = await eventRepositoryImpl.findById(tEvent.id);

        // ASSERT
        verify(mockRemoteEventRepository.findById(tEvent.id));
        expect(result, Right(tEvent));
      });

      test('should cache [event] on [findById] when [device is online && remote repo return an event]', () async {
        // ARRANGE
        final isConnected = Future.value(true);
        when(mockNetworkInfo.isConnected).thenAnswer((_) => isConnected);
        when(mockRemoteEventRepository.findById(any)).thenAnswer((_) async => tEvent);
        // ACT
        await eventRepositoryImpl.findById(tEvent.id);

        // ASSERT
        verify(mockRemoteEventRepository.findById(tEvent.id));
        verify(mockLocalEventRepository.cache(tEvent));
      });

      test('should throw a [ServerFailure] on [findById] when [device is online && remote repo return throw a ServerException]', () async {
        // ARRANGE
        final isConnected = Future.value(true);
        when(mockNetworkInfo.isConnected).thenAnswer((_) => isConnected);
        when(mockRemoteEventRepository.findById(any)).thenThrow(ServerException());
        // ACT
        final result = await eventRepositoryImpl.findById(tEvent.id);

        // ASSERT
        expect(result, Left(ServerFailure()));
      });

      test('should return [event]  on [findById] when [device is offline]', () async {
        // ARRANGE
        final isConnected = Future.value(false);
        when(mockNetworkInfo.isConnected).thenAnswer((_) => isConnected);
        when(mockLocalEventRepository.findById(any)).thenAnswer((_) async => tEvent);
        // ACT
        final result = await eventRepositoryImpl.findById(tEvent.id);

        // ASSERT
        verify(mockLocalEventRepository.findById(tEvent.id));
        verifyZeroInteractions(mockRemoteEventRepository);
        expect(result, Right(tEvent));
      });
    });
  });
}
