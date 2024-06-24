import 'package:flutter/material.dart';
import 'package:vimeo_clone/Screens/Auth/signup.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: screenHeight*0.51,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight*0.03
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person, size: 80,),
                      ),
                    ),

                    SizedBox(height: screenHeight*0.01,),
                    Text('test', style: TextStyle(fontSize: 25, ),),
                    SizedBox(height: screenHeight*0.02,),

                    Material(
                      // color: Colors.white,
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10),
                      child:  Container(
                          height: screenHeight*0.2,
                          width: screenWidth*0.9,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Basic'),
                                MaterialButton(
                                    onPressed: (){},
                                  child: Text('Try Vimeo Plus', style: TextStyle(color: Colors.green)),
                                )
                              ],
                            ),

                            const Divider(thickness: 8,),
                            SizedBox(height: screenHeight*0.015,),

                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Weekly limit'),
                                Text('0MB / 500MB'),
                              ],
                            ),
                            SizedBox(height: screenHeight*0.010,),

                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total limit'),
                                Text('0MB / 5GB'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02,),

                    // Divider(thickness: 1, color: Colors.grey[200],),

                    viewProfileButton(),

                  ],
                ),
              ),
              SizedBox(height: screenHeight*0.025,),


              // Setting Section
              Container(
                // color: Colors.white,
                height: screenHeight*0.17,
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Settings'),
                    ),
                    // SizedBox(height: screenHeight*0.01,),
                    accountButton(),
                    dataUsageButton()
                  ],
                ),
              ),
              SizedBox(height: screenHeight*0.025,),



              // Library Section
              Container(
                // color: Colors.white,
                height: screenHeight*0.29,
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Library'),
                    ),
                    // SizedBox(height: screenHeight*0.01,),
                    purchasesButton(),
                    offlineButton(),
                    watchLaterButton(),
                    likesButton(),
                  ],
                ),
              ),
              SizedBox(height: screenHeight*0.025,),


              // Company Section
              Container(
                // color: Colors.white,
                height: screenHeight*0.35,
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Library'),
                    ),
                    // SizedBox(height: screenHeight*0.01,),
                    uploadGuidelinesButton(),
                    termsOfServicesButton(),
                    privacyPolicyButton(),
                    supportButton(),
                    openSourceLicensesButton()
                  ],
                ),
              ),
              SizedBox(height: screenHeight*0.025,),


              Container(
                height: screenHeight*0.07,
                width: double.infinity,
                // color: Colors.white,
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=> SignupPage()));
                  },
                  child: Text('Log out', style: TextStyle(color: Colors.red),),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }



  Widget viewProfileButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.zero,
      //   side: BorderSide(color: Colors.grey.shade200),
      // ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.person, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('View profile', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }



  Widget accountButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.zero,
        // side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.manage_accounts_rounded, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Account', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }


  Widget dataUsageButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.data_usage, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Data usage', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }

  Widget purchasesButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.zero,
        // side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.monetization_on_outlined, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Purchases', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }



  Widget offlineButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.download, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Offline', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }



  Widget watchLaterButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.watch_later_outlined, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Watch Later', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }



  Widget likesButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.favorite_outline, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Likes', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }


  Widget uploadGuidelinesButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.zero,
        // side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.upload_file_rounded, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Upload Guidelines', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }


  Widget termsOfServicesButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.event_note_outlined, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Terms of Services', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }


  Widget privacyPolicyButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.privacy_tip_outlined, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Privacy policy', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }


  Widget supportButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.support, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Support', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }


  Widget openSourceLicensesButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.grey.shade200),
      ),

      height: screenHeight*0.06,
      onPressed: (){},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            child: Icon(Icons.lock_open, size: 25,),
          ),
          SizedBox(width: screenWidth*0.03,),
          Text('Open source licenses', style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }


}
