import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/core/utils/pick_image_utils.dart';

class ProfileDetailController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? image;
  String? imageURL;

  Future changeImageProfile() async {
    final imageFile = await pickImage();
    if (imageFile != null) image = imageFile;
    Log.loggerInformation("Image: $image");
  }

  
}
