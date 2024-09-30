import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import '../../bloc/search_data/search_data_bloc.dart';
import '../../bloc/search_data/search_data_state.dart';
import '../../config/constants.dart';
import '../../utils/widgets/custom_channel_preview.dart';
import '../../utils/widgets/video_container.dart';

class SearchDataPage extends StatefulWidget {
  final String searchQuery;
  const SearchDataPage({super.key, required this.searchQuery});

  @override
  State<SearchDataPage> createState() => _SearchDataPageState();
}

class _SearchDataPageState extends State<SearchDataPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 5.h,
                    left: 5.w,
                    right: 5.w
                ),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: (){
                        GoRouter.of(context).pop();
                      },
                      child: Container(
                        height: 30.h,
                        width: 35.w,

                        // color: Colors.yellow,
                        child: const Center(
                          child: Icon(Remix.arrow_left_line),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        // Future.delayed(Duration(milliseconds: 100), () {
                        //   final searchQuery = _searchController.text;
                        //   context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
                        // });
                        GoRouter.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 35.h,
                        width: 270.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w
                        ),
                        child: Text(
                            widget.searchQuery,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            color: Theme.of(context).colorScheme.tertiary, fontSize: 14,

                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 30.h,
                      width: 35.w,
                      // color: Colors.red,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          //
                          // final searchQuery = _searchController.text;
                          // context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
                        },
                        child: const Center(
                          child: Icon(HeroiconsOutline.magnifyingGlass),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 2.h,),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      BlocBuilder<SearchDataBloc, SearchDataState>(
                        builder: (BuildContext context, SearchDataState state) {
                          if(state is SearchDataLoaded){
                            print('sejhsehhsehioewsgvrsg');
                            return Column(
                              children: [
                                state.searchData.first.data!.videos!.isNotEmpty ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.searchData.first.data!.videos!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final searchData = state.searchData.first.data!.videos![index];
                                    final totalSeconds = searchData.duration;
                                    final formattedDuration = formatDuration(totalSeconds!);
                                    print('ijrijirjgrjgirg:::"""""::":":":"{');
                                    return VideoListItem(
                                        onTap: () {
                                          Future.delayed(
                                              const Duration(milliseconds: 200), () {
                                            GoRouter.of(context).pushNamed('videoPage',
                                                pathParameters: {
                                                  "slug": searchData.slug!
                                                });
                                          });
                                        },
                                        onTapChannel: (){
                                          final String channelId = searchData.channel!.id.toString();
                                          GoRouter.of(context).pushNamed(
                                              'channelProfilePage',
                                              pathParameters: {
                                                'channelId': channelId
                                              }
                                          );
                                        },
                                        thumbnailUrl: searchData.thumbnail!,
                                        duration: formattedDuration,
                                        title: searchData.title!,
                                        author: searchData.channel!.name!,
                                        views: searchData.views.toString(),
                                        uploadTime: searchData.createdAtHuman!
                                    );
                                  },
                                ) : Container(),

                                // CHANNEL PREVIEW
                                state.searchData.first.data!.channels!.isNotEmpty ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.searchData.first.data!.channels!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final searchChannelData = state.searchData.first.data!.channels![index];
                                    // final totalSeconds = searchData;
                                    // final formattedDuration = formatDuration(totalSeconds!);
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 5.h,
                                          bottom: 5.h
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          final String channelId = searchChannelData.id.toString();
                                          GoRouter.of(context).pushNamed(
                                              'channelProfilePage',
                                              pathParameters: {
                                                'channelId': channelId
                                              }
                                          );
                                        },
                                        child: CustomChannelPreview(
                                            channelLogo: searchChannelData.logo!,
                                            channelName: searchChannelData.name!,
                                            channelSubscriber: searchChannelData.id.toString()
                                        ),
                                      ),
                                    );
                                  },
                                ) : Container(),
                              ],
                            );
                          } else if(state is SearchDataLoading){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              )

            ],
          )
      ),
    );
  }
}
