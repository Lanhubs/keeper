import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  

  final tabIndex = 0.obs;
  void changeIndex(int index){
    tabIndex.value =index;
  }
}