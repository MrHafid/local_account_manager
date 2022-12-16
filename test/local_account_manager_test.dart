import 'package:flutter_test/flutter_test.dart';
import 'package:local_account_manager/local_account_manager.dart';
import 'package:local_account_manager/local_account_manager_platform_interface.dart';
import 'package:local_account_manager/local_account_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLocalAccountManagerPlatform
    with MockPlatformInterfaceMixin
    implements LocalAccountManagerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LocalAccountManagerPlatform initialPlatform =
      LocalAccountManagerPlatform.instance;

  test('$MethodChannelLocalAccountManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLocalAccountManager>());
  });

  test('getPlatformVersion', () async {
    LocalAccountManager localAccountManagerPlugin = LocalAccountManager();
    MockLocalAccountManagerPlatform fakePlatform =
        MockLocalAccountManagerPlatform();
    LocalAccountManagerPlatform.instance = fakePlatform;

    // expect(await localAccountManagerPlugin.getPlatformVersion(), '42');
  });
}
