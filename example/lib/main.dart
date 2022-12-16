import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:local_account_manager/local_account_manager.dart';

class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _LocalAccountManagerPlugin = LocalAccountManager();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // platformVersion =
      //     await _LocalAccountManagerPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: GlobalVariable.navState, home: ExamplePage());
  }
}

class ExamplePage extends StatelessWidget {
  static const kAccountType = 'com.google';
  List<Account> accountsData = [];

  ExamplePage({Key? key});

  Future getAccountGoogle() async {
    try {
      List<Account> accounts = await LocalAccountManager.getAccounts();
      accountsData = accounts;
      for (Account account in accounts) {
        print(account.name);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> fetchName() async {
    String name = '';
    try {
      var accounts = await LocalAccountManager.getAccounts();
      for (Account account in accounts) {
        if (account.accountType == kAccountType) {
          await LocalAccountManager.removeAccount(account);
        }
      }
      var account = Account(name: 'User Email', accountType: kAccountType);
      if (await LocalAccountManager.addAccount(account)) {
        AccessToken? token = AccessToken(tokenType: 'Bearer', token: 'token');
        await LocalAccountManager.setAccessToken(account, token);
        accounts = await LocalAccountManager.getAccounts();
        for (Account account in accounts) {
          if (account.accountType == kAccountType) {
            token = await LocalAccountManager.getAccessToken(
                account, token!.tokenType);
            if (token != null) {
              name = '${account.name} - ${token.token}';
            }
            break;
          }
        }
      }
    } catch (e, s) {
      print(e);
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account Example'),
        ),
        body: Center(
          // child: FutureBuilder<String>(
          //   future: fetchName(),
          //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          //     String text = 'Loading...';
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       if (snapshot.hasData && snapshot.data != null) {
          //         text = snapshot.data!;
          //       } else {
          //         text = 'Failed';
          //       }
          //     }
          //     return Text(text);
          //   },
          // ),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(''),
              TextButton(
                  onPressed: () async {
                    print('run');
                    List<Account> accounts =
                        await LocalAccountManager.getAccounts();
                    print(accounts);
                    // accountsData = accounts;
                    for (Account account in accounts) {
                      // ignore: avoid_print
                      print(account.name);
                    }
                  },
                  child: const Text('Get'))
            ],
          ),
        ));
  }
}
