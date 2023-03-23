import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomeSCreen extends StatefulWidget {
  const HomeSCreen({Key? key}) : super(key: key);

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

TextEditingController txtsearch = TextEditingController();

class _HomeSCreenState extends State<HomeSCreen> {
  Webprovider? webproviderTrue;
  Webprovider? webproviderFalse;
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () {
        webproviderTrue!.inAppWebViewController?.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    webproviderTrue = Provider.of(context, listen: true);
    webproviderFalse = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white38,
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ]),
              child: TextField(
                controller: txtsearch,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        var newLink = txtsearch.text;
                        webproviderTrue!.inAppWebViewController!.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse(
                                "https://www.google.com/search?q=$newLink"),
                          ),
                        );
                      },
                      icon: Icon(Icons.search, color: Colors.white),
                    ),
                    border: InputBorder.none),
              ),
            ),
            LinearProgressIndicator(
              value:
                  Provider.of<Webprovider>(context, listen: true).progressweb,
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse("https://www.google.com/")),
                pullToRefreshController: pullToRefreshController!,
                onWebViewCreated: (controller) {
                  webproviderTrue!.inAppWebViewController = controller;
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController!.endRefreshing();
                  webproviderTrue!.inAppWebViewController = controller;
                },
                onLoadStart: (controller, url) {
                  webproviderTrue!.inAppWebViewController = controller;
                },
                onLoadStop: (controller, url) {
                  pullToRefreshController!.endRefreshing();

                  webproviderTrue!.inAppWebViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  pullToRefreshController!.endRefreshing();

                  webproviderTrue!.ChengeProgress(progress / 100);
                },
              ),
            ),
            Container(
              color: Colors.black38,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      webproviderFalse!.inAppWebViewController!.goBack();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  IconButton(
                    onPressed: () {
                      webproviderFalse!.inAppWebViewController!.reload();
                    },
                    icon: Icon(Icons.refresh),
                  ),
                  IconButton(
                    onPressed: () {
                      webproviderFalse!.inAppWebViewController!.goForward();
                    },
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
