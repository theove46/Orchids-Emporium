// ignore_for_file: must_be_immutable

library input_form_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:orchids_emporium/core/theme/palette.dart';

const Color _borderColor = Color(0xFFD9D9D9);
const Color _fillColor = Colors.white;
const double _height = 50.0;
const double _bottomMargin = 20;

const TextStyle _labelTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle _style = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle _errorTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

class InputFormField extends StatefulWidget {
  InputFormField({
    Key? key,
    required this.textEditingController,
    this.keyboardType,
    this.autocorrect = true,
    this.style = _style,
    this.hintText,
    this.hintTextStyle,
    this.label,
    this.labelText,
    this.labelTextStyle = _labelTextStyle,
    this.errorTextStyle = _errorTextStyle,
    this.floatingLabelBehavior,
    this.suffix,
    this.prefix,
    this.password,
    this.obscureText,
    this.obscuringCharacter = '•',
    this.validator,
    this.enableDefaultValidation = false,
    this.height = _height,
    this.contentPadding,
    this.errorPadding,
    this.bottomMargin = _bottomMargin,
    this.borderType = BorderType.outlined,
    this.borderRadius,
    this.borderColor = _borderColor,
    this.fillColor = _fillColor,
    this.errorColor = Colors.red,
    this.cursorColor = Colors.green,
    this.datePicker = false,
    this.enabled = true,
    this.onChanged,
    this.maxLength,
    this.textAlign = TextAlign.start,
  })  : assert(obscuringCharacter.isNotNull && obscuringCharacter.length == 1),
        assert(
          !(password.isNotNull && obscureText.isNotNull),
          """Both can't be used at the same time. Use isPasswordTrue to handle password visibility internally. To handle externally use obscureText""",
        ),
        super(key: key);

  final TextEditingController textEditingController;

  /// The style to use for the text being edited.
  final TextStyle? style;

  final Widget? label;

  /// Optional text that describes the input field.
  final String? labelText;

  /// If null, defaults to a value derived from the base TextStyle for the input
  /// field and the current Theme.
  final TextStyle? labelTextStyle;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// If null, defaults to a value derived from the base TextStyle for the input
  /// field and the current Theme.
  final TextStyle? hintTextStyle;

  /// WARNING: This is custom text style for error widget
  final TextStyle? errorTextStyle;

  /// If null, InputDecorationTheme.floatingLabelBehavior will be used.
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Optional widget to place on the line before the input.
  final Widget? prefix;

  /// Optional widget to place on the line after the input.
  final Widget? suffix;

  /// Treats the field as password field.
  ///
  /// Handles visibility toggle by default.
  /// Supports icon customization
  final EnabledPassword? password;

  /// Obscure text, helps with password visibility toggle.
  final bool? obscureText;

  /// Default '•'.
  final String obscuringCharacter;

  /// Signature for validating a form field.
  ///
  /// Returns an error string to display if the input is invalid, or null
  /// otherwise.
  final String? Function(String?)? validator;

  /// Enables default validation. Takes care of null and empty value check if
  /// enabled
  final bool enableDefaultValidation;

  /// If null, defaults to 48px in order to comply with Material spec's minimum
  /// interactive size guideline
  final double? height;

  /// The padding for the input decoration's container. Defaults to 10px horizontally
  /// and 10px vertically
  final EdgeInsetsGeometry? contentPadding;

  /// The padding for the input error text, defaults to 10px from left and
  /// 5px from top
  final EdgeInsetsGeometry? errorPadding;

  /// Bottom margin to create space between intermediate element
  final double? bottomMargin;

  /// Determines the border type. Border can be [BorderType.outlined] or
  /// [BorderType.bottom] or [BorderType.none].
  ///
  /// Defaults to [BorderType.outlined].
  /// If you want to disable border use [BorderType.none]
  final BorderType borderType;

  /// The color for the container border
  final Color borderColor;

  /// If non-null, the corners of this box are rounded by this [BorderRadius]
  /// A [borderRadius] can only be given for a uniform Border.
  ///
  /// Default border radius is 8px
  final BorderRadiusGeometry? borderRadius;

  /// The color for the container background
  final Color? fillColor;

  /// The color for the error, applies to everywhere that reacts to input
  /// validation error
  final Color errorColor;

  /// The color for the cursor
  final Color cursorColor;

  /// Decides whether the TextField is a DatePicker or not
  final bool datePicker;

  /// The type of information for which to optimize the text input control.
  final TextInputType? keyboardType;

  /// Decides whether the text field is editable or not
  final bool enabled;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  late Function(String)? onChanged;

  final int? maxLength;

