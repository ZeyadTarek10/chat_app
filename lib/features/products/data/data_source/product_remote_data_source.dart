import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/products/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductRemoteDataSource {
  Future<void> addProduct(ProductModel product);
  Stream<List<ProductModel>> getProduct();
  Future<void> updateProduct(ProductModel post);
  Future<void> deleteProduct(String postId);
  Future<void> favProduct(String postId, String userId, bool isLiked);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  ProductRemoteDataSourceImpl();

  @override
  Future<void> addProduct(ProductModel product) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.id)
          .set(product.toJson());
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }

  @override
  Stream<List<ProductModel>> getProduct() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('time', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    });
  }
  
  @override
  Future<void> deleteProduct(String postId) async{
   try {
      await FirebaseFirestore.instance.collection('products').doc(postId).delete();
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }
  
  @override
  Future<void> favProduct(String postId, String userId, bool isLiked) async{
    final docRef = FirebaseFirestore.instance.collection('products').doc(postId);

    try {
      if (isLiked) {
        await docRef.update({
          'fav_by': FieldValue.arrayRemove([userId]),
          'fav_count': FieldValue.increment(-1),
        });
      } else {
        await docRef.update({
          'fav_by': FieldValue.arrayUnion([userId]),
          'fav_count': FieldValue.increment(1),
        });
      }
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }
  
  @override
  Future<void> updateProduct(ProductModel post) async{
     try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(post.id)
          .update(post.toJson());
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }
}
