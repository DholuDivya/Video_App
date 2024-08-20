import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

class SearchDataPage extends StatefulWidget {
  const SearchDataPage({super.key});

  @override
  State<SearchDataPage> createState() => _SearchDataPageState();
}

class _SearchDataPageState extends State<SearchDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            GoRouter.of(context).pop();
          },
          child: Container(
            height: 30,
            width: 30,
            // color: Colors.yellow,
            child: Center(
              child: Icon(Remix.arrow_left_line),
            ),
          ),
        ),


      ),
    );
  }
}
