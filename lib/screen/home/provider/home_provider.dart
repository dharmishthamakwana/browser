import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Webprovider extends ChangeNotifier{
  double progressweb=0;
  InAppWebViewController? inAppWebViewController;

  void ChengeProgress(double ps)
  {
    progressweb=ps;
    notifyListeners();
  }
}