  final TextAlign textAlign;

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  bool isError = false;
  bool _showPassword = true;
  String? feedback;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(_clearError);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_clearError);
    super.dispose();
  }

  void _clearError() {
    if (isError) {
      setState(() {
        isError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isOutlinedBorder = widget.borderType == BorderType.outlined;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) widget.label!,
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: widget.borderRadius ??
                _getDefaultBorderRadius(isOutlinedBorder),
            border: _getBorder(isOutlinedBorder),
          ),
          child: TextFormField(
            onTap: widget.datePicker
                ? () async {
                    await _selectDate(context);
                  }
                : null,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength),
            ],
            textAlign: widget.textAlign,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            enabled: widget.enabled,
            controller: widget.textEditingController,
            textAlignVertical: TextAlignVertical.center,
            autocorrect: widget.autocorrect,
            style: widget.style,
            cursorColor: widget.cursorColor,
            keyboardType: widget.keyboardType,
            maxLines: 1,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: widget.contentPadding ?? _defaultContentPadding(),
              labelText: widget.labelText,
              labelStyle: widget.labelTextStyle,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              floatingLabelBehavior: widget.floatingLabelBehavior,

              /// Error text style fontSize is set to 0.01 to hide error text
              /// completely for custom error handling
              errorStyle: const TextStyle(fontSize: 0.01),

              /// Borders are intentionally disabled
              border: InputBorder.none,
              prefixIcon: widget.prefix,
              suffixIcon: widget.datePicker
                  ? _calendarIcon()
                  : widget.suffix ??
                      (widget.password.isNotNull
                          ? _visibilityButton(widget.password!)
                          : _suffixPrefixPlaceHolder()),
            ),
            obscureText: widget.password.isNotNull
                ? _showPassword
                : widget.obscureText ?? false,
            obscuringCharacter: widget.obscuringCharacter,
            onChanged: (String? v) {
              if (isError) {
                setState(() => isError = false);
              }
              widget.onChanged?.call(v!);
            },
            validator: widget.validator.isNotNull
                ? (_) {
                    feedback =
                        widget.validator!(widget.textEditingController.text);
                    if (feedback.isNotNull) {
                      setState(() => isError = true);
                    }
                    return feedback;
                  }
                : (String? v) {
                    /// Default validation. Fields can't be empty. If you want to disable it
                    /// change disableDefaultValidation
                    if (widget.enableDefaultValidation && v.isNullOrEmpty()) {
                      setState(() => isError = true);
                      feedback = "Required";

                      return feedback;
                    }
                    return null;
                  },
          ),
        ),
        if (isError && feedback.isNotNull)
          Padding(
            padding: widget.errorPadding ??
                const EdgeInsets.only(
                  left: 10.0,
                  top: 3,
                ),
            child: Text(
              feedback!,
              style: widget.errorTextStyle ??
                  const TextStyle(
                    color: Colors.red,
                  ),
            ),
          ),
        if (widget.bottomMargin.isNotNull)
          SizedBox(height: isError ? 10 : widget.bottomMargin)
      ],
    );
  }

  Widget? _suffixPrefixPlaceHolder() => const SizedBox.shrink();

  Border? _getBorder(bool isOutlinedBorder) {
    return widget.borderType == BorderType.none
        ? null
        : isOutlinedBorder
            ? Border.all(color: _getBorderColor())
            : Border(bottom: BorderSide(color: _getBorderColor()));
  }

  BorderRadius? _getDefaultBorderRadius(bool isOutlinedBorder) =>
      isOutlinedBorder || widget.fillColor.isNotNull
          ? BorderRadius.circular(8)
          : null;

  Color _getBorderColor() => isError ? widget.errorColor : widget.borderColor;

  EdgeInsets _defaultContentPadding() {
    return const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    );
  }

  IconButton _visibilityButton(EnabledPassword password) {
    return IconButton(
      onPressed: () {
        setState(() => _showPassword = !_showPassword);
      },
      icon: _showPassword
          ? password.hidePasswordIcon ??
              const Icon(
                Icons.visibility_off,
                color: Palette.greenColor,
              )
          : password.showPasswordIcon ??
              const Icon(
                Icons.visibility,
                color: Palette.greenColor,
              ),
      splashColor: Colors.transparent,
    );
  }

  Widget _calendarIcon() {
    return const Icon(
      Icons.calendar_month_rounded,
      color: Colors.green,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.textEditingController.text == ""
          ? _selectedDate
          : DateFormat('MM/dd/yyyy').parse(widget.textEditingController.text),
      initialDatePickerMode: DatePickerMode.year,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      confirmText: "Select",
      cancelText: "Cancel",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.green),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green.shade800, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        widget.textEditingController.text =
            DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }
}

class EnabledPassword {
  EnabledPassword({
    this.showPasswordIcon,
    this.hidePasswordIcon,
  });

  final Widget? showPasswordIcon;
  final Widget? hidePasswordIcon;
}

enum BorderType { outlined, bottom, none }

extension _GenericExtension<T> on T? {
  bool get isNotNull => this != null;
}

extension _StringExtension on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
