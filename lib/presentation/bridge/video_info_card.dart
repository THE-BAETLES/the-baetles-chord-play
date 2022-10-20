import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/molecule/instrument_selector.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_summary.dart';

import '../../domain/model/instrument.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../../widget/molecule/collection_button.dart';

class VideoInfoCard extends StatelessWidget {
  final Video video;
  final void Function(Instrument?)? onChangeInstrument;
  final Widget collectionButton;

  VideoInfoCard({
    Key? key,
    required this.video,
    required this.collectionButton,
    this.onChangeInstrument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: const EdgeInsets.only(top: 15, right: 15, bottom: 20, left: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: VideoSummary(
                  video: video,
                  titleMaxLines: 3,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),
              ),
              Container(
                width: 2,
              ),
              collectionButton,
            ],
          ),
          const Divider(
            height: 29,
            thickness: 1,
            color: AppColors.grayE3,
          ),
          InstrumentSelector(
            instruments: ['Guitar', 'Piano'],
            onSelected: (int index) {
              if (index == InstrumentSelector.none) {
                onChangeInstrument?.call(null);
              } else {
                onChangeInstrument?.call(Instrument.values[index]);
              }
            },
          ),
        ],
      ),
    );
  }
}
