import 'package:flutter/material.dart';
import 'package:vimeo_clone/Screens/accountpage.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text('Watch'),
            floating: false,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.black),
              ),
              SizedBox(width: screenWidth * 0.01),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage())
                  );
                },
                icon: const Icon(Icons.person, color: Colors.black),
              ),
              SizedBox(width: screenWidth * 0.008),
            ],
          ),
          
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('My feed', style: TextStyle(fontSize: 20),),
                ),


                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(

                    height: screenHeight*0.30,
                    padding: EdgeInsets.only(
                      top: screenHeight*0.05,
                        left: screenWidth*0.09,
                        right: screenWidth*0.09
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text('Personalize your feed', style: TextStyle(fontSize: 18),),
                          SizedBox(height: screenHeight*0.01,),
                          Text('Follow categories, creators, and channels',
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),),
                          Text('    to make the feed perfect for Y-O-U.',
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),),

                          SizedBox(height: screenHeight*0.02,),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            ),
                            color: Colors.lightBlueAccent,
                            height: screenHeight*0.05,
                            minWidth: screenWidth*0.28,
                            onPressed: (){},
                            child: Text('LET\'S GO'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*0.001,),

                staffPicksCategory(),
                SizedBox(height: screenHeight*0.001,),

                brandContentCategory(),
                SizedBox(height: screenHeight*0.001,),

                animationCategory(),
                SizedBox(height: screenHeight*0.001,),

                comedyCategory(),
                SizedBox(height: screenHeight*0.001,),

                documentaryCategory(),
                SizedBox(height: screenHeight*0.001,),

                sportsCategory(),
                SizedBox(height: screenHeight*0.001,),

                dramaCategory(),
                SizedBox(height: screenHeight*0.001,),

                musicCategory(),
                SizedBox(height: screenHeight*0.001,),

                commercialsCategory(),
                SizedBox(height: screenHeight*0.001,),

                travelCategory(),
                SizedBox(height: screenHeight*0.001,),

                experimentalCategory(),
                SizedBox(height: screenHeight*0.001,),
              ],
            ),
          )
        ],
      ),
    );
  }



  Widget staffPicksCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth*0.06,
              right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('STAFF PICKS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                    onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
            height: screenHeight*0.29,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
                itemBuilder: (context, index){
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                      left: screenWidth*0.04,
                      right: screenWidth*0.01
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [


                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                          
                            height: screenHeight*0.28,
                            width: screenWidth*0.80,
                            decoration: BoxDecoration(
                          
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
                                Container(
                                    height: screenHeight*0.18,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)
                                      ),
                                    ),
                                    child: Image.asset('assets/images/staffpick.jpg',fit: BoxFit.fitWidth,)
                                ),
                                SizedBox(height: screenHeight*0.005,),

                                Padding(
                                  padding: EdgeInsets.only(left: screenWidth*0.05,),
                                  child: Text('title', style: TextStyle(fontSize: 20,),),
                                ),
                                // SizedBox(height: screenHeight*0.001,),

                                Padding(
                                  padding: EdgeInsets.only(left: screenWidth*0.05),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 8,
                                        backgroundColor: Colors.purple,
                                        child: Image.asset('assets/images/staffpick.jpg',fit: BoxFit.fill,),
                                      ),
                                      SizedBox(width: screenWidth*0.01,),
                                      Text('channel name', style: TextStyle(fontSize: 13),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight*0.002,),
                                Padding(
                                  padding: EdgeInsets.only(left: screenWidth*0.05),
                                  child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            )
          )
        ],
      ),
    );
  }




  Widget brandContentCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Brand content', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.75,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/brand.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.purple,
                                            child: Image.asset('assets/images/brand.jpg',fit: BoxFit.fill,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }




  Widget animationCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Animation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/animation.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/animation.jpg',fit: BoxFit.fill,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }




  Widget comedyCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Comedy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/comedy.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/comedy.jpg',)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }



  Widget documentaryCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Documentary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/documentary.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/documentary.jpg',fit: BoxFit.fill,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }



  Widget sportsCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sports', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/sport.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/sport.jpg',fit: BoxFit.fill,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }



  Widget dramaCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Drama', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/drama.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/drama.jpg',fit: BoxFit.fill,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }



  Widget musicCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Music', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/music.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/music.jpg',fit: BoxFit.fitWidth,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }



  Widget commercialsCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Commercials', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/commercial.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/commercial.jpg',fit: BoxFit.fill,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }



  Widget travelCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Travel', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/travel.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/travel.jpg',fit: BoxFit.fill,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }



  Widget experimentalCategory(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.40,
      // color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.06,
                right: screenWidth*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Experimental', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                MaterialButton(
                  minWidth: 20,
                  // color: Colors.red,
                  onPressed: (){},
                  child: Text('View all'),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.orange,
              height: screenHeight*0.29,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0,
                          left: screenWidth*0.04,
                          right: screenWidth*0.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [


                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              height: screenHeight*0.28,
                              width: screenWidth*0.80,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      height: screenHeight*0.18,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)
                                        ),
                                      ),
                                      child: Image.asset('assets/images/experimental.jpg',fit: BoxFit.fitWidth,)
                                  ),
                                  SizedBox(height: screenHeight*0.005,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05,),
                                    child: Text('title', style: TextStyle(fontSize: 20,),),
                                  ),
                                  // SizedBox(height: screenHeight*0.001,),

                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                            child: Image.asset('assets/images/experimental.jpg',fit: BoxFit.fill,)
                                        ),
                                        SizedBox(width: screenWidth*0.01,),
                                        Text('channel name', style: TextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.002,),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth*0.05),
                                    child: Text('171 view - 2 days ago', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }
}








