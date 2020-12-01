class HashtagDTO {
  final int hashTagId;
  final String tagName;
  HashtagDTO._({this.hashTagId, this.tagName});
  factory HashtagDTO.fromJson(Map<String, dynamic> json) {
    return new HashtagDTO._(
      hashTagId: json['hashTagId'],
      tagName: json['tagName'],
    );
  }
  Map toJson() => {
        'hashTagId': hashTagId,
        'tagName': tagName,
      };
}
