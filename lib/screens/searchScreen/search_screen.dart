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
import '../../config/colors.dart';
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
    _clearSearchSuggestions(); // Clear suggestions when disposing the widget
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clearSearchSuggestions() {
    context.read<SearchSuggestionBloc>().add(ClearSearchSuggestions());
  }

  // Modified to keep the search query but remove search results
  void _clearSearchResults() {
    setState(() {
      _showSuggestions = true;
      _showVideoPreviews = false;
    });
    // SearchController text is not cleared here, so the query remains
  }

  void _performSearch(String query) {
    setState(() {
      _currentQuery = query;
      _showSuggestions = false;
      _showVideoPreviews = true;
      _searchController.text = query;  // Set the query in the text field
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
                    onTap: () {
                      if (_showVideoPreviews) {
                        // If the user is viewing search results, clear the search results but keep the query
                        _clearSearchResults();
                      } else {
                        // If the user is viewing suggestions, pop the page
                        _clearSearchSuggestions();
                        GoRouter.of(context).pop();
                      }
                    },
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
                                videoSuggestion.isNotEmpty
                                    ? // Inside the search suggestion ListView.builder
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: videoSuggestion.length,
                                  itemBuilder: (BuildContext context, index) {
                                    final videoSearchSuggestion = videoSuggestion[index].keyword;
                                    return InkWell(
                                      onTap: () {
                                        _performSearch(videoSearchSuggestion);  // Perform search on tap of suggestion text
                                      },
                                      child: ListTile(
                                        leading: const Icon(HeroiconsOutline.magnifyingGlass, size: 22),
                                        title: Text(
                                          videoSearchSuggestion!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontFamily: fontFamily),
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            // Copy the suggestion to the text field
                                            setState(() {
                                              _searchController.text = videoSearchSuggestion;
                                              _searchController.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _searchController.text.length),
                                              );
                                              _focusNode.requestFocus();  // Focus back on the text field

                                              // Trigger search suggestions based on the copied suggestion
                                              context.read<SearchSuggestionBloc>().add(
                                                SearchSuggestionRequest(searchQuery: videoSearchSuggestion),
                                              );

                                              // Show the suggestions
                                              _showSuggestions = true;
                                              _showVideoPreviews = false;
                                            });
                                          },
                                          child: const Icon(HeroiconsOutline.arrowUpLeft, size: 20),  // Trailing icon for copying
                                        ),
                                      ),
                                    );
                                  },
                                )

                                    : Container(),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    if (_showVideoPreviews)
                      BlocBuilder<SearchDataBloc, SearchDataState>(
                        builder: (BuildContext context, SearchDataState state) {
                          if (state is SearchDataLoaded) {
                            return Column(
                              children: [
                                state.searchData.first.data!.videos!.isNotEmpty
                                    ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 8.h),
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
                                        GoRouter.of(context).pushNamed('channelProfilePage',
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
                                )
                                    : Container(),
                                state.searchData.first.data!.channels!.isNotEmpty
                                    ? ListView.builder(
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
                                )
                                    : Container(),
                              ],
                            );
                          }
                          else if (state is SearchDataLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
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



