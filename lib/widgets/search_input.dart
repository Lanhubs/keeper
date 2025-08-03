import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class SearchInput extends GetView {
  final void Function(String)? onChanged;
  final void Function()? onFilterTap;
  final String? hintText;
 const  SearchInput({super.key, 
   
    this.onChanged,
    this.onFilterTap,
    this.hintText,
   });
  @override
  Widget build(BuildContext context){
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width * 0.8,
                    child: SearchBar(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                      ),
                      leading: Icon(Icons.search, color: Colors.grey, size: 20),
                      hintText:hintText?? "Search",
                      hintStyle: WidgetStateProperty.all(
                        TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      onChanged: onChanged,
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 10),
                      ),
                      elevation: WidgetStateProperty.all(0.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: onFilterTap,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E90FF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        HugeIcons.strokeRoundedFilterVertical,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              );
  }
}