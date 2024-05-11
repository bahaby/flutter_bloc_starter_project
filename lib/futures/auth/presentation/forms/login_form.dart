import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'login_form.freezed.dart';
part 'login_form.g.dart';
part 'login_form.gform.dart';

@freezed
@Rf()
class LoginForm with _$LoginForm {
  factory LoginForm({
    @RfControl(
      validators: [
        RequiredValidator(),
        MinLengthValidator(3),
      ],
    )
    @Default('')
    String username,
    @RfControl(
      validators: [
        RequiredValidator(),
        MinLengthValidator(6),
      ],
    )
    @Default('')
    String password,
  }) = _LoginForm;

  factory LoginForm.fromJson(Map<String, dynamic> json) =>
      _$LoginFormFromJson(json);
}
