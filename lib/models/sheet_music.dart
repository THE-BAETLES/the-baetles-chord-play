import 'chord_block.dart';


class SheetMusic {
  final int bpm;
  final List<ChordBlock> chords;

  SheetMusic(this.bpm, this.chords);

  // VideoItemModel.fromJson(Map<String, dynamic> json) {
  //   title = json['title'];
  //   videoId = json['videoId'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['title'] = this.title;
  //   data['videoId'] = this.videoId;
  //   return data;
  // }
}