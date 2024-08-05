// import 'package:card_swiper/card_swiper.dart';
// import 'package:flutter/material.dart';
// import 'package:vimeo_clone/Config/constants.dart';
// import 'package:vimeo_clone/Config/theme_data.dart';
// import 'package:vimeo_clone/Screens/ShortsScreen/content_screen.dart';
//
//
// class ShortsPage extends StatefulWidget {
//
//   const ShortsPage({super.key});
//
//   @override
//   State<ShortsPage> createState() => _ShortsPageState();
// }
//
// class _ShortsPageState extends State<ShortsPage> {
//   final List<String> videos = [
//     'https://assets.mixkit.co/videos/preview/mixkit-mountain-range-with-a-clear-blue-sky-1543-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-close-up-of-a-person-working-with-a-sewing-machine-1287-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-woman-doing-yoga-on-the-beach-at-sunset-1556-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-silhouette-of-a-couple-at-sunset-1552-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-mother-and-daughter-painting-on-a-canvas-1458-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-people-dancing-at-a-concert-3559-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-rain-falling-on-leaves-3239-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-woman-picking-flowers-in-a-field-3241-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       body: SafeArea(
//         child: Container(
//           child: Stack(
//             children: [
//               //We need swiper for every content
//               Swiper(
//                 itemBuilder: (BuildContext context, int index) {
//                   return ContentScreen(
//                     src: videos[index],
//                   );
//                 },
//                 itemCount: videos.length,
//                 scrollDirection: Axis.vertical,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: ScreenSize.screenWidth(context) * 0.03,
//                   right: ScreenSize.screenWidth(context) * 0.03
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Shorts',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: fontFamily,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Icon(Icons.camera_alt, color: Colors.white,),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//
//     );
//   }
// }





import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/constants.dart';

import 'content_screen.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({super.key});

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {
  final List<Map<String, dynamic>> videos = [
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-woman-picking-flowers-in-a-field-3241-large.mp4',
      'name': 'flutter_developer01',
      'likes': '120k',
      'profilePhoto': 'https://example.com/profile1.jpg',
      'description': 'Flutter is beautiful and fast 💙❤💛 ..',
      'originalAudio': 'Original Audio - some music track--',
      'comments': 1123,
      'shares': 500,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-close-up-of-a-person-working-with-a-sewing-machine-1287-large.mp4',
      'name': 'flutter_developer02',
      'likes': '99k',
      'profilePhoto': 'https://example.com/profile2.jpg',
      'description': 'Amazing sewing skills in action 🧵',
      'originalAudio': 'Original Audio - sewing machine sound',
      'comments': 876,
      'shares': 320,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-woman-doing-yoga-on-the-beach-at-sunset-1556-large.mp4',
      'name': 'yoga_lover_45',
      'likes': '200k',
      'profilePhoto': 'https://example.com/profile3.jpg',
      'description': 'Yoga and sunset, the perfect combination 🌅',
      'originalAudio': 'Original Audio - yoga meditation',
      'comments': 1500,
      'shares': 700,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-silhouette-of-a-couple-at-sunset-1552-large.mp4',
      'name': 'romantic_couple_12',
      'likes': '150k',
      'profilePhoto': 'https://example.com/profile4.jpg',
      'description': 'Romantic moments captured at sunset ❤️',
      'originalAudio': 'Original Audio - romantic background music',
      'comments': 980,
      'shares': 450,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-mother-and-daughter-painting-on-a-canvas-1458-large.mp4',
      'name': 'art_lover_89',
      'likes': '80k',
      'profilePhoto': 'https://example.com/profile5.jpg',
      'description': 'Artistic expression with my daughter 🎨',
      'originalAudio': 'Original Audio - painting inspiration',
      'comments': 700,
      'shares': 300,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-people-dancing-at-a-concert-3559-large.mp4',
      'name': 'concert_guru_33',
      'likes': '300k',
      'profilePhoto': 'https://example.com/profile6.jpg',
      'description': 'Live concert vibes with energetic dancing 🎤',
      'originalAudio': 'Original Audio - live concert music',
      'comments': 2500,
      'shares': 1200,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-rain-falling-on-leaves-3239-large.mp4',
      'name': 'rain_lover_77',
      'likes': '150k',
      'profilePhoto': 'https://example.com/profile7.jpg',
      'description': 'Peaceful rain falling on leaves 🌧️',
      'originalAudio': 'Original Audio - rain sound',
      'comments': 1100,
      'shares': 500,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-woman-picking-flowers-in-a-field-3241-large.mp4',
      'name': 'flower_lover_55',
      'likes': '180k',
      'profilePhoto': 'https://example.com/profile8.jpg',
      'description': 'Enjoying the beauty of flowers in a field 🌸',
      'originalAudio': 'Original Audio - nature ambience',
      'comments': 900,
      'shares': 400,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
      'name': 'model_photographer_27',
      'likes': '250k',
      'profilePhoto': 'https://example.com/profile9.jpg',
      'description': 'Photography capturing different angles of a model 📸',
      'originalAudio': 'Original Audio - photography theme',
      'comments': 1800,
      'shares': 800,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
      'name': 'christmas_lovers_2023',
      'likes': '180k',
      'profilePhoto': 'https://example.com/profile10.jpg',
      'description': 'Mother and daughter decorating a Christmas tree 🎄',
      'originalAudio': 'Original Audio - Christmas theme',
      'comments': 1500,
      'shares': 700,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
      'name': 'nature_lovers_99',
      'likes': '160k',
      'profilePhoto': 'https://example.com/profile11.jpg',
      'description': 'Mother and daughter enjoying marshmallows in nature 🌳',
      'originalAudio': 'Original Audio - nature sounds',
      'comments': 1200,
      'shares': 600,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
      'name': 'neon_lover_123',
      'likes': '100k',
      'profilePhoto': 'https://example.com/profile12.jpg',
      'description': 'Girl posing with a neon sign in the background ✨',
      'originalAudio': 'Original Audio - urban vibes',
      'comments': 800,
      'shares': 400,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
      'name': 'winter_fashionista_007',
      'likes': '220k',
      'profilePhoto': 'https://example.com/profile13.jpg',
      'description': 'Winter fashion featuring a stylish woman ❄️',
      'originalAudio': 'Original Audio - winter fashion music',
      'comments': 2000,
      'shares': 900,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
      'name': 'poolside_fun_88',
      'likes': '130k',
      'profilePhoto': 'https://example.com/profile14.jpg',
      'description': 'Enjoying a splash in the pool on a sunny day 🏊‍♀️',
      'originalAudio': 'Original Audio - poolside vibes',
      'comments': 1000,
      'shares': 500,
      'liked': false,
    },
    {
      'url': 'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
      'name': 'amusement_park_fun_2024',
      'likes': '180k',
      'profilePhoto': 'https://example.com/profile15.jpg',
      'description': 'Girl blowing bubble gum at an amusement park 🎢',
      'originalAudio': 'Original Audio - amusement park sounds',
      'comments': 1500,
      'shares': 700,
      'liked': false,
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ContentScreen(
                    videoData: videos[index],
                  );
                },
                itemCount: videos.length,
                scrollDirection: Axis.vertical,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shorts',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.camera_alt, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
