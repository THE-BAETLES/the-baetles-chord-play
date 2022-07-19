class VideoItemModel {
  String? title;
  String? videoId;

  VideoItemModel({this.title, this.videoId});

  VideoItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['videoId'] = this.videoId;
    return data;
  }
}