part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}


final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductEntity> product;
  ProductLoaded(this.product);
}
final class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
final class ProductActionSuccess extends ProductState {
  final String message;

  ProductActionSuccess({required this.message});
} 

final class ProductMainImageUploading extends ProductState {}
final class ProductMainImageUploaded extends ProductState {}

final class ProductGalleryImageUploading extends ProductState {}
final class ProductGalleryImageUploaded extends ProductState {}
