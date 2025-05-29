class ModelDetection {
  final String? label;

  final String? image;

  ModelDetection({this.label, this.image});

  factory ModelDetection.fromJson(Map<String, dynamic> json) {
    return ModelDetection(
      label: json['label'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'image': image,
    };
  }
}
