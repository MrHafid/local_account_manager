import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'local_account_manager_method_channel.dart';

abstract class LocalAccountManagerPlatform extends PlatformInterface {
  /// Constructs a LocalAccountManagerPlatform.
  LocalAccountManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static LocalAccountManagerPlatform _instance = MethodChannelLocalAccountManager();

  /// The default instance of [LocalAccountManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelLocalAccountManager].
  static LocalAccountManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LocalAccountManagerPlatform] when
  /// they register themselves.
  static set instance(LocalAccountManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
