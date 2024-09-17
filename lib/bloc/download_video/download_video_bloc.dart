import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'download_video_event.dart';
import 'download_video_state.dart';
import '../../model/hive_model/downloaded_video_model/downloaded_video_model.dart';

class DownloadVideoBloc extends Bloc<DownloadVideoEvent, DownloadVideoState> {
  DownloadVideoBloc() : super(DownloadVideoInitial()) {
    on<DownloadVideoRequest>(_onDownloadVideoRequest);
  }

  Future<void> _onDownloadVideoRequest(
      DownloadVideoRequest event, Emitter<DownloadVideoState> emit) async {
    Dio dio = Dio();

    try {
      // Get the app's documents directory (internal storage)
      var dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/${event.videoTitle}.mp4";

      // Start downloading the file and report progress
      await dio.download(
        event.videoSource, // Assuming videoSource is the URL to download the video
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            emit(DownloadVideoInProgress(progress: progress)); // Emit progress state
          }
        },
      );
      print('Video is downloading....');
      // Once download completes, save the metadata to Hive
      var box = Hive.box<DownloadedVideoModel>('videos');
      var video = DownloadedVideoModel(
        videoId: event.videoId,
        videoSlug: event.videoSlug,
        videoType: event.videoType,
        videoSource: filePath, // Save the local file path
        videoThumbnail: event.videoThumbnail,
        videoTitle: event.videoTitle,
        videoDescription: event.videoDescription,
        videoHashtag: event.videoHashtag,
        videoCreateAtHuman: event.videoCreateAtHuman,
        videoDuration: event.videoDuration,
        videoViews: event.videoViews,
        videoCategory: event.videoCategory,
        videoComments: event.videoComments,
        videoLikes: event.videoLikes,
        channelLogo: event.channelLogo,
        channelName: event.channelName,
        contentType: event.contentType,
      );
      await box.add(video);
      print('Video is Downloaded!');
      emit(DownloadVideoSuccess()); // Emit success state
    } catch (e) {
      emit(DownloadVideoFailure(error: e.toString())); // Emit failure state on error
    }
  }
}



























// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:vimeo_clone/bloc/download_video/download_video_event.dart';
// import 'package:vimeo_clone/bloc/download_video/download_video_state.dart';
// import 'package:dio/dio.dart';
// import '../../model/hive_model/downloaded_video_model/downloaded_video_model.dart';
//
// class DownloadVideoBloc extends Bloc<DownloadVideoEvent, DownloadVideoState>{
//   DownloadVideoBloc() : super(DownloadVideoInitial()){
//     on<DownloadVideoRequest>(_onDownloadVideoRequest);
//   }
//
//   Future<void> _onDownloadVideoRequest(DownloadVideoRequest event, Emitter<DownloadVideoState> emit) async {
//     try{
//       emit(DownloadVideoInProgress());
//
//       downloadFile(
//           videoId: event.videoId,
//           videoSlug: event.videoSlug,
//           videoType: event.videoType,
//           videoSource: event.videoSource,
//           videoThumbnail: event.videoThumbnail,
//           videoTitle: event.videoTitle,
//           videoDescription: event.videoDescription,
//           videoHashtag: event.videoHashtag,
//           videoCreateAtHuman: event.videoCreateAtHuman,
//           videoDuration: event.videoDuration,
//           videoViews: event.videoViews,
//           videoCategory: event.videoCategory,
//           videoComments: event.videoComments,
//           videoLikes: event.videoLikes,
//           channelLogo: event.channelLogo,
//           channelName: event.channelName,
//           contentType: event.contentType
//       );
//
//       emit(DownloadVideoSuccess());
//     }catch(e){
//       emit(DownloadVideoFailure(error: e.toString()));
//     }
//   }
//
//
//   Future<void> downloadFile({
//     required String videoId,
//     required String videoSlug,
//     required String videoType,
//     required String videoSource,
//     required String videoThumbnail,
//     required String videoTitle,
//     required String videoDescription,
//     required String videoHashtag,
//     required String videoCreateAtHuman,
//     required String videoDuration,
//     required String videoViews,
//     required String videoCategory,
//     required String videoComments,
//     required String videoLikes,
//     required String channelLogo,
//     required String channelName,
//     required String contentType,
//   }) async {
//     Dio dio = Dio();
//
//     try {
//       // Get the app's documents directory (internal storage)
//       var dir = await getApplicationDocumentsDirectory();
//       print("App Documents path: ${dir.path}");
//
//       // File path to save in the app's internal files folder
//       String filePath = "${dir.path}/$videoSlug.mp4";
//
//       // Start downloading the file
//       await dio.download(
//         videoSource, filePath, // Assuming videoSource is the URL to download the video
//         onReceiveProgress: (rec, total) {
//           print("Rec: $rec , Total: $total");
//         },
//       );
//
//       // The video is now saved only in the app's files folder
//       print("Video saved to app's files folder: $filePath");
//
//       // Save the video metadata and file path to Hive
//       var box = Hive.box<DownloadedVideoModel>('videos');
//       var video = DownloadedVideoModel(
//         videoId: videoId,
//         videoSlug: videoSlug,
//         videoType: videoType,
//         videoSource: filePath, // Save the local file path
//         videoThumbnail: videoThumbnail,
//         videoTitle: videoTitle,
//         videoDescription: videoDescription,
//         videoHashtag: videoHashtag,
//         videoCreateAtHuman: videoCreateAtHuman,
//         videoDuration: videoDuration,
//         videoViews: videoViews,
//         videoCategory: videoCategory,
//         videoComments: videoComments,
//         videoLikes: videoLikes,
//         channelLogo: channelLogo,
//         channelName: channelName,
//         contentType: contentType,
//       );
//       await box.add(video);
//       print("Video metadata saved to Hive.");
//     } catch (e) {
//       print(e);
//     }
//   }
//
// }