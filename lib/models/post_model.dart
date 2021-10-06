class PostModel {
  late String postId;
  late String postUserId;
  late String postUserName;
  late String postUserImage;
  late String? postText;
  late String dateTime;
  late String? postImage;
  late List<String>? postHashTags;
  late List<UserComment>? postComments;
  late int postLikes;
  late int postCommentsCount;

// create constructor
  PostModel({
    this.postId = '',
    required this.postUserId,
    required this.postUserName,
    required this.postUserImage,
    required this.dateTime,

    // start from 0
    this.postLikes = 0,
    this.postCommentsCount = 0,

    // can be null
    this.postText,
    this.postImage,
    this.postHashTags,
    this.postComments,
  });

  // convert the map to model
  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postUserId = json['post_user_id'];
    postUserName = json['post_user_name'];
    postUserImage = json['post_user_image'];
    dateTime = json['date_time'];
    postText = json['post_text'];
    postHashTags = json['post_hash_tags'];
    postComments = json['post_comments'];
    postImage = json['post_image'];
    postLikes = json['post_likes'];
    postCommentsCount = json['post_comments_count'];
  }

  // convert data to map
  Map<String, dynamic> toMap() {
    return {
      'post_id': postId,
      'post_user_id': postUserId,
      'post_user_name': postUserName,
      'post_user_image': postUserImage,
      'date_time': dateTime,
      'post_image': postImage,
      'post_text': postText,
      'post_hash_tags': postHashTags,
      'post_comments': postComments,
      'post_likes': postLikes,
      'post_comments_count': postCommentsCount,
    };
  }

  static PostModel get(String postId, List<PostModel> posts) {
    late PostModel postModel;
    posts.forEach((element) {
      if (element.postId == postId) {
        postModel = element;
      }
    });
    return postModel;
  }
}

class UserComment {
  late String id;
  late String text;
  late String datTime;

  UserComment(this.id, this.text, this.datTime);

  UserComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    datTime = json['date_time'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'date_time': datTime,
    };
  }
}
