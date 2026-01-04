import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keeper/core/controllers/clients_controller.dart';
import 'package:keeper/pages/home/screens/addClient/widgets/Input.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class AddClient extends StatelessWidget {
  AddClient({super.key});

  final controller = Get.put(ClientsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: AppIcon(Icons.arrow_back),
        ),
        title: Text(
          "Add client",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              "Client Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Input(
              label: "Client name:",
              onChanged: (value) {
                controller.updateField("name", value);
              },
              type: TextInputType.text,
            ),

            Input(
              label: "Address:",
              onChanged: (value) {
                controller.updateField("address", value);
              },
              type: TextInputType.multiline,
            ),

            Input(
              label: "Email Address:",
              onChanged: (value) {
                controller.updateField("email", value);
              },
              type: TextInputType.emailAddress,
            ),

            Input(
              label: "Phone Number:",
              onChanged: (phoneNumber) {
                controller.updateField("phone", phoneNumber);
              },
              type: TextInputType.phone,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(7),
              ),

              child: Text(
                "Ensure all details are filled before Saving or most especially the essential fields such as Name, Address and Phone number",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(20),
        height: Get.height * 0.1,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Obx(() {
            return GestureDetector(
              onTap: () => controller.addClient(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: controller.loading.value
                      ? Colors.grey
                      : Color(0xFF1E90FF),
                ),
                child: Center(
                  child: controller.loading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Add client",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
