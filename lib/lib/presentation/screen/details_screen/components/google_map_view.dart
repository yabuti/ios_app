import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleMapView extends StatefulWidget {
  final String googleMapHtml;

  const GoogleMapView({super.key, required this.googleMapHtml});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final String mapUrl = widget.googleMapHtml;

    // Embed the URL in an iframe
    final String processedHtml = '''
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
          }
          iframe {
            border: 0;
            width: 100%;
            height: 100%;
          }
        </style>
      </head>
      <body>
        <iframe src="$mapUrl" allowfullscreen></iframe>
      </body>
      </html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setBackgroundColor(Colors.transparent)
      ..loadHtmlString(processedHtml);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}