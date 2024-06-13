import 'package:wood_vip/model/subtitlemodel.dart';

class Constant {
  static const String baseurl =
      'https://phplaravel-1281383-4639657.cloudwaysapps.com/api/';

  static String? appName = "Wood VIP";
  static String? appPackageName = "com.woodx.vip";
  static String? appleAppId = "6449380090";
  static String? appVersion = "1";
  static String? appBuildNumber = "1.0";

  /* OneSignal App ID */
  static const String oneSignalAppId = "";

  /* Constant for TV check */
  static bool isTV = false;

  static String? userID;
  static String currencySymbol = "₹";
  static String currency = "INR";

  static String androidAppShareUrlDesc =
      "Let me recommend you this application\n\n$androidAppUrl";
  static String iosAppShareUrlDesc =
      "Let me recommend you this application\n\n$iosAppUrl";

  static String androidAppUrl =
      "https://play.google.com/store/apps/details?id=${Constant.appPackageName}";
  static String iosAppUrl =
      "https://apps.apple.com/us/app/id${Constant.appleAppId}";

  static Map<String, String> resolutionsUrls = <String, String>{};
  static List<SubTitleModel> subtitleUrls = [];

  /* Download config */
  static String videoDownloadPort = 'video_downloader_send_port';
  static String showDownloadPort = 'show_downloader_send_port';
  static String hawkVIDEOList = "myVideoList_";
  static String hawkKIDSVIDEOList = "myKidsVideoList_";
  static String hawkSHOWList = "myShowList_";
  static String hawkSEASONList = "mySeasonList_";
  static String hawkEPISODEList = "myEpisodeList_";

  /* Download config */

  static int fixFourDigit = 1317;
  static int fixSixDigit = 161613;

  static int bannerDuration = 10000; // in milliseconds
  static int animationDuration = 800; // in milliseconds

  static String InkaDashContents =
      "https://contents.pallycon.com/DEMO/app/big_buck_bunny/dash/stream.mpd";
  static String tokenEncodedHlsUrl =
      "https://amssamples.streaming.mediaservices.windows.net/830584f8-f0c8-4e41-968b-6538b9380aa5/TearsOfSteelTeaser.ism/manifest(format=m3u8-aapl)";
  static String tokenEncodedHlsToken =
      "Bearer=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1cm46bWljcm9zb2Z0OmF6dXJlOm1lZGlhc2VydmljZXM6Y29udGVudGtleWlkZW50aWZpZXIiOiI5ZGRhMGJjYy01NmZiLTQxNDMtOWQzMi0zYWI5Y2M2ZWE4MGIiLCJpc3MiOiJodHRwOi8vdGVzdGFjcy5jb20vIiwiYXVkIjoidXJuOnRlc3QiLCJleHAiOjE3MTA4MDczODl9.lJXm5hmkp5ArRIAHqVJGefW2bcTzd91iZphoKDwa6w8";
  static String InkaLicenseUrl =
      "https://license-global.pallycon.com/ri/licenseManager.do";

  static String InkaDashCustomData =
      "eyJkcm1fdHlwZSI6IldpZGV2aW5lIiwic2l0ZV9pZCI6IkRFTU8iLCJ1c2VyX2lkIjoidGVzdFVzZXIiLCJjaWQiOiJkZW1vLWJiYi1zaW1wbGUiLCJwb2xpY3kiOiI5V3FJV2tkaHB4VkdLOFBTSVljbkp1dUNXTmlOK240S1ZqaTNpcEhIcDlFcTdITk9uYlh6QS9pdTdSa0Vwbk85c0YrSjR6R000ZkdCMzVnTGVORGNHYWdPY1Q4Ykh5c3k0ZHhSY2hYV2tUcDVLdXFlT0ljVFFzM2E3VXBnVVdTUCIsInJlc3BvbnNlX2Zvcm1hdCI6Im9yaWdpbmFsIiwia2V5X3JvdGF0aW9uIjpmYWxzZSwidGltZXN0YW1wIjoiMjAyMi0wNi0xOVQyMzo0NjoyOFoiLCJoYXNoIjoid3dWSFVhNnRNT1BUUmZmNkRWZUVua0Z0cWMvMkJPRkpGUzU1aE5iNkp2ND0ifQ==";
  static String InkaHlsCustomData =
      "eyJrZXlfcm90YXRpb24iOmZhbHNlLCJyZXNwb25zZV9mb3JtYXQiOiJvcmlnaW5hbCIsInVzZXJfaWQiOiJ1dGVzdCIsImRybV90eXBlIjoiZmFpcnBsYXkiLCJzaXRlX2lkIjoiREVNTyIsImhhc2giOiJHOXRub25WaU0zUHZEeUpVaVMycmxJUWhqN3VcL2xGc3dQNThhejB0c3AyTT0iLCJjaWQiOiJUZXN0UnVubmVyIiwicG9saWN5IjoiOVdxSVdrZGhweFZHSzhQU0lZY25Kc2N2dUE5c3hndWJMc2QrYWp1XC9ib21RWlBicUkreGFlWWZRb2Nja3Z1RWZ4RGNjbTdjV2RWWHFyZE1nQVFqbXFmVVhja1doNEgwNGFMODlUa0hKOXUxWjJTUUlhSWFUXC9rd09JUFQyaWZMN2NkK0pBK2l0clpzaHNqbXpxR0R6NWVzOVhtbk0rWktUNnF4WUtOM2o0ekV3WURvTHlBeUhTZzVvN3BVQjVZa1YiLCJ0aW1lc3RhbXAiOiIyMDIxLTA3LTE0VDA5OjM3OjI5WiJ9";
  static String InkaSiteId = "DEMO";
  static String InkaHlsContents =
      "https://contents.pallycon.com/TEST/PACKAGED_CONTENT/TEST_SIMPLE/hls/master.m3u8";
  static String InkaCertUrl =
      "https://license.pallycon.com/ri/fpsKeyManager.do";
}
