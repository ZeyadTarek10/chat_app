class ProductEntity {
  final String id;
  final String userId;
  final String productImage;
  final List<String> productGallaryImage;
  final String productTitle;
  final String? type;
  final String price;
  final String? discription;
  final DateTime? time;
  final int? favCount;
  final List<String>? favBy;
  final bool isAvailable;

  ProductEntity(
      {required this.id,
      required this.userId,
      required this.productImage,
      required this.productGallaryImage,
      required this.productTitle,
      required this.type,
      required this.price,
      required this.discription, 
      this.time, 
      this.favCount, 
      this.favBy, 
      this.isAvailable = true,});
}
