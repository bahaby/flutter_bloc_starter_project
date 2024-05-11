// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file:

part of 'login_form.dart';

// **************************************************************************
// ReactiveFormsGenerator
// **************************************************************************

class ReactiveLoginFormFormConsumer extends StatelessWidget {
  const ReactiveLoginFormFormConsumer({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final Widget? child;

  final Widget Function(
      BuildContext context, LoginFormForm formModel, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveLoginFormForm.of(context);

    if (formModel is! LoginFormForm) {
      throw FormControlParentNotFoundException(this);
    }
    return builder(context, formModel, child);
  }
}

class LoginFormFormInheritedStreamer extends InheritedStreamer<dynamic> {
  const LoginFormFormInheritedStreamer({
    Key? key,
    required this.form,
    required Stream<dynamic> stream,
    required Widget child,
  }) : super(
          stream,
          child,
          key: key,
        );

  final LoginFormForm form;
}

class ReactiveLoginFormForm extends StatelessWidget {
  const ReactiveLoginFormForm({
    Key? key,
    required this.form,
    required this.child,
    this.canPop,
    this.onPopInvoked,
  }) : super(key: key);

  final Widget child;

  final LoginFormForm form;

  final bool Function(FormGroup formGroup)? canPop;

  final void Function(FormGroup formGroup, bool didPop)? onPopInvoked;

  static LoginFormForm? of(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<LoginFormFormInheritedStreamer>()
          ?.form;
    }

    final element = context.getElementForInheritedWidgetOfExactType<
        LoginFormFormInheritedStreamer>();
    return element == null
        ? null
        : (element.widget as LoginFormFormInheritedStreamer).form;
  }

  @override
  Widget build(BuildContext context) {
    return LoginFormFormInheritedStreamer(
      form: form,
      stream: form.form.statusChanged,
      child: ReactiveFormPopScope(
        canPop: canPop,
        onPopInvoked: onPopInvoked,
        child: child,
      ),
    );
  }
}

extension ReactiveReactiveLoginFormFormExt on BuildContext {
  LoginFormForm? loginFormFormWatch() => ReactiveLoginFormForm.of(this);

  LoginFormForm? loginFormFormRead() =>
      ReactiveLoginFormForm.of(this, listen: false);
}

class LoginFormFormBuilder extends StatefulWidget {
  const LoginFormFormBuilder({
    Key? key,
    this.model,
    this.child,
    this.canPop,
    this.onPopInvoked,
    required this.builder,
    this.initState,
  }) : super(key: key);

  final LoginForm? model;

  final Widget? child;

  final bool Function(FormGroup formGroup)? canPop;

  final void Function(FormGroup formGroup, bool didPop)? onPopInvoked;

  final Widget Function(
      BuildContext context, LoginFormForm formModel, Widget? child) builder;

  final void Function(BuildContext context, LoginFormForm formModel)? initState;

  @override
  _LoginFormFormBuilderState createState() => _LoginFormFormBuilderState();
}

class _LoginFormFormBuilderState extends State<LoginFormFormBuilder> {
  late LoginFormForm _formModel;

  @override
  void initState() {
    _formModel = LoginFormForm(LoginFormForm.formElements(widget.model), null);

    if (_formModel.form.disabled) {
      _formModel.form.markAsDisabled();
    }

    widget.initState?.call(context, _formModel);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant LoginFormFormBuilder oldWidget) {
    if (widget.model != oldWidget.model) {
      _formModel.updateValue(widget.model);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _formModel.form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveLoginFormForm(
      key: ObjectKey(_formModel),
      form: _formModel,
      canPop: widget.canPop,
      onPopInvoked: widget.onPopInvoked,
      child: ReactiveFormBuilder(
        form: () => _formModel.form,
        canPop: widget.canPop,
        onPopInvoked: widget.onPopInvoked,
        builder: (context, formGroup, child) =>
            widget.builder(context, _formModel, widget.child),
        child: widget.child,
      ),
    );
  }
}

class LoginFormForm implements FormModel<LoginForm> {
  LoginFormForm(
    this.form,
    this.path,
  );

  static const String usernameControlName = "username";

  static const String passwordControlName = "password";

  final FormGroup form;

  final String? path;

  final Map<String, bool> _disabled = {};

  String usernameControlPath() => pathBuilder(usernameControlName);

  String passwordControlPath() => pathBuilder(passwordControlName);

  String get _usernameValue => usernameControl.value as String;

  String get _passwordValue => passwordControl.value as String;

