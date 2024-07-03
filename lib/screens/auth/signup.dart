import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:vimeo_clone/Screens/Auth/emailSignup.dart';
import 'package:vimeo_clone/Screens/HomePage/homepage.dart';
import 'package:vimeo_clone/config/constants.dart';

import '../../config/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // late VideoPlayerController _controller;
  bool isChecked = false;

  // List<Widget> carouselItem = [
  //
  //   Container(
  //     child: const Column(
  //       children: [
  //         AutoSizeText("Upload in the",
  //             style: TextStyle(fontSize: 30, color: Colors.white)),
  //         AutoSizeText("highest quality",
  //             style: TextStyle(fontSize: 30, color: Colors.white)),
  //       ],
  //     ),
  //   ),
  //   Container(
  //     child: const Column(
  //       children: [
  //         AutoSizeText("Get powerful video",
  //             style: TextStyle(fontSize: 30, color: Colors.white)),
  //         AutoSizeText("tools",
  //             style: TextStyle(fontSize: 30, color: Colors.white)),
  //       ],
  //     ),
  //   ),
  //   Container(
  //     child: const Column(
  //       children: [
  //         AutoSizeText("Discover the world's",
  //             style: TextStyle(fontSize: 30, color: Colors.white)),
  //         AutoSizeText("best video",
  //             style: TextStyle(fontSize: 30, color: Colors.white)),
  //       ],
  //     ),
  //   ),
  // ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _controller = VideoPlayerController.asset('assets/videos/glitch.mp4')
  //     ..initialize().then((_) {
  //       _controller.play();
  //       _controller.setLooping(true);
  //       // Ensure the first frame is shown after the video is initialized
  //       setState(() {});
  //     });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   actions: [
      //     MaterialButton(
      //       onPressed: () {
      //         // Navigator.pushReplacement(
      //         //     context,
      //         //     MaterialPageRoute(builder: (context) => HomePage())
      //         // );
      //         GoRouter.of(context).pushReplacementNamed('homePage');
      //       },
      //       child: AutoSizeText(
      //         "SKIP",
      //         style: TextStyle(color: Colors.grey),
      //       ),
      //     )
      //   ],
      // ),
      body: Stack(
        children: [
          // SizedBox(
          //   width: screenWidth*0.4,
          //   height: screenHeight*0.45,
          //   child: FittedBox(
          //     fit: BoxFit.cover,
          //     child: SizedBox(
          //       width: _controller.value.size.width ?? 0,
          //       height: _controller.value.size.height ?? 0,
          //       child: VideoPlayer(_controller),
          //     ),
          //   ),
          // ),

          Container(
            height: 360,
            width: 360,
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(500))),
          ),

          Container(
            height: 320,
            width: 320,
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(500))),
          ),

          Container(
            height: 280,
            width: 280,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(500))),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 50, right: 20),
              child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      darkOpacityColor,
                    ),
                  ),
                  onPressed: (){
                    GoRouter.of(context).pushReplacementNamed('homePage');
                  },
                  child: Text('Skip',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
              ),
              // child: InkWell(
              //     onTap: () {
              //       GoRouter.of(context).pushReplacementNamed('homePage');
              //     },
              //     child: Text(
              //       'Skip',
              //       style: TextStyle(
              //           fontFamily: fontFamily,
              //           fontSize: 15,
              //           fontWeight: FontWeight.bold),
              //     )),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
                left: ScreenSize.screenWidth(context) * 0.1,
                right: ScreenSize.screenWidth(context) * 0.1
            ),
            child: Column(
              children: [
                // const AutoSizeText(
                //   "Vimeo",
                //   style: TextStyle(
                //     fontSize: 64,
                //     color: Colors.white,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Remix.youtube_fill,
                        size: 120,
                        color: Colors.red,
                      )),
                ),
                SizedBox(
                  height: ScreenSize.screenHeight(context) * 0.01,
                ),

                // Align(
                //   alignment: Alignment.topRight,
                //   child: TextButton(
                //       onPressed: (){
                //         GoRouter.of(context).pushNamed('homePage');
                //       },
                //       child: Text('skip',)
                //   ),
                // ),

                // Center(
                //   child: CarouselSlider(
                //     items: carouselItem,
                //     options: CarouselOptions(
                //       // Set the desired options for the carousel
                //       height: 305, // Set the height of the carousel
                //       autoPlay: true, // Enable auto-play
                //       autoPlayCurve: Curves.easeInOut, // Set the auto-play curve
                //       autoPlayAnimationDuration: const Duration(milliseconds: 500), // Set the auto-play animation duration
                //       aspectRatio: 16 / 9,
                //       viewportFraction: 1.0,// Set the aspect ratio of each item
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 150,
                ),

                Container(
                  height: ScreenSize.screenHeight(context) * 0.070,
                  width: double.infinity,
                  child: MaterialButton(
                      splashColor: Colors.white,
                      // splashColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: const BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => SignupWithEmail())
                        // );
                        GoRouter.of(context).pushNamed('emailSignup');
                      },
                      child: const AutoSizeText(
                        "JOIN WITH EMAIL",
                        style: TextStyle(
                            color: Colors.white,
                          fontFamily: fontFamily
                        ),
                      )),
                ),
                SizedBox(
                  height: ScreenSize.screenHeight(context) * 0.018,
                ),

                Container(
                  height: ScreenSize.screenHeight(context) * 0.070,
                  width: double.infinity,
                  child: MaterialButton(
                      color: Colors.blueAccent,
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Remix.google_fill,
                            color: Colors.white,
                          ),
                          Text("CONTINUE WITH GOOGLE",
                            style: TextStyle(
                              fontFamily: fontFamily,
                              color: Colors.white
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: ScreenSize.screenHeight(context) * 0.018,
                ),

                SizedBox(
                  height: ScreenSize.screenHeight(context) * 0.070,
                  width: double.infinity,
                  child: MaterialButton(
                      color: Colors.indigo[500],
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Remix.facebook_fill,
                            color: Colors.white,
                          ),
                          AutoSizeText('CONTINUE WITH FACEBOOK',
                            style: TextStyle(
                              fontFamily: fontFamily,
                                color: Colors.white
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: ScreenSize.screenHeight(context) * 0.018,
                ),

                Row(

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
                          style: TextStyle(
                            // color: Colors.white,
                            fontFamily: fontFamily,
                            fontSize: 12
                          ),
                        ),
                        AutoSizeText(
                          "product updates from $appName.",
                          style: TextStyle(
                              // color: Colors.white,
                              fontFamily: fontFamily,
                              fontSize: 12
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenSize.screenHeight(context) * 0.045,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      'Have an Account? ',
                      style: TextStyle(
                          // color: Colors.white,
                          fontFamily: fontFamily
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const AutoSizeText(
                        'Log in.',
                        style: TextStyle(
                            // color: Colors.white,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold
                        ),
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
