import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'local_account_manager_platform_interface.dart';

/// An implementation of [LocalAccountManagerPlatform] that uses method channels.
class MethodChannelLocalAccountManager extends LocalAccountManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('local_account_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
