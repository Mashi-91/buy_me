import 'package:buy_me/const/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxFormFieldWithErrorMessage extends FormField<bool> {
  final bool isChecked;
  String error;
  final void Function(bool?) onChanged;

  CheckBoxFormFieldWithErrorMessage({
    Key? key,
    required this.isChecked,
    required this.onChanged,
    required FormFieldValidator<bool>? validator,
    required this.error,
  }) : super(
          key: key,
          initialValue: isChecked,
          validator: validator,
          builder: (FormFieldState<bool> state) {
            return Column(
              children: [
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: onChanged,
                        isError: true,
                        activeColor: AppColors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            children: [
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: const BoxConstraints(minHeight: 16.0),
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Text(
                        (error.isNotEmpty) ? ' * $error' : '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Get.theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
}
