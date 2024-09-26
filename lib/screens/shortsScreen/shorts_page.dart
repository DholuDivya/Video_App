import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_state.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<GetShortsListBloc, GetShortsListState>(
            builder: (BuildContext context, state) {
              if(state is GetShortsListLoaded){
                final shortsData = state.shortsList;
                return RefreshIndicator(
                  onRefresh: refreshList,
                  child: Swiper(
                    loop: false,
                    scrollDirection: Axis.vertical,
                    itemCount: shortsData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContentScreen(
                        shortsData: shortsData[index],
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
                right: MediaQuery.of(context).size.width * 0.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(HeroiconsSolid.magnifyingGlass, color: Colors.white, size: 22.r,)
                  ),
                  const SizedBox(width: 0,),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(HeroiconsOutline.ellipsisVertical, color: Colors.white, size: 22.r,),
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
