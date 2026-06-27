import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.userId,
    required super.productImage,
    super.productGallaryImage = const [],
    required super.productTitle,
    super.type,
    required super.price,
    super.discription,
    super.time, 
    super.favCount,
    required super.favBy,
    super.isAvailable,
  });

  ProductModel copyWith({
    String? id,
    String? userId,
    String? productImage,
    List<String>? productGallaryImage,
    String? productTitle,
    String? type,
    String? price,
    String? discription,
    DateTime? time,
    int ? favCount,
    List<String>? favBy,
    bool? isAvailable,

  }) {
    return ProductModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productImage: productImage ?? this.productImage,
      productGallaryImage: productGallaryImage ?? this.productGallaryImage,
      productTitle: productTitle ?? this.productTitle,
      type: type ?? this.type,
      price: price?? this.price,
      discription: discription ?? this.discription,
      time: time ?? this.time, 
      favCount: favCount ?? this.favCount,
      favBy: favBy ?? this.favBy,
      isAvailable: isAvailable ?? this.isAvailable
    );
  }
  
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        userId: json['user_id'],
        productImage: json['product_image'],
        productGallaryImage: List<String>.from(json['product_gallary_image'] ?? []),
        productTitle: json['product_title'],
        type: json['type'] ?? '',
        price: json['price'] ?? 0,
        discription: json['discription'] ?? '',
        time: json['time'] is Timestamp
            ? (json['time'] as Timestamp).toDate()
            : DateTime.now(), 
        favCount: json['fav_count'] ?? 0,
        favBy: List<String>.from(json['fav_by'] ?? [],
        ),
        isAvailable: json['is_available'] ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        "user_id": userId,
        'product_image': productImage,
        'product_gallary_image': productGallaryImage,
        'product_title': productTitle,
        'type': type,
        'price': price,
        'discription': discription,
        'time': time ?? DateTime.now(),
        'fav_count': favCount,
        'fav_by': favBy,
        'is_available': isAvailable,
      };
}
