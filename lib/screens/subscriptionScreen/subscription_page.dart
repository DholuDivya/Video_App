import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  bool isSelectedAll = true;
  bool isSelectedPersonalized = false;
  bool isSelectedNone = false;
  bool isSubscribed = false;
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Subscriptions',
              style: TextStyle(
                fontFamily: fontFamily,
              ),
            ),
            // centerTitle: true,
            floating: true,
            pinned: false,
            snap: false,
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: Icon(
              Remix.youtube_fill,
              size: 35,
              color: Colors.red,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed('searchPage');
                },
                icon: Icon(
                  HeroiconsOutline.magnifyingGlass,
                  size: 22,
                ),
              ),
              // SizedBox(width: screenWidth * 0.01),
              IconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed('notificationPage');
                },
                icon: const Icon(
                  HeroiconsOutline.bell,
                  size: 22,
                ),
              ),
              SizedBox(width: ScreenSize.screenWidth(context) * 0.008),
            ],
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return SizedBox(
                  height: 60,
                  child: InkWell(
                    onTap: (){
                      GoRouter.of(context).pushNamed('channelProfilePage');
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage('assets/images/sonysab.jpg'),
                      ),
                      // leading: ClipRRect(
                      //   borderRadius: BorderRadius.circular(100),
                      //   child: Image.asset(
                      //       'assets/images/sonysab.jpg',
                      //       fit: BoxFit.cover,
                      //     height: ScreenSize.screenHeight(context) * 0.05,
                      //     width: ScreenSize.screenWidth(context) * 0.12,
                      //   ),
                      // ),
                      title: Text('Sony Sab'),
                      trailing: Container(
                          width: 55,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.secondary
                          ),
                          child: InkWell(
                            onTap: _showNotificationDialog,
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(HeroiconsOutline.bell, size: 16,)  ,
                                Icon(HeroiconsOutline.chevronDown, size: 16,)
                              ],
                            ),
                          ),
                        ),
                      ),
                  ),
                  );
              },
              childCount: 15, // Specify the number of items in the list
            ),
          ),
        ],
      ),
    );
  }


  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Notifications',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 20
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomNotificationRow(
                    notificationIcon: HeroiconsSolid.bellAlert,
                    type: 'All',
                    onTap: () {
                      setState(() {
                        isSelectedAll = true;
                        isSelectedPersonalized = false;
                        isSelectedNone = false;
                        GoRouter.of(context).pop();
                      });
                    },
                    selectedType: isSelectedAll
                        ? Remix.check_line : null,
                  ),
                  CustomNotificationRow(
                    notificationIcon: HeroiconsOutline.bell,
                    type: 'Personalized',
                    onTap: (){
                      setState(() {
                        isSelectedAll = false;
                        isSelectedPersonalized = true;
                        isSelectedNone = false;
                        GoRouter.of(context).pop();
                      });
                    },
                    selectedType: isSelectedPersonalized
                        ? Remix.check_line : null,
                  ),
                  CustomNotificationRow(
                    notificationIcon: HeroiconsOutline.bellSlash,
                    type: 'None',
                    onTap: (){
                      setState(() {
                        isSelectedAll = false;
                        isSelectedPersonalized = false;
                        isSelectedNone = true;
                        // Navigator.of(context).pop();
                        GoRouter.of(context).pop();
                      });
                    },
                    selectedType: isSelectedNone
                        ? Remix.check_line : null,
                  ),

                  Divider(thickness: 0.3,),

                  CustomNotificationRow(
                      notificationIcon: HeroiconsOutline.userMinus,
                      type: 'Unsubscribe',
                      onTap: (){
                      // Navigator.of(context).pop();
                        GoRouter.of(context).pop();
                        setState(() {
                          isSubscribed = !isSubscribed;
                        });
                      },
                  )
                ],
              ),
            );
          }
        );
      },
    );
  }


}

class CustomNotificationRow extends StatelessWidget {
  final IconData notificationIcon;
  final String type;
  final VoidCallback? onTap;
  final IconData? selectedType;

  const CustomNotificationRow({
    super.key,
    required this.notificationIcon,
    required this.type,
    this.onTap,
    this.selectedType,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Row(
                  children: [
                    Icon(notificationIcon, size: 18,),
                    SizedBox(width: 20),
                    Text(type, style: TextStyle(fontFamily: fontFamily, fontSize: 15),),
                  ],
                ),
                Icon(selectedType)
            ],
          ),
        ),
      ),
    );
  }
}
