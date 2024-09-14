// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:heroicons_flutter/heroicons_flutter.dart';
// import 'package:remixicon/remixicon.dart';
// import 'package:vimeo_clone/Config/constants.dart';
// import 'package:vimeo_clone/bloc/search_data/search_data_bloc.dart';
// import 'package:vimeo_clone/bloc/search_data/search_data_event.dart';
// import 'package:vimeo_clone/bloc/search_suggestion/search_suggestion_bloc.dart';
// import 'package:vimeo_clone/bloc/search_suggestion/search_suggestion_state.dart';
// import 'package:vimeo_clone/routes/myapproute.dart';
//
// import '../../bloc/search_suggestion/search_suggestion_event.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   // SpeechToText _speechToText = SpeechToText();
//   // String _lastWord = '';
//   // bool _speechEnabled = false;
//   late final TextEditingController _searchController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   bool isSearch = false;
//   late var clickedSuggestion ='';
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() {
//       if (!_focusNode.hasFocus) {
//         apiCall();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     _focusNode.dispose();
//     isSearch = false;
//     super.dispose();
//   }
//
//   void apiCall() {
//     // final searchQuery = _searchController.text;
//     // context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
//     // GoRouter.of(context).pushNamed(
//     //     'searchDataPage',
//     //     pathParameters: {
//     //       'searchQuery' : searchQuery
//     //     }
//     // );
//     print("API called after dismissing keyboard.");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: 5.h,
//                   left: 5.w,
//                   right: 5.w
//                 ),
//                 child: Row(
//
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       borderRadius: BorderRadius.circular(100),
//                       onTap: (){
//                         router.pop();
//                       },
//                       child: Container(
//                         height: 30.h,
//                         width: 35.w,
//
//                         // color: Colors.yellow,
//                         child: const Center(
//                           child: Icon(Remix.arrow_left_line),
//                         ),
//                       ),
//                     ),
//
//                     GestureDetector(
//                       onTap: (){
//                         FocusScope.of(context).unfocus();
//                         // Future.delayed(Duration(milliseconds: 100), () {
//                         //   final searchQuery = _searchController.text;
//                         //   context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
//                         // });
//                       },
//                       child: Container(
//                         height: 40.h,
//                         width: 270.w,
//
//                         child: TextFormField(
//                           controller: _searchController,
//                           focusNode: _focusNode,
//                           // maxLines: 2,
//                           autofocus: true,
//                           style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
//                           onChanged: (value){
//                             isSearch = true;
//                             context.read<SearchSuggestionBloc>().add(SearchSuggestionRequest(searchQuery: value));
//                           },
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Theme.of(context).colorScheme.secondary,
//                             hintText: 'Search...',
//                             hintStyle: TextStyle(
//                                 color: Theme.of(context).colorScheme.tertiary, fontSize: 14),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: BorderSide.none,
//                             ),
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: ScreenSize.screenWidth(context) * 0.03,
//                                 vertical: ScreenSize.screenWidth(context) * 0.03),
//                           ),
//                         ),
//                       ),
//                     ),
//
//
//                         SizedBox(
//                           height: 30.h,
//                           width: 35.w,
//                           // color: Colors.red,
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(100),
//                             onTap: (){
//
//                               final searchQuery = _searchController.text;
//                               context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
//                               GoRouter.of(context).pushNamed(
//                                   'searchDataPage',
//                                   pathParameters: {
//                                     'searchQuery' : searchQuery
//                                   }
//                               );
//                             },
//                             child: const Center(
//                               child: Icon(HeroiconsOutline.magnifyingGlass),
//                             ),
//                           ),
//                         )
//                   ],
//                 ),
//               ),
//              // SizedBox(height: 2.h,),
//
//              Expanded(
//                child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 10.h,),
//                      BlocBuilder<SearchSuggestionBloc, SearchSuggestionState>(
//                         builder: (BuildContext context, SearchSuggestionState state) {
//                           if(state is SearchSuggestionLoaded){
//                             final videoSuggestion = state.searchSuggestionData.first.data!.length;
//                             // final channelSuggestion = state.searchSuggestionData.first.data!.channelSuggestions!.length;
//                             final video = state.searchSuggestionData.first.data!;
//                             // final channel = state.searchSuggestionData.first.data!.channelSuggestions;
//                             return isSearch ? Column(
//                               children: [
//                                 video.isNotEmpty ? ListView.builder(
//                                     physics: const NeverScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   padding: EdgeInsets.zero,
//                                   itemCount: videoSuggestion,
//                                     itemBuilder: (BuildContext context, index){
//                                       final videoSearchSuggestion = state.searchSuggestionData.first.data![index].keyword;
//                                       return InkWell(
//                                         onTap: () {
//                                           context.read<SearchDataBloc>().add(
//                                               SearchDataRequest(
//                                                   searchQuery: videoSearchSuggestion));
//                                           GoRouter.of(context).pushNamed(
//                                             'searchDataPage',
//                                             pathParameters: {
//                                               'searchQuery' : videoSearchSuggestion
//                                             }
//                                           );
//                                         },
//
//                                         child: ListTile(
//                                           leading: const Icon(HeroiconsOutline.magnifyingGlass, size: 22,),
//                                           title: Text(
//                                             videoSearchSuggestion!,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                               fontFamily: fontFamily
//                                             ),
//                                           ),
//                                           trailing: const Icon(HeroiconsOutline.arrowUpRight, size: 20,),
//                                         ),
//                                       );
//                                     }
//                                 ) : Container(),
//
//                                 // channel!.isNotEmpty ? ListView.builder(
//                                 //   physics: const NeverScrollableScrollPhysics(),
//                                 //     shrinkWrap: true,
//                                 //     padding: EdgeInsets.zero,
//                                 //     itemCount: channelSuggestion,
//                                 //     itemBuilder: (BuildContext context, index){
//                                 //
//                                 //       final channelSearchSuggestion = state.searchSuggestionData.first.data!.channelSuggestions![index];
//                                 //       return InkWell(
//                                 //         onTap: (){
//                                 //           context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: channelSearchSuggestion));
//                                 //           GoRouter.of(context).pushNamed(
//                                 //               'searchDataPage',
//                                 //               pathParameters: {
//                                 //                 'searchQuery' : channelSearchSuggestion
//                                 //               }
//                                 //           );
//                                 //         },
//                                 //         child: ListTile(
//                                 //           leading: const Icon(HeroiconsOutline.magnifyingGlass, size: 22,),
//                                 //           title: Text(
//                                 //             channelSearchSuggestion,
//                                 //             style: const TextStyle(
//                                 //                 fontFamily: fontFamily
//                                 //             ),
//                                 //           ),
//                                 //           trailing: const Icon(HeroiconsOutline.arrowUpRight, size: 20,),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 // ) : Container(),
//
//                               ],
//                             ) : Container();
//
//                           } else if(state is SearchSuggestionLoading){
//                             return const Center(child: CircularProgressIndicator(),);
//                           }
//                           return Container();
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//              )
//
//             ],
//           )
//       ),
//     );
//   }
// }


















import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';

import '../../bloc/search_data/search_data_bloc.dart';
import '../../bloc/search_data/search_data_event.dart';
import '../../bloc/search_data/search_data_state.dart';
import '../../bloc/search_suggestion/search_suggestion_bloc.dart';
import '../../bloc/search_suggestion/search_suggestion_event.dart';
import '../../bloc/search_suggestion/search_suggestion_state.dart';
import '../../config/constants.dart';
import '../../utils/widgets/video_container.dart';
import '../../utils/widgets/custom_channel_preview.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  final FocusNode _focusNode = FocusNode();
  bool _showSuggestions = true;
  bool _showVideoPreviews = false;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showSuggestions = true;
          _showVideoPreviews = false;
        });
      } else {
        setState(() {
          _showSuggestions = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _currentQuery = query;
      _showSuggestions = false;
      _showVideoPreviews = true;
    });
    context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => GoRouter.of(context).pop(),
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      child: const Center(
                        child: Icon(Remix.arrow_left_line),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      autofocus: true,
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context.read<SearchSuggestionBloc>().add(SearchSuggestionRequest(searchQuery: value));
                          if (_focusNode.hasFocus) {
                            setState(() {
                              _showSuggestions = true;
                              _showVideoPreviews = false;
                            });
                          }
                        } else {
                          setState(() {
                            _showSuggestions = false;
                            _showVideoPreviews = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.screenWidth(context) * 0.03,
                            vertical: ScreenSize.screenWidth(context) * 0.03),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 35.w,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => _performSearch(_searchController.text),
                      child: const Center(
                        child: Icon(HeroiconsOutline.magnifyingGlass),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_showSuggestions)
                      BlocBuilder<SearchSuggestionBloc, SearchSuggestionState>(
                        builder: (BuildContext context, SearchSuggestionState state) {
                          if (state is SearchSuggestionLoaded) {
                            final videoSuggestion = state.searchSuggestionData.first.data!;
                            return Column(
                              children: [
                                videoSuggestion.isNotEmpty ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: videoSuggestion.length,
                                  itemBuilder: (BuildContext context, index) {
                                    final videoSearchSuggestion = videoSuggestion[index].keyword;
                                    return InkWell(
                                      onTap: () {
                                        _performSearch(videoSearchSuggestion);
                                        GoRouter.of(context).pushNamed(
                                            'searchDataPage',
                                            pathParameters: {'searchQuery': videoSearchSuggestion}
                                        );
                                      },
                                      child: ListTile(
                                        leading: const Icon(HeroiconsOutline.magnifyingGlass, size: 22),
                                        title: Text(
                                          videoSearchSuggestion!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontFamily: fontFamily),
                                        ),
                                        trailing: const Icon(HeroiconsOutline.arrowUpRight, size: 20),
                                      ),
                                    );
                                  },
                                ) : Container(),
                              ],
                            );
                          }
    // else if (state is SearchSuggestionLoading) {
                          //   return const Center(child: CircularProgressIndicator());
                          // }
                          return Container();
                        },
                      ),
                    if (_showVideoPreviews)
                      BlocBuilder<SearchDataBloc, SearchDataState>(
                        builder: (BuildContext context, SearchDataState state) {
                          if (state is SearchDataLoaded) {
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
                                    return VideoListItem(
                                      onTap: () {
                                        GoRouter.of(context).pushNamed('videoPage',
                                            pathParameters: {"slug": searchData.slug!});
                                      },
                                      onTapChannel: () {
                                        final String channelId = searchData.channel!.id.toString();
                                        GoRouter.of(context).pushNamed(
                                            'channelProfilePage',
                                            pathParameters: {'channelId': channelId});
                                      },
                                      thumbnailUrl: searchData.thumbnail!,
                                      duration: formattedDuration,
                                      title: searchData.title!,
                                      author: searchData.channel!.name!,
                                      views: searchData.views.toString(),
                                      uploadTime: searchData.createdAtHuman!,
                                    );
                                  },
                                ) : Container(),
                                state.searchData.first.data!.channels!.isNotEmpty ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.searchData.first.data!.channels!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final searchChannelData = state.searchData.first.data!.channels![index];
                                    return Padding(
                                      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                                      child: InkWell(
                                        onTap: () {
                                          final String channelId = searchChannelData.id.toString();
                                          GoRouter.of(context).pushNamed(
                                              'channelProfilePage',
                                              pathParameters: {'channelId': channelId});
                                        },
                                        child: CustomChannelPreview(
                                          channelLogo: searchChannelData.logo!,
                                          channelName: searchChannelData.name!,
                                          channelSubscriber: searchChannelData.id.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                ) : Container(),
                              ],
                            );
                          }
                          // else if (state is SearchDataLoading) {
                          //   return const Center(child: CircularProgressIndicator());
                          // }
                          return Container();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDuration(int seconds) {
  final minutes = (seconds / 60).floor();
  final sec = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
}

