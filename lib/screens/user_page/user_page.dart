import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/user_page/widgets/custom_user_page_button.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_header_widget.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_history_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).pushNamed('notificationPage');
              },
              icon: Icon(HeroiconsOutline.bell),
          ),

          IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed('searchPage');
            },
            icon: Icon(HeroiconsOutline.magnifyingGlass),
          ),

          IconButton(
            icon: Icon(HeroiconsOutline.cog8Tooth),
            onPressed: () {
              GoRouter.of(context).pushNamed('settingPage');
            },

          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            UserHeaderWidget(),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),

            UserHistoryWidget(),

            UserPageButton(
                buttonName: 'Your Videos',
                buttonIcon: HeroiconsOutline.play
            ),


            UserPageButton(
                buttonName: 'Downloads',
                buttonIcon: HeroiconsOutline.arrowDownTray
            ),

            Divider(thickness: 0.2, color: Colors.grey,),

            UserPageButton(
                buttonName: 'Your Movies',
                buttonIcon: HeroiconsOutline.film
            ),

            UserPageButton(
                buttonName: 'Get ${appName} Premium',
                buttonIcon: Remix.youtube_line
            ),

            Divider(thickness: 0.2, color: Colors.grey,),

            UserPageButton(
                buttonName: 'Time watched',
                buttonIcon: HeroiconsOutline.chartBarSquare
            ),

            UserPageButton(
                buttonName: 'Help & feedback',
                buttonIcon: HeroiconsOutline.questionMarkCircle
            ),

          ],
        ),
      ),
    );
  }
}
