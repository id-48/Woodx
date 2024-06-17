import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wood_vip/pages/bottombar.dart';

import '../../provider/subscriptionprovider.dart';

class MyWebViewWidget extends StatefulWidget {
  const MyWebViewWidget({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<MyWebViewWidget> createState() => _MyWebViewWidgetState();
}

class _MyWebViewWidgetState extends State<MyWebViewWidget> {
  late SubscriptionProvider subscriptionProvider;

  @override
  void initState() {
    subscriptionProvider = Provider.of<SubscriptionProvider>(context, listen: false);
    url = widget.url;
    super.initState();
  }

  String url = '';
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  bool isKycPending = false;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    return Stack(
      children: [
        isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          initialOptions: options,
          onLoadStart: (controller, url) {
            /* if(url.toString()=='${UrlContainer.domainUrl}/user/deposit/history'){
              Get.offAndToNamed(RouteHelper.addMoneyHistoryScreen);
              CustomSnackBar.success(successList: [MyStrings.requestSuccess.tr]);
            } else if(url.toString()=='${UrlContainer.baseUrl}user/deposit'){
              Get.back();
              CustomSnackBar.error(errorList: [MyStrings.requestFail.tr]);
            }*/
            print('ON LOAD START URL ::: ${url.toString()} ');

            setState(() {
              this.url = url.toString();
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(
                  Uri.parse(url),
                );
                return NavigationActionPolicy.CANCEL;
              }
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            // error https://phplaravel-1264843-4556769.cloudwaysapps.com/payment/complete?code=PAYMENT_ERROR&merchantId=M1ULAZVIGRPU&transactionId=txnid908793&amount=100&providerReferenceId=T2405311423149190543590&merchantOrderId=txnid908793&param1=na&param2=na&param3=na&param4=na&param5=na&param6=na&param7=na&param8=na&param9=na&param10=na&param11=na&param12=na&param13=na&param14=na&param15=na&param16=na&param17=na&param18=na&param19=na&param20=na&checksum=5f9363e26a64cb91533dfce7e5c927ed3f8f207f5662062ef22266fe58826d99%23%23%231&user_id=16&plan_id=8&phone_no=9999999999}
            //success https: //phplaravel-1264843-4556769.cloudwaysapps.com/payment/complete?code=PAYMENT_SUCCESS&merchantId=M1ULAZVIGRPU&transactionId=txnid728264&amount=100&providerReferenceId=T2405311420415792209335&merchantOrderId=txnid728264&param1=na&param2=na&param3=na&param4=na&param5=na&param6=na&param7=na&param8=na&param9=na&param10=na&param11=na&param12=na&param13=na&param14=na&param15=na&param16=na&param17=na&param18=na&param19=na&param20=na&checksum=b667a1fc9ff82d365b2cd621ce8dfd51f56c960a9a6a02a02a5a2517c6b4e929%23%23%231&user_id=16&plan_id=8&phone_no=9999999999
            setState(() {
              print('ON LOAD STOP URL ::: ${url.toString()} ');
              if (url.toString().contains("code=PAYMENT_SUCCESS")) {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => Bottombar()), (route) => false);
                subscriptionProvider.onCheckPhonePayStatus();
              }
              if (url.toString().contains("code=PAYMENT_ERROR")) {
                Navigator.of(context).pop();
              }
              isLoading = false;
              this.url = url.toString();
            });
          },
          onLoadError: (controller, url, code, message) {},
          onProgressChanged: (controller, progress) {},
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            print('ON Update visited URL ::: ${url.toString()} ');

            setState(() {
              this.url = url.toString();
            });
          },
          onConsoleMessage: (controller, consoleMessage) {},
        )
      ],
    );
  }
}
