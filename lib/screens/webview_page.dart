import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? webViewController;
  String url = "https://english-study-app-889563220811.asia-northeast3.run.app";
  // 테스트용 스크롤 가능한 페이지
  // String url = "https://flutter.dev";
  double progress = 0;
  bool isLoading = true;
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.deepPurple,
              backgroundColor: Colors.white,
            ),
            onRefresh: () async {
              log('Pull to refresh triggered!');
              if (defaultTargetPlatform == TargetPlatform.android) {
                log('Android reload');
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                log('iOS reload');
                webViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: await webViewController?.getUrl(),
                  ),
                );
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(url)),
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                  log(
                    'WebView created, pullToRefreshController: ${pullToRefreshController != null}',
                  );
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    isLoading = true;
                  });
                },
                onLoadStop: (controller, url) {
                  setState(() {
                    isLoading = false;
                  });
                  log('Page loaded: $url');
                  pullToRefreshController?.endRefreshing();
                },
                onReceivedError: (controller, request, error) {
                  log('Error loading page: ${error.description}');
                  pullToRefreshController?.endRefreshing();
                },
                onReceivedHttpError: (controller, request, errorResponse) {
                  log('HTTP Error: ${errorResponse.statusCode}');
                  pullToRefreshController?.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                  if (progress == 100) {
                    pullToRefreshController?.endRefreshing();
                  }
                },
                initialSettings: InAppWebViewSettings(
                  isInspectable: kDebugMode,
                  javaScriptEnabled: true,
                  domStorageEnabled: true,
                  mediaPlaybackRequiresUserGesture: false,
                  allowsInlineMediaPlayback: true,
                  iframeAllow: "camera; microphone",
                  iframeAllowFullscreen: true,
                  // Pull to refresh를 위한 설정
                  disableVerticalScroll: false,
                  disableHorizontalScroll: false,
                  // iOS에서 pull to refresh 활성화
                  allowsBackForwardNavigationGestures: true,
                  // Android에서 pull to refresh 활성화
                  supportZoom: true,
                  // 웹페이지 로딩 개선
                  cacheEnabled: true,
                  clearCache: false,
                  // 네트워크 타임아웃 설정
                  networkAvailable: true,
                  // 사용자 에이전트 설정
                  userAgent:
                      "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
