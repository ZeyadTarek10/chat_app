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
      default:
        return message ?? "send_a_message".tr(); 
    }
  }
  
}
