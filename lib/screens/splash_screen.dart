import 'dart:async';
import 'package:flutter/material.dart';
import 'webview_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
    // 네이티브 스플래시가 표시된 후 WebView 페이지로 이동
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        FlutterNativeSplash.remove();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WebViewPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
