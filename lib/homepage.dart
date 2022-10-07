import 'dart:io';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

double skalaFont(double lebar) {
  if (lebar < 350) {
    return 0.7;
  } else if (lebar < 450) {
    return 0.9;
  }
  return 1.0;
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'FontPoppins',
      ),
      home: const SafeArea(child: SliderWidget()),
    );
  }
}

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/img/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Peruntukan Ruang",
          body:
              "Pencarian Informasi Lokasi Peruntukan Ruang Sesuai dengan Keadaan Lapangan.",
          image: _buildImage('1.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Identifikasi Lokasi",
          body:
              "Memberikan Informasi Tambahan Titik Lokasi Apabila Terdapat Ketidaksesuaian Penataan Ruang.",
          image: _buildImage('2.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Rekomendasi Ruang",
          body:
              "Memberikan Rekomendasi Lokasi Penataan Ruang Guna Perencanaan Kedepan.",
          image: _buildImage('3.gif'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: const Color(0xff55b17f),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.arrow_back_ios_sharp,
              color: Color(0xffffffff),
              size: 16,
            ),
          ],
        ),
      ),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: const Color(0xff55b17f),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Color(0xffffffff),
              size: 16,
            ),
          ],
        ),
      ),
      done: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: const Color(0xff55b17f),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: <Widget>[
            const Text(
              'Start',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xffffffff),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Color(0xffffffff),
              size: 16,
            ),
          ],
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.all(12.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xff55b17f),
        activeColor: Color(0xff55b17f),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => WebViewState();
}

class WebViewState extends State<HomePage> {
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      javaScriptEnabled: true,
      javaScriptCanOpenWindowsAutomatically: true,
      allowFileAccessFromFileURLs: true,
      allowUniversalAccessFromFileURLs: true,
      cacheEnabled: true,
      useOnDownloadStart: true,
      useOnLoadResource: true,
      useShouldInterceptAjaxRequest: true,
      useShouldInterceptFetchRequest: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
      mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
      geolocationEnabled: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  double progress = 0;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          // webViewController?.reload();
        } else if (Platform.isIOS) {
          // webViewController?.loadUrl(
          //     urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "https://taggingtaru.kaltimprov.go.id/webgis#7/0.137/117.438")),
              initialOptions: options,
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                return NavigationActionPolicy.ALLOW;
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
              androidOnGeolocationPermissionsShowPrompt:
                  (InAppWebViewController controller, String origin) async {
                return GeolocationPermissionShowPromptResponse(
                  origin: origin,
                  allow: true,
                  retain: true,
                );
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
            progress < 1.0
                ? const Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ),
      ),
    );
  }
}
