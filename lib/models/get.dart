import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  final counter = 0.obs;

  @override
  increment() {
    counter.value++;
    print('Counter: ${counter.value}');
    Get.snackbar('GetX Snackbar', 'Increase to ${counter.value} !',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        duration: const Duration(milliseconds: 600));
  }
}
