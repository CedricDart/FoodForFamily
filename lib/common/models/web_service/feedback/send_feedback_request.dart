import 'package:food_for_family/common/models/base/serializable.dart';

class SendFeedbackRequest extends Serializable {
  String? sdpId;
  String? mode;
  String? productType;
  int? rating;
  String? comment;

  SendFeedbackRequest(
      {this.sdpId, this.mode, this.productType, this.rating, this.comment});

  @override
  SendFeedbackRequest fromJson(Map<String, dynamic> json) {
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sdpId'] = sdpId;
    data['mode'] = mode;
    data['productType'] = productType;
    data['rating'] = rating;
    data['comment'] = comment;
    return data;
  }
}
