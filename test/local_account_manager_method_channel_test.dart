import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_account_manager/local_account_manager_method_channel.dart';

void main() {
  MethodChannelLocalAccountManager platform = MethodChannelLocalAccountManager();
  const MethodChannel channel = MethodChannel('local_account_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
