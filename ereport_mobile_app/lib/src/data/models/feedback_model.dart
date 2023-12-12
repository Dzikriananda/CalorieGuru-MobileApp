class FeedBackModel {
  String uid;
  String feedback;
  int satisficationLevel;

  FeedBackModel({
    required this.uid,
    required this.feedback,
    required this.satisficationLevel
  });

  Map<String, dynamic> toJson() =>
      {
        'uid' : uid,
        'feedback': feedback,
        'satisficationLevel': satisficationLevel,
      };

}