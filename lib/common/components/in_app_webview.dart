import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app_bar.dart';

class InAppWebViewArguments {
  final String? title;
  final String url;

  InAppWebViewArguments({this.title, required this.url});
}

class _InAppWebViewState extends State<InAppWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(hasBackButton: true),
        body: Stack(
          children: [
            /*WebViewWidget(
              initialUrl: widget.url,
              navigationDelegate: (action) {
                if (action.url == widget.url) {
                  return NavigationDecision.navigate;
                }
                return NavigationDecision.prevent;
              },
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) =>
                  {_controller.complete(controller)},
            ),*/
          ],
        ));
  }
}

class InAppWebView extends StatefulWidget {
  final String url;
  final String? title;

  const InAppWebView({super.key, this.title, required this.url});

  @override
  _InAppWebViewState createState() => _InAppWebViewState();
}
