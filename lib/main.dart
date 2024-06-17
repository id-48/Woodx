import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:wood_vip/pages/splash.dart';
import 'package:wood_vip/provider/avatarprovider.dart';
import 'package:wood_vip/provider/castdetailsprovider.dart';
import 'package:wood_vip/provider/channelsectionprovider.dart';
import 'package:wood_vip/provider/episodeprovider.dart';
import 'package:wood_vip/provider/findprovider.dart';
import 'package:wood_vip/provider/generalprovider.dart';
import 'package:wood_vip/provider/homeprovider.dart';
import 'package:wood_vip/provider/paymentprovider.dart';
import 'package:wood_vip/provider/playerprovider.dart';
import 'package:wood_vip/provider/profileprovider.dart';
import 'package:wood_vip/provider/purchaselistprovider.dart';
import 'package:wood_vip/provider/rentstoreprovider.dart';
import 'package:wood_vip/provider/searchprovider.dart';
import 'package:wood_vip/provider/sectionbytypeprovider.dart';
import 'package:wood_vip/provider/sectiondataprovider.dart';
import 'package:wood_vip/provider/showdetailsprovider.dart';
import 'package:wood_vip/provider/showdownloadprovider.dart';
import 'package:wood_vip/provider/signup_provider.dart';
import 'package:wood_vip/provider/subhistoryprovider.dart';
import 'package:wood_vip/provider/subscriptionprovider.dart';
import 'package:wood_vip/provider/videobyidprovider.dart';
import 'package:wood_vip/provider/videodetailsprovider.dart';
import 'package:wood_vip/provider/videodownloadprovider.dart';
import 'package:wood_vip/provider/watchlistprovider.dart';
import 'package:wood_vip/tvpages/tvhome.dart';
import 'package:wood_vip/utils/color.dart';
import 'package:wood_vip/utils/constant.dart';
import 'package:wood_vip/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await FlutterDownloader.initialize();
  }
  await Firebase.initializeApp();
  await Locales.init(['en', 'ar', 'hi', 'pt']);
  if (!kIsWeb) {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(Constant.oneSignalAppId);
    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt.
    // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      log("Accepted permission: ===> $accepted");
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      final notification = event.notification;
      event.complete(notification);
      debugPrint("this is notification title: ${notification.title}");
      debugPrint("this is notification body:  ${notification.body}");
      debugPrint(
          "this is notification additional data: ${notification.additionalData}");
    });
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AvatarProvider()),
        ChangeNotifierProvider(create: (_) => CastDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ChannelSectionProvider()),
        ChangeNotifierProvider(create: (_) => EpisodeProvider()),
        ChangeNotifierProvider(create: (_) => FindProvider()),
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PurchaselistProvider()),
        ChangeNotifierProvider(create: (_) => RentStoreProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => SectionByTypeProvider()),
        ChangeNotifierProvider(create: (_) => SectionDataProvider()),
        ChangeNotifierProvider(create: (_) => ShowDownloadProvider()),
        ChangeNotifierProvider(create: (_) => ShowDetailsProvider()),
        ChangeNotifierProvider(create: (_) => SubHistoryProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => VideoByIDProvider()),
        ChangeNotifierProvider(create: (_) => VideoDetailsProvider()),
        ChangeNotifierProvider(create: (_) => VideoDownloadProvider()),
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    if (!kIsWeb) Utils.enableScreenCapture();
    if (!kIsWeb) _getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
      },
      child: LocaleBuilder(
        builder: (locale) => MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [routeObserver],
          //HERE
          theme: ThemeData(
            primaryColor: primaryColor,
            primaryColorDark: primaryDarkColor,
            primaryColorLight: primaryLight,
            scaffoldBackgroundColor: appBgColor,
          ).copyWith(
            scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all(white),
              trackVisibility: MaterialStateProperty.all(true),
              trackColor: MaterialStateProperty.all(whiteTransparent),
            ),
          ),
          title: Constant.appName ?? "",
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            return locale;
          },
          builder: (context, child) {
            return ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 360, name: MOBILE),
                const Breakpoint(start: 361, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1000, name: DESKTOP),
                const Breakpoint(start: 1001, end: double.infinity, name: '4K'),
              ],
            );
          },
          home: (kIsWeb) ? const TVHome(pageName: "") : const Splash(),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
              PointerDeviceKind.trackpad
            },
          ),
        ),
      ),
    );
  }

  _getDeviceInfo() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Constant.isTV =
          androidInfo.systemFeatures.contains('android.software.leanback');
      log("isTV =======================> ${Constant.isTV}");
    }
  }
}
