// import 'package:flutter/material.dart';
//
// class CustomTextFieldPassword extends StatelessWidget {
//   final TextEditingController controller;
//   final bool isPasswordVisible;
//   final Function? validator;
//   final VoidCallback? onPressed;
//   final IconData? icon;
//
//   const CustomTextFieldPassword({
//     super.key,
//     required this.controller,
//     required this.isPasswordVisible,
//     this.validator,
//     this.onPressed,
//     this.icon
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: true && !isPasswordVisible,
//       // validator: validator,
//       decoration: InputDecoration(
//           suffixIcon: IconButton(
//               onPressed: onPressed,
//               icon: Icon(
//                   isPasswordVisible ? Icons.visibility : Icons.visibility_off
//               )
//           ),
//           filled: true,
//           // fillColor: Colors.grey[100],
//           labelText: "Password"
//       ),
//     );
//   }
// }
