import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:easy_localization/easy_localization.dart';

extension MessageEntityExtension on MessageEntity {
  MessageEntity get toReplyDisplay {
    if (type == "image") {
      return copyWith(message: "🖼 ${'photo'.tr()}");
    } else if (type == "location") {
      return copyWith(message: "📍 ${'location'.tr()}");
    } else if (type == "contact") {
      return copyWith(message: "👤 ${'contact'.tr()}");
    } else if (type == "post_share") {
      return copyWith(message: "🔄 ${'shared_post'.tr()}");
    } else if (type == "story_reply") {
      return copyWith(message: "story_reply".tr());
    } else if (type == "product_share") {
      return copyWith(message: "product_share".tr());
    }
    return this;
  }

  String get typeText {
    switch (type) {
      case "image":
        return "🖼 ${'photo'.tr()}";
      case "location":
        return "📍 ${'location'.tr()}";
      case "contact":
        return "👤 ${'contact'.tr()}";
      case "post_share":
        return "🔄 ${'shared_post'.tr()}";
      case "story_reply":
        return "story_reply".tr();
      case "product_share":
        return "product_share".tr();
      default:
        return message ?? "send_a_message".tr();
    }
  }
}
