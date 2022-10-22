import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:the_baetles_chord_play/domain/model/video.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_block.dart';

void main() {
  group("Test VideoBlock widget", () {
    testWidgets(
      "VideoBlock_validVideo_presentVideoBlock",
      (WidgetTester tester) async {
        List<Video> videos = [
          Video(
            id: "379ohbQxHY4",
            thumbnailPath: "https://img.youtube.com/vi/379ohbQxHY4/0.jpg",
            title: "pH-1 - ZOMBIES | [DF LIVE]",
            genre: "hiphop",
            singer: "ph-1",
            tags: ['rap'],
            length: 188000,
            difficultyAvg: 2,
            playCount: 3524,
            sheetCount: 3,
            isInMyCollection: false,
          ),
          Video(
            id: "F0B7HDiY-10",
            thumbnailPath: "https://img.youtube.com/vi/F0B7HDiY-10/0.jpg",
            title: "IVE 아이브 'After LIKE' MV",
            genre: "hiphop",
            singer: "ive",
            tags: ['idol'],
            length: 180000,
            difficultyAvg: 3,
            playCount: 255245912,
            sheetCount: 3,
            isInMyCollection: false,
          ),
          Video(
            id: "KsznX5j2oQ0",
            thumbnailPath: "https://img.youtube.com/vi/KsznX5j2oQ0/0.jpg",
            title: "새소년 (SE SO NEON) '난춘(亂春) (NAN CHUN)' Official MV",
            genre: 'indi',
            singer: "새소년 SE SO NEON",
            tags: ['indi'],
            length: 250000,
            difficultyAvg: 1,
            playCount: 34,
            sheetCount: 3,
            isInMyCollection: false,
          ),
        ];

        List<String> formattedLengths = [
          "3:08",
          "3:00",
          "4:10",
        ];

        List<String> formattedPlayCounts = [
          "3,524회",
          "255,245,912회",
          "34회",
        ];

        for (int testCase = 0; testCase < videos.length; ++testCase) {
          Video video = videos[testCase];
          String formattedLength = formattedLengths[testCase];
          String formattedPlayCount = formattedPlayCounts[testCase];

          await mockNetworkImagesFor(() => tester.pumpWidget(
                MaterialApp(home: VideoBlock(video: video)),
              ));

          final titleFinder = find.text(video.title);
          final thumbnailFinder = find.image(
            NetworkImage(video.thumbnailPath),
          );
          final lengthFinder = find.text(formattedLength);
          final playCountFinder = find.text(formattedPlayCount);

          expect(titleFinder, findsOneWidget);
          expect(thumbnailFinder, findsOneWidget);
          expect(lengthFinder, findsOneWidget);
          expect(playCountFinder, findsOneWidget);
        }
      },
    );

    log("VideoBlock widget test complete");
  });
}