  bool get containsUsername {
    try {
      form.control(usernameControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get containsPassword {
    try {
      form.control(passwordControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  Object? get usernameErrors => usernameControl.errors;

  Object? get passwordErrors => passwordControl.errors;

  void get usernameFocus => form.focus(usernameControlPath());

  void get passwordFocus => form.focus(passwordControlPath());

  void usernameValueUpdate(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    usernameControl.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void passwordValueUpdate(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    passwordControl.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void usernameValuePatch(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    usernameControl.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void passwordValuePatch(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    passwordControl.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void usernameValueReset(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      usernameControl.reset(
          value: value, updateParent: updateParent, emitEvent: emitEvent);

  void passwordValueReset(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      passwordControl.reset(
          value: value, updateParent: updateParent, emitEvent: emitEvent);

  FormControl<String> get usernameControl =>
      form.control(usernameControlPath()) as FormControl<String>;

  FormControl<String> get passwordControl =>
      form.control(passwordControlPath()) as FormControl<String>;

  void usernameSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      usernameControl.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      usernameControl.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  void passwordSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      passwordControl.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      passwordControl.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  @override
  LoginForm get model {
    final isValid = !currentForm.hasErrors && currentForm.errors.isEmpty;

    if (!isValid) {
      debugPrintStack(
          label:
              '[${path ?? 'LoginFormForm'}]\n┗━ Avoid calling `model` on invalid form. Possible exceptions for non-nullable fields which should be guarded by `required` validator.');
    }
    return LoginForm(username: _usernameValue, password: _passwordValue);
  }

  @override
  void toggleDisabled({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    final currentFormInstance = currentForm;

    if (currentFormInstance is! FormGroup) {
      return;
    }

    if (_disabled.isEmpty) {
      currentFormInstance.controls.forEach((key, control) {
        _disabled[key] = control.disabled;
      });

      currentForm.markAsDisabled(
          updateParent: updateParent, emitEvent: emitEvent);
    } else {
      currentFormInstance.controls.forEach((key, control) {
        if (_disabled[key] == false) {
          currentFormInstance.controls[key]?.markAsEnabled(
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }

        _disabled.remove(key);
      });
    }
  }

  @override
  void submit({
    required void Function(LoginForm model) onValid,
    void Function()? onNotValid,
  }) {
    currentForm.markAllAsTouched();
    if (currentForm.valid) {
      onValid(model);
    } else {
      onNotValid?.call();
    }
  }

  AbstractControl<dynamic> get currentForm {
    return path == null ? form : form.control(path!);
  }

  @override
  void updateValue(
    LoginForm? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) =>
      form.updateValue(LoginFormForm.formElements(value).rawValue,
          updateParent: updateParent, emitEvent: emitEvent);

  @override
  void reset({
    LoginForm? value,
    bool updateParent = true,
    bool emitEvent = true,
  }) =>
      form.reset(
          value: value != null ? formElements(value).rawValue : null,
          updateParent: updateParent,
          emitEvent: emitEvent);

  String pathBuilder(String? pathItem) =>
      [path, pathItem].whereType<String>().join(".");

  static FormGroup formElements(LoginForm? loginForm) => FormGroup({
        usernameControlName: FormControl<String>(
            value: loginForm?.username,
            validators: [RequiredValidator(), MinLengthValidator(3)],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false),
        passwordControlName: FormControl<String>(
            value: loginForm?.password,
            validators: [RequiredValidator(), MinLengthValidator(6)],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false)
      },
          validators: [],
          asyncValidators: [],
          asyncValidatorsDebounceTime: 250,
          disabled: false);
}

class ReactiveLoginFormFormArrayBuilder<ReactiveLoginFormFormArrayBuilderT>
    extends StatelessWidget {
  const ReactiveLoginFormFormArrayBuilder({
    Key? key,
    this.control,
    this.formControl,
    this.builder,
    required this.itemBuilder,
  })  : assert(control != null || formControl != null,
            "You have to specify `control` or `formControl`!"),
        super(key: key);

  final FormArray<ReactiveLoginFormFormArrayBuilderT>? formControl;

  final FormArray<ReactiveLoginFormFormArrayBuilderT>? Function(
      LoginFormForm formModel)? control;

  final Widget Function(
          BuildContext context, List<Widget> itemList, LoginFormForm formModel)?
      builder;

  final Widget Function(
      BuildContext context,
      int i,
      ReactiveLoginFormFormArrayBuilderT? item,
      LoginFormForm formModel) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveLoginFormForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    return ReactiveFormArray<ReactiveLoginFormFormArrayBuilderT>(
      formArray: formControl ?? control?.call(formModel),
      builder: (context, formArray, child) {
        final values = formArray.controls.map((e) => e.value).toList();
        final itemList = values
            .asMap()
            .map((i, item) {
              return MapEntry(
                i,
                itemBuilder(
                  context,
                  i,
                  item,
                  formModel,
                ),
              );
            })
            .values
            .toList();

        return builder?.call(
              context,
              itemList,
              formModel,
            ) ??
            Column(children: itemList);
      },
    );
  }
}

class ReactiveLoginFormFormFormGroupArrayBuilder<
    ReactiveLoginFormFormFormGroupArrayBuilderT> extends StatelessWidget {
  const ReactiveLoginFormFormFormGroupArrayBuilder({
    Key? key,
    this.extended,
    this.getExtended,
    this.builder,
    required this.itemBuilder,
  })  : assert(extended != null || getExtended != null,
            "You have to specify `control` or `formControl`!"),
        super(key: key);

  final ExtendedControl<List<Map<String, Object?>?>,
      List<ReactiveLoginFormFormFormGroupArrayBuilderT>>? extended;

  final ExtendedControl<List<Map<String, Object?>?>,
          List<ReactiveLoginFormFormFormGroupArrayBuilderT>>
      Function(LoginFormForm formModel)? getExtended;

  final Widget Function(
          BuildContext context, List<Widget> itemList, LoginFormForm formModel)?
      builder;

  final Widget Function(
      BuildContext context,
      int i,
      ReactiveLoginFormFormFormGroupArrayBuilderT? item,
      LoginFormForm formModel) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveLoginFormForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    final value = (extended ?? getExtended?.call(formModel))!;

    return StreamBuilder<List<Map<String, Object?>?>?>(
      stream: value.control.valueChanges,
      builder: (context, snapshot) {
        final itemList =
            (value.value() ?? <ReactiveLoginFormFormFormGroupArrayBuilderT>[])
                .asMap()
                .map((i, item) => MapEntry(
                      i,
                      itemBuilder(
                        context,
                        i,
                        item,
                        formModel,
                      ),
                    ))
                .values
                .toList();

        return builder?.call(
              context,
              itemList,
              formModel,
            ) ??
            Column(children: itemList);
      },
    );
  }
}
