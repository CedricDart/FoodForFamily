import 'package:flutter/material.dart';
import 'package:system_settings/system_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              ElevatedButton(
                child: const Text('App info'),
                onPressed: () => SystemSettings.app(),
              ),
              ElevatedButton(
                child: const Text('Settings'),
                onPressed: () => SystemSettings.system(),
              ),
              ElevatedButton(
                child: const Text('Security'),
                onPressed: () => SystemSettings.security(),
              ),
              ElevatedButton(
                child: const Text('Device info'),
                onPressed: () => SystemSettings.deviceInfo(),
              ),
              ElevatedButton(
                child: const Text('Data usage'),
                onPressed: () => SystemSettings.dataUsage(),
              ),
              ElevatedButton(
                child: const Text('Privacy'),
                onPressed: () => SystemSettings.privacy(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
