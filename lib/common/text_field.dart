import 'package:brillzconnect/common/color.dart';
import 'package:brillzconnect/common/text_style.dart';
import 'package:flutter/material.dart';

class CustomBoxTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? errorWidget;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final bool readOnly;
  final double? bottomInset;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final String? label;
  const CustomBoxTextField({
    super.key,
    this.hintText = "",
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorWidget,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly = false,
    this.bottomInset,
    this.focusNode,
    this.prefix,
    this.fillColor,
    this.hintColor,
    this.textColor,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomInset ?? 16),
      // height: 52,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? "",
            style: getPlusJakartaSans(
                textColor: AppColors.appBlack,
                fontsize: 14,
                fontweight: FontWeight.w500),
          ),
          const SizedBox(height: 9),
          SizedBox(
            height: 55,
            child: TextFormField(
              validator: validator ??
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid input';
                    } else {
                      return null;
                    }
                  },
              onTap: onTap,
              readOnly: readOnly,
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              onChanged: onChanged,
              focusNode: focusNode,
              style: getPlusJakartaSans(
                  textColor: AppColors.appBlack,
                  fontsize: 14,
                  fontweight: FontWeight.w500),
              maxLines: maxLines,
              maxLength: maxLength,
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: getPlusJakartaSans(
                    textColor: const Color(0xffB0BEC5),
                    fontsize: 12,
                    fontweight: FontWeight.w500),
                error: errorWidget,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                prefixIcon: prefixIcon,
                suffix: suffixIcon,
                prefix: prefix,
                filled: true,
                fillColor: fillColor ?? Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: AppColors.appGreen,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Color(0xffE0E0E0),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Color(0xffE0E0E0),
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: AppColors.appDangerButtonRed,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.validator,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomBoxTextField(
      controller: widget.controller,
      label: widget.label,
      hintText: widget.hintText ?? 'Enter your password',
      obscureText: !_isPasswordVisible, // Toggles visibility
      validator: widget.validator,
      suffixIcon: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible; // Toggle state
          });
        },
      ),
    );
  }
}
