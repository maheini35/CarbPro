import 'package:bloc_test/bloc_test.dart';
import 'package:carbpro/datamodels/item.dart';
import 'package:carbpro/generated/l10n.dart';
import 'package:carbpro/ui/widgets/itemlist.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:carbpro/ui/homescreen.dart';
import 'package:carbpro/handler/databasehandler.dart';
import 'package:carbpro/bloc/list_cubit/list_cubit.dart';

class MockDatabaseHandler extends Mock implements DatabaseHandler {}

class MockListCubit extends MockCubit<ListState> implements ListCubit {}

void main() {
  group('General UI layout & startup', () {
    late ListCubit listCubit;

    setUp(() {
      listCubit = MockListCubit();
      when(() => listCubit.state).thenReturn(ListLoading());
      when(() => listCubit.loadItems()).thenAnswer((_) async => true);
    });

    testWidgets('After App startup, ListCubit.loadItems should be called',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(
          listCubit: listCubit,
        ),
      ));
      verify(() => listCubit.loadItems()).called(1);
    });
