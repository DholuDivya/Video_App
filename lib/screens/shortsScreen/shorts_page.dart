

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_state.dart';
import 'package:vimeo_clone/config/constants.dart';

import 'content_screen.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({super.key});

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {
  @override
  void initState() {
    context.read<GetShortsListBloc>().add(GetShortsListRequest());
    super.initState();
  }

  Future<void> refreshList()async{
    context.read<GetShortsListBloc>().add(GetShortsListRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        child: Stack(
          children: [
            BlocBuilder<GetShortsListBloc, GetShortsListState>(
            builder: (BuildContext context, state) {
              if(state is GetShortsListLoaded){
                final shortsData = state.shortsData.first.data;
                return RefreshIndicator(
                  onRefresh: refreshList,
                  child: Swiper(
                    loop: false,
                    scrollDirection: Axis.vertical,
                    itemCount: shortsData!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContentScreen(
                        shortsData: shortsData.data![index],
                      );
                    },
                  ),
                );
              }
                return Container();
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              child: const Row(
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
                  // Icon(Icons.camera_alt, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
