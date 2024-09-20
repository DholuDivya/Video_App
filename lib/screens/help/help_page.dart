// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:vimeo_clone/config/colors.dart';
//
// class HelpPage extends StatefulWidget {
//   const HelpPage({super.key});
//
//   @override
//   State<HelpPage> createState() => _HelpPageState();
// }
//
// class _HelpPageState extends State<HelpPage> {
//
//   bool isNative = false;
//   late NativeAd nativeAd;
//
//   void initialiseNativeAd() async {
//     nativeAd = NativeAd(
//         adUnitId: "ca-app-pub-2734509756038446/4325909428",
//         listener: NativeAdListener(
//           onAdLoaded: (ad){
//             setState(() {
//               isNative = true;
//             });
//           },
//           onAdFailedToLoad: (ad, error){
//             setState(() {
//               isNative = false;
//               nativeAd.dispose();
//               print(error);
//             });
//           }
//         ),
//         request: AdManagerAdRequest()
//     );
//     nativeAd.load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//          backgroundColor: primaryColor,
//          title: const Text('Native ADS'),
//        ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 200,
//             child: AdWidget(ad: nativeAd),
//           )
//         ],
//       ),
//     );
//   }
// }



//
//
//
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:vimeo_clone/config/colors.dart';
//
// class HelpPage extends StatefulWidget {
//   const HelpPage({super.key});
//
//   @override
//   State<HelpPage> createState() => _HelpPageState();
// }
//
// class _HelpPageState extends State<HelpPage> {
//
//   bool isNative = false;
//   NativeAd? nativeAd;
//
//   @override
//   void initState() {
//     super.initState();
//     initialiseNativeAd();
//   }
//
//   void initialiseNativeAd() async {
//     nativeAd = NativeAd(
//       adUnitId: "ca-app-pub-2734509756038446/4325909428",
//       factoryId: 'adFactoryExample', 
//       listener: NativeAdListener(
//         onAdLoaded: (ad) {
//           setState(() {
//             isNative = true;
//           });
//         },
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//           setState(() {
//             isNative = false;
//             nativeAd = null;
//             print(error);
//           });
//         },
//       ),
//       request: AdManagerAdRequest(),
//     );
//     nativeAd!.load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: Text('Native ADS'),
//       ),
//       body: Column(
//         children: [
//           if (isNative && nativeAd != null)
//             SizedBox(
//               height: 200,
//               child: AdWidget(ad: nativeAd!),
//             )
//           else
//             SizedBox(
//               height: 200,
//               child: Center(child: Text('Ad failed to load')),
//             ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     nativeAd?.dispose();
//     super.dispose();
//   }
// }







import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HelpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  late NativeAd _nativeAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();

  @override
  void initState() {
    super.initState();
    _nativeAd = NativeAd(
      adUnitId: "ca-app-pub-2734509756038446/4325909428",
      request: AdRequest(),
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          nativeAdCompleter.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('$NativeAd failedToLoad: $error');

        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),

      ),
    );
    Future<void>.delayed(Duration(seconds: 1), () => _nativeAd.load());
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NativeAd>(
      future: nativeAdCompleter.future,
      builder: (BuildContext context, AsyncSnapshot<NativeAd> snapshot) {
        Widget child;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            child = Container();
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              child = AdWidget(ad: _nativeAd);
            } else {
              child = Text('Error loading $NativeAd');
            }
        }

        return Container(
          width: 250,
          height: 350,
          child: child,
          color: Colors.blueGrey,
        );
      },
    );
  }
}