import 'dart:async';

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:chat_app/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:chat_app/features/products/data/models/product_model.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/domain/use_cases/add_product_use_case.dart';
import 'package:chat_app/features/products/domain/use_cases/delete_product_use_case.dart';
import 'package:chat_app/features/products/domain/use_cases/fav_product_use_case.dart';
import 'package:chat_app/features/products/domain/use_cases/get_product_use_case.dart';
import 'package:chat_app/features/products/domain/use_cases/update_product_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final AddProductUseCase addProductUseCase;
  final GetProductUseCase getProductUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final FavProductUseCase favProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  ProductCubit(
      {required this.addProductUseCase,
      required this.getProductUseCase,
      required this.uploadImageUseCase,
      required this.updateProductUseCase,
      required this.favProductUseCase,
      required this.deleteProductUseCase})
      : super(ProductInitial());
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final AwesomeDrawerBarController appDrawerController = AwesomeDrawerBarController();
  StreamSubscription? _postsSubscription;
  bool isLocationLoading = false;
  Set<String> sentUserIds = {};

  List<ProductEntity> allProducts = [];
  XFile? selectedImage;
  String? uploadedImageUrl;
  List<String> uploudedGallaryImages = [];
  List<ProductEntity> searchedProducts = [];
  bool isSearching = false;
  bool isAvailable = true;
  bool isDescriptionExpanded = false;

  void toggleAvailability(bool value) {
    isAvailable = value;
    emit(ProductLoaded(List.from(allProducts)));
  }

  void resetProductData() {
    selectedImage = null;
    uploadedImageUrl = null;
    uploudedGallaryImages.clear();
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    subTitleController.clear();
    isAvailable = true;
    if (state is ProductLoaded) {
      emit(ProductLoaded(List.from(allProducts)));
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      isSearching = false;
      emit(ProductLoaded(List.from(allProducts)));
    } else {
      isSearching = true;
      searchedProducts = allProducts.where((product) {
        return product.productTitle
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            (product.type?.toLowerCase().contains(query.toLowerCase()) ??
                false);
      }).toList();
      emit(ProductLoaded(List.from(searchedProducts)));
    }
  }

  Future<void> fetchProduct() async {
    emit(ProductLoading());
    await _postsSubscription?.cancel();
    _postsSubscription = getProductUseCase().listen(
      (result) {
        result.fold(
          (failure) => emit(ProductError(failure.massage)),
          (posts) {
            allProducts = posts;
            emit(ProductLoaded(allProducts));
          },
        );
      },
    );
  }

  Future<void> createNewProduct() async {
    emit(ProductLoading());

    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isEmpty) {
      emit(ProductError("user_not_logged_in".tr()));
      return;
    }

    final newProduct = ProductEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      productImage: uploadedImageUrl!,
      productTitle: titleController.text,
      discription: descriptionController.text,
      productGallaryImage: uploudedGallaryImages,
      time: DateTime.now(),
      price: priceController.text,
      type: subTitleController.text,
      favCount: 0,
      favBy: [],
      isAvailable: isAvailable,
    );

    final result = await addProductUseCase(product: newProduct);
    result.fold(
      (failure) => emit(ProductError(failure.massage)),
      (_) {
        resetProductData();
        emit(ProductActionSuccess(message: 'product_added_successfully'.tr()));
      },
    );
  }

  Future<void> updateCurrentProduct(ProductEntity oldProduct) async {
    emit(ProductLoading());
    final updatedProduct = ProductEntity(
      id: oldProduct.id,
      userId: oldProduct.userId,
      productImage: uploadedImageUrl ?? oldProduct.productImage,
      productGallaryImage: uploudedGallaryImages,
      productTitle: titleController.text,
      price: priceController.text,
      time: oldProduct.time,
      discription: descriptionController.text,
      type: subTitleController.text,
      favCount: oldProduct.favCount,
      favBy: oldProduct.favBy,
      isAvailable: isAvailable,
    );

    final result = await updateProductUseCase(updatedProduct);
    result.fold(
      (failure) => emit(ProductError(failure.massage)),
      (_) {
        resetProductData();
        emit(
            ProductActionSuccess(message: 'product_updated_successfully'.tr()));
      },
    );
  }

  void initEditData(ProductEntity? product) {
    if (product != null) {
      titleController.text = product.productTitle;
      subTitleController.text = product.type ?? '';
      descriptionController.text = product.discription ?? "";
      priceController.text = product.price;
      uploadedImageUrl = product.productImage;
      isAvailable = product.isAvailable;
      uploudedGallaryImages = List.from(product.productGallaryImage);
      emit(ProductLoaded(List.from(allProducts)));
    } else {
      resetProductData();
    }
  }

  Future<void> deletePost(String postId) async {
    emit(ProductLoading());

    final result = await deleteProductUseCase(postId: postId);

    result.fold(
      (failure) => emit(
        ProductError(failure.massage),
      ),
      (_) {
        // allProducts.removeWhere((p) => p.id == postId);
        emit(ProductLoaded(List.from(allProducts)));
        emit(ProductActionSuccess(message: 'product_delete_successfully'.tr()));
      },
    );
  }

  Future<void> toggleLikePost(
      ProductEntity product, String currentUserId) async {
    final postIndex = allProducts.indexWhere((p) => p.id == product.id);
    if (postIndex == -1) return;

    final isfav = product.favBy!.contains(currentUserId);
    final updatedfavBy = List<String>.from(product.favBy!);

    isfav
        ? updatedfavBy.remove(currentUserId)
        : updatedfavBy.add(currentUserId);
    final updatedLikesCount = (product.favCount ?? 0) + (isfav ? -1 : 1);

    allProducts[postIndex] = (product as ProductModel).copyWith(
      favCount: updatedLikesCount,
      favBy: updatedfavBy,
    );

    emit(ProductLoaded(List.from(allProducts)));

    final result = await favProductUseCase(
      postId: product.id,
      userId: currentUserId,
      isLiked: isfav,
    );

    result.fold(
      (failure) {
        emit(ProductError(failure.massage));
      },
      (success) {},
    );
  }

  Future<void> uploadSelectedImage(XFile image) async {
    selectedImage = image;
    emit(ProductMainImageUploading());

    final imageResult = await uploadImageUseCase(image);
    imageResult.fold(
      (failure) => emit(ProductError(failure.massage)),
      (uploadModel) {
        uploadedImageUrl = uploadModel.photo;
        emit(ProductMainImageUploaded());
      },
    );
  }

  Future<void> pickAndUploadGalleryImages() async {
    final ImagePicker picker = ImagePicker();

    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      emit(ProductGalleryImageUploading());

      for (var image in images) {
        final imageResult = await uploadImageUseCase(image);

        imageResult.fold(
          (failure) {
            emit(ProductError(failure.massage));
            return;
          },
          (uploadModel) {
            uploudedGallaryImages.add(uploadModel.photo!);
          },
        );
      }

      emit(ProductGalleryImageUploaded());
    }
  }

  void removeGalleryImage(String imageUrl) {
    uploudedGallaryImages.remove(imageUrl);
    emit(ProductGalleryImageUploaded());
  }

  void toggleDescription() {
    isDescriptionExpanded = !isDescriptionExpanded;
    if (state is ProductLoaded) {
      emit(ProductLoaded(List.from(allProducts)));
    }
  }

  void resetDescription() {
    isDescriptionExpanded = false;
  }

  void markPostAsSent(String id) {
    sentUserIds.add(id);
    if (state is ProductLoaded) {
      emit(ProductLoaded(List.from(allProducts)));
    }
  }

  void clearSentUserIds() {
    sentUserIds.clear();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    subTitleController.dispose();
    _postsSubscription?.cancel();
    return super.close();
  }
}
