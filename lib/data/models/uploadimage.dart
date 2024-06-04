class UploadImage {
  String? status;
  List<String>? data;
  String? message;

  UploadImage({this.status, this.data, this.message});

  UploadImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? List<String>.from(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
