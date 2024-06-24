import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:vimeo_clone/Screens/Auth/emailSignup.dart';
import 'package:vimeo_clone/Screens/HomePage/homepage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late VideoPlayerController _controller;
  bool isChecked = false;

  List<Widget> carouselItem = [

    Container(
      child: const Column(
        children: [
          AutoSizeText("Upload in the",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          AutoSizeText("highest quality",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ],
      ),
    ),
    Container(
      child: const Column(
        children: [
          AutoSizeText("Get powerful video",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          AutoSizeText("tools",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ],
      ),
    ),
    Container(
      child: const Column(
        children: [
          AutoSizeText("Discover the world's",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          AutoSizeText("best video",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/glitch.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage())
              );
              // GoRouter.of(context).pushNamed('homePage');
            },
            child: AutoSizeText(
              "SKIP",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: screenWidth*0.4,
            height: screenHeight*0.45,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width ?? 0,
                height: _controller.value.size.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.1,
                right: screenWidth*0.1
            ),
            child: Column(
              children: [
                const AutoSizeText(
                  "Vimeo",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight*0.01,),

                Center(
                  child: CarouselSlider(
                    items: carouselItem,
                    options: CarouselOptions(
                      // Set the desired options for the carousel
                      height: 305, // Set the height of the carousel
                      autoPlay: true, // Enable auto-play
                      autoPlayCurve: Curves.easeInOut, // Set the auto-play curve
                      autoPlayAnimationDuration: const Duration(milliseconds: 500), // Set the auto-play animation duration
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,// Set the aspect ratio of each item
                    ),
                  ),
                ),
                const SizedBox(
                  // height: 205,
                ),

                Container(
                  height: screenHeight*0.070,
                  width: double.infinity,
                  child: MaterialButton(
                    splashColor: Colors.white,
                      // splashColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: const BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupWithEmail())
                        );
                      },
                      child: const AutoSizeText(
                        "JOIN WITH EMAIL",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: screenHeight*0.018,
                ),

                Container(
                  height: screenHeight*0.070,
                  width: double.infinity,
                  child: MaterialButton(
                      color: Colors.blueAccent,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Remix.google_fill, color: Colors.white,),
                          const Text("CONTINUE WITH GOOGLE"),
                        ],
                      )),
                ),
                SizedBox(
                  height: screenHeight*0.018,
                ),

                Container(
                  height: screenHeight*0.070,
                  width: double.infinity,
                  child: MaterialButton(

                      color: Colors.indigo[500],
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Remix.facebook_fill, color: Colors.white,),
                          const AutoSizeText('CONTINUE WITH FACEBOOK'),
                        ],
                      )),
                ),
                SizedBox(
                  height: screenHeight*0.018,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                        activeColor: Colors.blue,
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    const Column(
                      children: [
                        AutoSizeText(
                          'I agree to receive newsletters and',
                          style: TextStyle(color: Colors.white),
                        ),
                        AutoSizeText(
                          "product updates from Vimeo.",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight*0.045,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      'Have an Account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const AutoSizeText(
                        'Log in.',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
