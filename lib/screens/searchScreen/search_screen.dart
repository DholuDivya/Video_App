import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/Utils/Widgets/video_container.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_bloc.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_event.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // SpeechToText _speechToText = SpeechToText();
  // String _lastWord = '';
  // bool _speechEnabled = false;
  TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add a listener to the focus node to detect when the field loses focus
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // The field lost focus, so the keyboard was dismissed
        callYourApiFunction();  // Replace with your API call
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void callYourApiFunction() {
    final searchQuery = _searchController.text;
    context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
    print("API called after dismissing keyboard.");
  }

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.h,
                    left: 10.w,
                    right: 10.w
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
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
                            height: 30,
                            width: 30,
                            // color: Colors.red,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: (){
            
                                final searchQuery = _searchController.text;
                                context.read<SearchDataBloc>().add(SearchDataRequest(searchQuery: searchQuery));
                              },
                              child: Center(
                                child: Icon(HeroiconsOutline.magnifyingGlass),
                              ),
                            ),
                          )
                    ],
                  ),
                ),
            
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      BlocBuilder<SearchDataBloc, SearchDataState>(
                        builder: (BuildContext context, SearchDataState state) {
                          if(state is SearchDataLoaded){
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.searchData.first.data!.videos!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final searchData = state.searchData.first.data!.videos![index];
                                final totalSeconds = searchData.duration;
                                final foramttedDuration = formatDuration(totalSeconds!);
                                return VideoListItem(
                                    thumbnailUrl: searchData.thumbnail!,
                                    duration: foramttedDuration,
                                    title: searchData.title!,
                                    author: searchData.channel!.name!,
                                    views: searchData.views.toString(),
                                    uploadTime: searchData.createdAtHuman!
                                );
                              },
                            );
                          } else if(state is SearchDataLoading){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                )
            
              ],
            ),
          )
      ),

      // body: Padding(
      //   padding: EdgeInsets.only(
      //     top: 40
      //   ),
      //   child: ListTile(
      //     leading: InkWell(
      //       onTap: (){
      //         GoRouter.of(context).pop();
      //       },
      //       child: Container(
      //         height: 30,
      //         width: 30,
      //         // color: Colors.yellow,
      //         child: Center(
      //           child: Icon(Remix.arrow_left_line),
      //         ),
      //       ),
      //     ),
      //
      //     title: TextFormField(
      //       controller: _searchText,
      //       // maxLines: 2,
      //       autofocus: true,
      //       style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      //       decoration: InputDecoration(
      //         filled: true,
      //         fillColor: Theme.of(context).colorScheme.secondary,
      //         hintText: 'Search...',
      //         hintStyle: TextStyle(
      //             color: Theme.of(context).colorScheme.tertiary, fontSize: 14),
      //         border: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(25),
      //           borderSide: BorderSide.none,
      //         ),
      //         contentPadding: EdgeInsets.symmetric(
      //             horizontal: ScreenSize.screenWidth(context) * 0.03,
      //             vertical: ScreenSize.screenWidth(context) * 0.03),
      //       ),
      //     ),
      //
      //     trailing: Container(
      //       height: 30,
      //       width: 30,
      //       // color: Colors.red,
      //       child: Center(
      //         child: Icon(Icons.mic,),
      //       ),
      //     ),
      //   ),
      // ),

    );
  }
}

/*        TextFormField(
                controller: _searchText,
                // maxLines: 2,
                autofocus: true,
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.screenWidth(context) * 0.03,
                      vertical: ScreenSize.screenWidth(context)*0.03
                  ),
                ),
              ),
            ),


            IconButton(
                  onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
                  icon: Icon(
                    // _speechToText.isNotListening ? Icons.mic_off :
                    Icons.mic, size: 20,)
              )



 */
