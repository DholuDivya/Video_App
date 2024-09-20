import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_event.dart';
import '../../bloc/get_shorts_list/get_shorts_list_bloc.dart';
import '../../bloc/get_shorts_list/get_shorts_list_state.dart';
import '../shortsScreen/content_screen.dart';

class PlayHomeShortsPage extends StatefulWidget {
  final String shortsSlug;
  const PlayHomeShortsPage({super.key, required this.shortsSlug});

  @override
  State<PlayHomeShortsPage> createState() => _PlayHomeShortsPageState();
}

class _PlayHomeShortsPageState extends State<PlayHomeShortsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetShortsListBloc>().add(GetShortsBySlugRequest(shortsSlug: widget.shortsSlug));
  }

  Future<void> refreshList()async{
    context.read<GetShortsListBloc>().add(GetShortsBySlugRequest(shortsSlug: widget.shortsSlug));
  }

  @override
  Widget build(BuildContext context) {

    print('sdnhvfisd   ${widget.shortsSlug}');
    return Scaffold(
      backgroundColor: Colors.grey[900],

      body: Stack(
        children: [
          BlocBuilder<GetShortsListBloc, GetShortsListState>(
            builder: (BuildContext context, state) {
              if(state is GetShortsBySlugLoaded){
                final shortsData = state.shortsData.first.data;
                return RefreshIndicator(
                  onRefresh: refreshList,
                  child: Swiper(
                    loop: false,
                    scrollDirection: Axis.vertical,
                    itemCount: shortsData!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContentScreen(
                        shortsData: state.shortsData.first.data![index],
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
    );
  }
}
