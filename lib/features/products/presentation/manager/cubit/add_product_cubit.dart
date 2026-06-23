import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();

  @override
  Future<void> close() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    subTitleController.dispose();
    return super.close();
  }
}
