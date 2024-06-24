import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Screens/accountpage.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
                SliverAppBar(
      
                  title: Text('App Name'),
                  pinned: true,
                  floating: false,
                  backgroundColor: Colors.white,
                  leading: Icon(Remix.youtube_fill),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Remix.search_line, color: Colors.black),
                    ),
                    // SizedBox(width: screenWidth * 0.01),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AccountPage())
                        );
                      },
                      icon: const Icon(Remix.notification_3_line, color: Colors.black),
                    ),
                    SizedBox(width: screenWidth * 0.008),
                  ],
                  bottom: TabBar(
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Trending'),
                    ],
                  ),
                ),
              SliverFillRemaining(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                        color: Colors.orange,
                        child: ListView.builder(
                          itemCount: 50,
                          itemBuilder: (BuildContext context, int index) {
                            return Text('Hello', style: TextStyle(fontSize: 25),);
                          },

                        )
                    ),
                    Container(
                      color: Colors.green,
                      child: Center(
                        child: const Text('Showcases'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
