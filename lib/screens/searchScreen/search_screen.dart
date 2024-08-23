import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_bloc.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_event.dart';
import 'package:vimeo_clone/bloc/search_suggestion/search_suggestion_bloc.dart';
import 'package:vimeo_clone/bloc/search_suggestion/search_suggestion_state.dart';
import 'package:vimeo_clone/routes/myapproute.dart';

import '../../bloc/search_suggestion/search_suggestion_event.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // SpeechToText _speechToText = SpeechToText();
  // String _lastWord = '';
  // bool _speechEnabled = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        apiCall();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    isSearch = false;
    super.dispose();
  }

  void apiCall() {
    final searchQuery = _searchController.text;
    context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
    GoRouter.of(context).pushNamed(
        'searchDataPage',
        pathParameters: {
          'searchQuery' : searchQuery
        }
    );
    print("API called after dismissing keyboard.");
  }


  // void apiCall() {
  //   final searchQuery = _searchController.text.trim();
  //   if (searchQuery.isNotEmpty) {
  //     context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
  //     print("API called with query: $searchQuery");
  //   } else {
  //     print("Search query is empty. No API call made.");
  //   }
  // }
  // void _initSpeech() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   setState(() {});
  // }

  // void _startListening() async {
  //   await _speechToText.listen(onResult: _onSpeechResult);
  //   setState(() {});
  // }

  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }

  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     _lastWord = result.recognizedWords;
  //     _updateSearchText(); // Update text field when speech result changes
  //   });
  // }

  // void _updateSearchText() {
  //   _searchText.text = _lastWord;
  // }

  @override
  Widget build(BuildContext context) {
    //     ),
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
                        router.pop();
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
                      },
                      child: Container(
                        height: 40.h,
                        width: 270.w,

                        child: TextFormField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          // maxLines: 2,
                          autofocus: true,
                          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                          onChanged: (value){
                            isSearch = true;
                            context.read<SearchSuggestionBloc>().add(SearchSuggestionRequest(searchQuery: value));
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.secondary,
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary, fontSize: 14),
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
                    ),


                        SizedBox(
                          height: 30.h,
                          width: 35.w,
                          // color: Colors.red,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: (){

                              // final searchQuery = _searchController.text;
                              // context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
                              // GoRouter.of(context).pushNamed(
                              //     'searchDataPage',
                              //     pathParameters: {
                              //       'searchQuery' : searchQuery
                              //     }
                              // );
                            },
                            child: const Center(
                              child: Icon(HeroiconsOutline.magnifyingGlass),
                            ),
                          ),
                        )
                  ],
                ),
              ),
             // SizedBox(height: 2.h,),

             Expanded(
               child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                     BlocBuilder<SearchSuggestionBloc, SearchSuggestionState>(
                        builder: (BuildContext context, SearchSuggestionState state) {
                          if(state is SearchSuggestionLoaded){
                            final videoSuggestion = state.searchSuggestionData.first.data!.videoSuggestions!.length;
                            final channelSuggestion = state.searchSuggestionData.first.data!.channelSuggestions!.length;
                            final video = state.searchSuggestionData.first.data!.videoSuggestions;
                            final channel = state.searchSuggestionData.first.data!.channelSuggestions;
                            return isSearch ? Column(
                              children: [
                                video!.isNotEmpty ? ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: videoSuggestion,
                                    itemBuilder: (BuildContext context, index){
                                      final videoSearchSuggestion = state.searchSuggestionData.first.data!.videoSuggestions![index];
                                      return InkWell(
                                        onTap: () {

                                          context.read<SearchDataBloc>().add(
                                              SearchDataRequest(
                                                  searchQuery: videoSearchSuggestion));
                                          GoRouter.of(context).pushNamed(
                                            'searchDataPage',
                                            pathParameters: {
                                              'searchQuery' : videoSearchSuggestion
                                            }
                                          );
                                        },

                                        child: ListTile(
                                          leading: const Icon(HeroiconsOutline.magnifyingGlass, size: 22,),
                                          title: Text(
                                            videoSearchSuggestion,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: fontFamily
                                            ),
                                          ),
                                          trailing: const Icon(HeroiconsOutline.arrowUpRight, size: 20,),
                                        ),
                                      );
                                    }
                                ) : Container(),

                                channel!.isNotEmpty ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: channelSuggestion,
                                    itemBuilder: (BuildContext context, index){

                                      final channelSearchSuggestion = state.searchSuggestionData.first.data!.channelSuggestions![index];
                                      return InkWell(
                                        onTap: (){
                                          context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: channelSearchSuggestion));
                                          GoRouter.of(context).pushNamed(
                                              'searchDataPage',
                                              pathParameters: {
                                                'searchQuery' : channelSearchSuggestion
                                              }
                                          );
                                        },
                                        child: ListTile(
                                          leading: const Icon(HeroiconsOutline.magnifyingGlass, size: 22,),
                                          title: Text(
                                            channelSearchSuggestion,
                                            style: const TextStyle(
                                                fontFamily: fontFamily
                                            ),
                                          ),
                                          trailing: const Icon(HeroiconsOutline.arrowUpRight, size: 20,),
                                        ),
                                      );
                                    }
                                ) : Container(),

                              ],
                            ) : Container();

                          } else if(state is SearchSuggestionLoading){
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
