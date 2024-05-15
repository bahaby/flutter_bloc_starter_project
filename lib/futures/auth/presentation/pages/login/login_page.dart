import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/generated/translations.g.dart';
import '../../../../../core/utils/extensions/build_context_extensions.dart';
import '../../../../../core/utils/helpers/snack_bar_helper.dart';
import '../../../../app/presentation/widgets/customs/custom_textfield.dart';
import '../../blocs/auth_bloc.dart';
import '../../forms/login_form.dart';
import '../../../../../../core/theme/dimens/app_dimen.dart';

import '../../../../../../core/theme/dimens/dimens.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formModel = LoginForm();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case Failed(:final alert):
              SnackBarHelper.showAlert(
                context,
                alert: alert,
              );
              break;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
            child: SingleChildScrollView(
              child: LoginFormFormBuilder(
                  model: _formModel,
                  builder: (context, formModel, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: Dimens.d20.responsive()),
                        Text(
                          context.tr.auth.loginButton,
                          style: context.textThemeScheme.headlineSmall,
                        ),
                        SizedBox(height: Dimens.d30.responsive()),
                        CustomTextField(
                          formControl: formModel.usernameControl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          labelText: context.tr.core.form.username.label,
                          hintText: context.tr.core.form.username.hint,
                          minLength: 3,
                          isRequired: true,
                        ),
                        SizedBox(height: Dimens.d10.responsive()),
                        CustomTextField(
                          formControl: formModel.passwordControl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          labelText: context.tr.core.form.password.label,
                          hintText: context.tr.core.form.password.hint,
                          minLength: 6,
                          isRequired: true,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                formModel.form.markAllAsTouched();
                                if (formModel.form.valid) {
                                  context.read<AuthBloc>().add(AuthEvent.login(
                                      email: formModel.model.username,
                                      password: formModel.model.password));
                                }
                              },
                              child: Text(context.tr.auth.loginButton),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                formModel.usernameControl.value = 'kminchelle';
                                formModel.passwordControl.value = '0lelplR';
                              },
                              style: TextButton.styleFrom(
                                textStyle: context.textThemeScheme.labelSmall,
                              ),
                              child: const Text("Put demo user inputs"),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimens.d24.responsive()),
                        SizedBox(height: Dimens.d8.responsive()),
                        SizedBox(height: Dimens.d40.responsive()),
                      ],
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
