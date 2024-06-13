import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class DrmPage extends StatefulWidget {
  @override
  _DrmPageState createState() => _DrmPageState();
}

class _DrmPageState extends State<DrmPage> {
  late BetterPlayerController _tokenController;
  late BetterPlayerController _widevineController;
  late BetterPlayerController _fairplayController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource _tokenDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constant.tokenEncodedHlsUrl,
      videoFormat: BetterPlayerVideoFormat.hls,
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.token,
          token: Constant.tokenEncodedHlsToken),
    );
    _tokenController = BetterPlayerController(betterPlayerConfiguration);
    _tokenController.setupDataSource(_tokenDataSource);

    _widevineController = BetterPlayerController(betterPlayerConfiguration);
    BetterPlayerDataSource _widevineDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constant.InkaDashContents,
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.widevine,
          licenseUrl: Constant.InkaLicenseUrl,
          headers: {"pallycon-customdata-v2": Constant.InkaDashCustomData}),
    );
    _widevineController.setupDataSource(_widevineDataSource);

    _fairplayController = BetterPlayerController(betterPlayerConfiguration);
    BetterPlayerDataSource _fairplayDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constant.InkaHlsContents,
      drmConfiguration: BetterPlayerDrmConfiguration(
        drmType: BetterPlayerDrmType.fairplay,
        certificateUrl: Constant.InkaCertUrl,
        licenseUrl: Constant.InkaLicenseUrl,
        headers: {
          "pallycon-customdata-v2": Constant.InkaHlsCustomData,
          "siteId": Constant.InkaSiteId
        },
      ),
    );
    _fairplayController.setupDataSource(_fairplayDataSource);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DRM player"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _widevineController),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "INKA Fair Play",
                style: TextStyle(fontSize: 16),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _fairplayController),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
