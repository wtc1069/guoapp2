import 'package:duanju_app/app_build.dart';
import 'package:duanju_app/local_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<LocalStore> create([Map<String, Object> initial = const {}]) async {
    SharedPreferences.setMockInitialValues(Map.of(initial));
    final store = testStore(await SharedPreferences.getInstance());
    addTearDown(store.dispose);
    return store;
  }

  test('compiled sources are visible without a password', () async {
    final store = await create();
    expect(store.sources.length, allSourcesEnabled ? 11 : 1);
    expect(store.allowsSource('huangdou'), allSourcesEnabled);
    expect(store.allowsSource('hongguo'), isTrue);
  });

  test('legacy saved gate settings no longer hide compiled sources', () async {
    final store = await create(await gatePreferences());
    expect(store.sources.length, allSourcesEnabled ? 11 : 1);
    expect(store.allowsSource('huangdou'), allSourcesEnabled);
  });
}
