import 'package:tafaling/features/post/data/models/attachment_model.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.userId,
    super.body,
    required super.privacyId,
    required super.createdBy,
    required UserModel super.creator,
    required List<AttachmentModel> super.attachments,
    required super.likeCount,
    super.createdAt,
    super.expireDate,
    super.isLiked,
    required super.shareDetails,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["postId"] as int,
      userId: json["userId"] as int,
      body: json["body"] as String?,
      privacyId: json["privacyId"] as int,
      createdBy: json["createdBy"] as int,
      creator: UserModel.fromJson(json["creator"] ?? {}),
      attachments:
          (json["attachments"] as List<dynamic>?)
              ?.map(
                (item) =>
                    AttachmentModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      likeCount: json["likeCount"] ?? 0,
      createdAt: json["createdAt"] as String?,
      expireDate: json["expireDate"] as String?,
      isLiked: (json["isLiked"] ?? 0) == 1, // Convert int to bool
      shareDetails:
          (json["shareDetails"] as List<dynamic>?)
              ?.map((item) => PostModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "postId": id,
      "userId": userId,
      "body": body,
      "privacyId": privacyId,
      "createdBy": createdBy,
      "creator": (creator as UserModel).toJson(),
      "attachments":
          attachments.map((e) => (e as AttachmentModel).toJson()).toList(),
      "likeCount": likeCount,
      "createdAt": createdAt,
      "expireDate": expireDate,
      "isLiked": isLiked ? 1 : 0, // Convert bool to int
    };
  }
}
