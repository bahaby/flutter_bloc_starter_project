import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../core/generated/translations.g.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/extensions/build_context_extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.formControl,
    this.validationMessages,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.hasCounter = false,
    this.hintText = '',
    this.labelText = '',
    this.extraInfo = '',
    this.maxLines = 1,
    this.minLines,
    this.minLength,
    this.maxLength,
    this.isRequired = false,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.staticValue = '',
    this.showErrors = true,
    this.obscureText = false,
    this.textInputAction,
    this.onSubmitted,
  }) : assert(
          !hasCounter || maxLength != null,
          'Max length must be provided when counter is active.',
        );

  final Map<String, String> Function(FormControl<Object?>)? validationMessages;
  final String extraInfo;
  final FormControl? formControl;
  final bool hasCounter;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;
  final TextInputType? keyboardType;
  final String labelText;
  final int? maxLength;
  final int? maxLines;
  final int? minLength;
  final int? minLines;
  final void Function(FormControl<Object?>)? onTap;
  final bool readOnly;
  final bool showErrors;
  final String staticValue;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final void Function(FormControl<Object?>)? onSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  late Color _textFieldBackground;

  @override
  void initState() {
    _focusNode.addListener(() {
      onFocusChange(focus: _focusNode.hasFocus);
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _textFieldBackground = context.customOnPrimaryColor.withOpacity(0.05);
    super.didChangeDependencies();
  }

  void onFocusChange({required bool focus}) {
    setState(() {
      _textFieldBackground = focus
          ? context.customOnPrimaryColor.withOpacity(0.1)
          : context.customOnPrimaryColor.withOpacity(0.05);
    });
  }

  InputDecoration getTextFieldDecoration(FormGroup form) {
    return InputDecoration(
      disabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: const BorderSide(
          style: BorderStyle.none,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: const BorderSide(
          style: BorderStyle.none,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: BorderSide(
          color: constants.palette.red.withOpacity(0.3),
          width: 4,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: BorderSide(
          color: constants.palette.red.withOpacity(0.3),
          width: 4,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(constants.theme.defaultBorderRadius)),
        borderSide: BorderSide(
          color: widget.isRequired && widget.formControl?.valid == true
              ? constants.palette.green.withOpacity(0.5)
              : Colors.transparent,
          width: 4,
        ),
      ),
      filled: true,
      errorMaxLines: 2,
      fillColor: _textFieldBackground,
      suffixIcon: widget.suffixIcon,
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
      ),
      hintText: widget.hintText,
      labelText: widget.labelText,
      contentPadding: widget.labelText.isNotEmpty
          ? EdgeInsets.fromLTRB(
              constants.insets.md - 4,
              constants.insets.xs + 2,
              constants.insets.lg + 4,
              constants.insets.xs + 2,
            )
          : null,
    );
  }

  Widget? buildCounter(
    BuildContext context, {
    required int currentLength,
    int? maxLength,
  }) {
    return !widget.hasCounter
        ? const SizedBox()
        : Container(
            padding: const EdgeInsets.symmetric(
              vertical: 1.5,
              horizontal: 4,
            ),
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(
                    color: context.customOnPrimaryColor.withOpacity(0.2)),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            child: RichText(
              text: TextSpan(
                text: '$currentLength',
                style: context.textThemeScheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: widget.minLength != null &&
                          currentLength < widget.minLength!
                      ? constants.palette.red.withOpacity(0.5)
                      : context.customOnPrimaryColor,
                ),
                children: [
                  TextSpan(
                    text: '/$maxLength',
                    style: context.textThemeScheme.bodySmall!.copyWith(
                      color: context.customOnPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  IconData getIcon(FormGroup form) {
    if (form.status != ControlStatus.disabled &&
        widget.formControl?.valid == false) {
      return Icons.priority_high_rounded;
    }

    return Icons.check;
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: constants.insets.xs),
              child: Column(
                children: [
                  ReactiveTextField(
                    showErrors: widget.showErrors ? null : (_) => false,
                    controller: widget.staticValue.isNotEmpty
                        ? TextEditingController(text: widget.staticValue)
                        : null,
                    readOnly: widget.readOnly,
                    obscureText: widget.obscureText,
                    onTap: widget.onTap,
                    formControl: widget.formControl,
                    validationMessages: {
                      ValidationMessage.minLength: (_) =>
                          context.tr.core.errors.form.minLength(
                              field: widget.labelText,
                              count: widget.minLength.toString()),
                      ValidationMessage.maxLength: (_) =>
                          context.tr.core.errors.form.maxLength(
                              field: widget.labelText,
                              count: widget.maxLength.toString()),
                      ValidationMessage.required: (_) => context
                          .tr.core.errors.form
                          .required(field: widget.labelText),
                      ValidationMessage.email: (_) =>
                          context.tr.core.errors.form.email,
                    },
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    keyboardType: widget.keyboardType,
                    textCapitalization: widget.textCapitalization,
                    buildCounter: (context,
                        {required int currentLength,
                        required bool isFocused,
                        int? maxLength}) {
                      return buildCounter(context,
                          currentLength: currentLength, maxLength: maxLength);
                    },
                    decoration: getTextFieldDecoration(form),
                    inputFormatters: widget.inputFormatters,
                    textInputAction: widget.textInputAction,
                    focusNode: _focusNode,
                    onSubmitted: widget.onSubmitted,
                  ),
                  if (widget.extraInfo.isNotEmpty) ...{
                    Padding(
                      padding: EdgeInsets.only(
                        left: constants.insets.xs,
                        top: constants.insets.xs - 2,
                        bottom: constants.insets.xs - 2,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_rounded,
                            size: 16,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                widget.extraInfo,
                                style: context.textThemeScheme.bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  },
                ],
              ),
            ),
            if (widget.isRequired) ...{
              Positioned(
                right: constants.insets.sm,
                top: constants.insets.md,
                child: Icon(
                  getIcon(form),
                  size: 14,
                  color: context.customOnPrimaryColor,
                ),
              ),
            },
          ],
        );
      },
    );
  }
}
