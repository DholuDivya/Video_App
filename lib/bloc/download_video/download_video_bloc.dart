import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
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

      // bool hasPermission = await requestStoragePermission(context);
      // if (!hasPermission) return;

      var dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/${event.videoTitle}.mp4";

      await dio.download(
        event.videoSource,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('Video is downloading....');
            double progress = received / total;
            emit(DownloadVideoInProgress(progress: progress));
          }
        },
      );

      if (Platform.isAndroid) {
        final externalDir = Directory('/storage/emulated/0/Download');
        if (!await externalDir.exists()) {
          await externalDir.create(recursive: true);
        }
        String newFilePath = "${externalDir.path}/${event.videoSlug}.mp4";
        final file = File(filePath);
        await file.copy(newFilePath);
        print("Video saved to Downloads folder: $newFilePath");

        // Optionally, delete the original file from internal storage
        await file.delete();

        // Update filePath to the new location
        filePath = newFilePath;

      } else if (Platform.isIOS) {
        // Save the video to the Photos library on iOS
        final asset = await PhotoManager.editor.saveVideo(File(filePath));
        print('Video saved to photo library: $filePath');
      }


      print('Downloaded file :::   $filePath');
      print('Downloaded Video videoId ::  ${event.videoId}');
      print('Downloaded Video videoSlug ::  ${event.videoSlug}');
      print('Downloaded Video videoType ::  ${event.videoType}');
      print('Downloaded Video filePath ::  ${filePath}');
      print('Downloaded Video videoThumbnail ::  ${event.videoThumbnail}');
      print('Downloaded Video videoTitle ::  ${event.videoTitle}');
      print('Downloaded Video videoDescription ::  ${event.videoDescription}');
      print('Downloaded Video videoHashtag ::  ${event.videoHashtag}');
      print('Downloaded Video videoCreateAtHuman ::  ${event.videoCreateAtHuman}');
      print('Downloaded Video videoDuration ::  ${event.videoDuration}');
      print('Downloaded Video videoViews ::  ${event.videoViews}');
      print('Downloaded Video videoCategory ::  ${event.videoCategory}');
      print('Downloaded Video videoComments ::  ${event.videoComments}');
      print('Downloaded Video videoLikes ::  ${event.videoLikes}');
      print('Downloaded Video channelLogo ::  ${event.channelLogo}');
      print('Downloaded Video channelName ::  ${event.channelName}');
      print('Downloaded Video contentType ::  ${event.contentType}');

      var box = await Hive.openBox<DownloadedVideoModel>('videos');
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
      emit(DownloadVideoSuccess());
    } catch (e) {
      emit(DownloadVideoFailure(error: e.toString()));
    }
  }



  Future<bool> requestStoragePermission(BuildContext context) async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission is required to save the file.')),
        );
        return false;
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      if (status.isGranted) {
        return true;
      } else if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo library permission is required to save the file.')),
        );
        return false;
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
    }
    return false;
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