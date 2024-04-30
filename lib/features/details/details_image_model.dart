import 'dart:convert';

class DetailsImageModel {
  String url;
  String uuid;
  DetailsImageModel({
    required this.url,
    required this.uuid,
  });

  DetailsImageModel copyWith({
    String? url,
    String? uuid,
  }) {
    return DetailsImageModel(
      url: url ?? this.url,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'uuid': uuid,
    };
  }

  factory DetailsImageModel.fromMap(Map<String, dynamic> map) {
    return DetailsImageModel(
      url: map['url'] ?? '',
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailsImageModel.fromJson(String source) =>
      DetailsImageModel.fromMap(json.decode(source));

  @override
  String toString() => 'DetailsImageModel(url: $url, uuid: $uuid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DetailsImageModel && other.url == url && other.uuid == uuid;
  }

  @override
  int get hashCode => url.hashCode ^ uuid.hashCode;
}
