class Pojo {
  String? albumId;
  String? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Pojo({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  Pojo.fromJson(Map<String, dynamic> json) {
    albumId = json["albumId"].toString();
    id = json["id"].toString();
    title = json["title"];
    url = json["url"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}
