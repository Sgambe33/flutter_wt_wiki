import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalHostIntegration extends StatefulWidget {
  const LocalHostIntegration({super.key});

  @override
  _LocalHostIntegrationState createState() => _LocalHostIntegrationState();
}

class _LocalHostIntegrationState extends State<LocalHostIntegration> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('http://192.168.1.61:8111'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localhost Integration'),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
