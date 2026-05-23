// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
    BuildContext context,
    LoginFormForm formModel,
    Widget? child,
  )
  builder;

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
  }) : super(stream, child, key: key);

  final LoginFormForm form;
}

class ReactiveLoginFormForm extends StatelessWidget {
  const ReactiveLoginFormForm({
    Key? key,
    required this.form,
    required this.child,
    this.canPop,
    this.onPopInvokedWithResult,
  }) : super(key: key);

  final Widget child;

  final LoginFormForm form;

  final bool Function(FormGroup formGroup)? canPop;

  final ReactiveFormPopInvokedWithResultCallback<dynamic>?
  onPopInvokedWithResult;

  static LoginFormForm? of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<LoginFormFormInheritedStreamer>()
          ?.form;
    }

    final element = context
        .getElementForInheritedWidgetOfExactType<
          LoginFormFormInheritedStreamer
        >();
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
        onPopInvokedWithResult: onPopInvokedWithResult,
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
    this.onPopInvokedWithResult,
    required this.builder,
    this.initState,
  }) : super(key: key);

  final LoginForm? model;

  final Widget? child;

  final bool Function(FormGroup formGroup)? canPop;

  final ReactiveFormPopInvokedWithResultCallback<dynamic>?
  onPopInvokedWithResult;

  final Widget Function(
    BuildContext context,
    LoginFormForm formModel,
    Widget? child,
  )
  builder;

  final void Function(BuildContext context, LoginFormForm formModel)? initState;

  @override
  _LoginFormFormBuilderState createState() => _LoginFormFormBuilderState();
}

class _LoginFormFormBuilderState extends State<LoginFormFormBuilder> {
  late LoginFormForm _formModel;

  StreamSubscription<LogRecord>? _logSubscription;

  @override
  void initState() {
    _formModel = LoginFormForm(
      LoginFormForm.formElements(widget.model),
      null,
      null,
      initialModel: widget.model,
    );

    if (_formModel.form.disabled) {
      _formModel.form.markAsDisabled();
    }

    widget.initState?.call(context, _formModel);

    _logSubscription = _logLoginFormForm.onRecord.listen((LogRecord e) {
      // use `dumpErrorToConsole` for severe messages to ensure that severe
      // exceptions are formatted consistently with other Flutter examples and
      // avoids printing duplicate exceptions
      if (e.level >= Level.SEVERE) {
        final Object? error = e.error;
        FlutterError.dumpErrorToConsole(
          FlutterErrorDetails(
            exception: error is Exception ? error : Exception(error),
            stack: e.stackTrace,
            library: e.loggerName,
            context: ErrorDescription(e.message),
          ),
        );
      } else {
        log(
          e.message,
          time: e.time,
          sequenceNumber: e.sequenceNumber,
          level: e.level.value,
          name: e.loggerName,
          zone: e.zone,
          error: e.error,
          stackTrace: e.stackTrace,
        );
      }
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant LoginFormFormBuilder oldWidget) {
    if (widget.model != oldWidget.model) {
      _formModel
        ..updateValue(widget.model)
        ..commitInitial(widget.model);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _formModel.form.dispose();
    _logSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveLoginFormForm(
      key: ObjectKey(_formModel),
      form: _formModel,
      // canPop: widget.canPop,
      // onPopInvoked: widget.onPopInvoked,
      child: ReactiveFormBuilder(
        form: () => _formModel.form,
        canPop: widget.canPop,
        onPopInvokedWithResult: widget.onPopInvokedWithResult,
        builder: (context, formGroup, child) =>
            widget.builder(context, _formModel, widget.child),
        child: widget.child,
      ),
    );
  }
}

final _logLoginFormForm = Logger.detached('LoginFormForm');

class LoginFormForm implements FormModel<LoginForm, LoginForm> {
  LoginFormForm(
    this.form,
    this.path,
    this._formModel, {
    LoginForm? initialModel,
  }) : _ownInitialModel = initialModel;

  static const String usernameControlName = "username";

  static const String passwordControlName = "password";

  final FormGroup form;

  final String? path;

  // ignore: unused_field
  final FormModel<dynamic, dynamic>? _formModel;

  final Map<String, bool> _disabled = {};

  LoginForm? _ownInitialModel;

  late Map<String, Object?> _ownInitialRawValue = LoginFormForm.formElements(
    _ownInitialModel,
  ).rawValue;

  String usernameControlPath() => pathBuilder(usernameControlName);

  String passwordControlPath() => pathBuilder(passwordControlName);

  String get _usernameValue => usernameControl.value ?? '';

  String get _passwordValue => passwordControl.value ?? '';

  String get _usernameRawValue => usernameControl.value ?? '';

  String get _passwordRawValue => passwordControl.value ?? '';

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

  Map<String, dynamic> get usernameErrors => usernameControl.errors;

  Map<String, dynamic> get passwordErrors => passwordControl.errors;

  void get usernameFocus => form.focus(usernameControlPath());

  void get passwordFocus => form.focus(passwordControlPath());

  void usernameValueUpdate(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    usernameControl.updateValue(
      value,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  void passwordValueUpdate(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    passwordControl.updateValue(
      value,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  void usernameValuePatch(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    usernameControl.patchValue(
      value,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  void passwordValuePatch(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    passwordControl.patchValue(
      value,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  void usernameValueReset(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) => usernameControl.reset(
    value: value,
    updateParent: updateParent,
    emitEvent: emitEvent,
    removeFocus: removeFocus,
    disabled: disabled,
  );

  void passwordValueReset(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) => passwordControl.reset(
    value: value,
    updateParent: updateParent,
    emitEvent: emitEvent,
    removeFocus: removeFocus,
    disabled: disabled,
  );

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
      _logLoginFormForm.warning(
        'Avoid calling `model` on invalid form.Possible exceptions for non-nullable fields which should be guarded by `required` validator.',
        null,
        StackTrace.current,
      );
    }
    return LoginForm(username: _usernameValue, password: _passwordValue);
  }

  @override
  LoginForm get rawModel {
    return LoginForm(username: _usernameRawValue, password: _passwordRawValue);
  }

  @override
  void toggleDisabled({bool updateParent = true, bool emitEvent = true}) {
    if (_disabled.isEmpty) {
      currentForm.controls.forEach((key, control) {
        _disabled[key] = control.disabled;
      });

      currentForm.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      currentForm.controls.forEach((key, control) {
        if (_disabled[key] == false) {
          currentForm.controls[key]?.markAsEnabled(
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }

        _disabled.remove(key);
      });
    }
  }

  @override
  bool equalsTo(LoginForm? other) {
    final currentForm = this.currentForm;

    return const DeepCollectionEquality().equals(
      currentForm.rawValue,
      LoginFormForm.formElements(other).rawValue,
    );
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
      _logLoginFormForm.info('Errors');
      _logLoginFormForm.info('┗━━ ${form.errors}');
      onNotValid?.call();
    }
  }

  @override
  bool get hasChanged {
    return !const DeepCollectionEquality().equals(
      currentForm.rawValue,
      FormModel.sliceByPath(initialRawValue, path),
    );
  }

  @override
  Map<String, Object?> get initialRawValue {
    return _formModel != null
        ? _formModel!.initialRawValue
        : _ownInitialRawValue;
  }

  LoginForm? get initialModel {
    return _ownInitialModel;
  }

  void commitInitial([LoginForm? newModel]) {
    _ownInitialModel = newModel ?? rawModel;
    _ownInitialRawValue = LoginFormForm.formElements(_ownInitialModel).rawValue;
  }

  @override
  FormGroup get currentForm {
    return path == null ? form : form.control(path!) as FormGroup;
  }

  @override
  void updateValue(
    LoginForm? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) => currentForm.updateValue(
    LoginFormForm.formElements(value).rawValue,
    updateParent: updateParent,
    emitEvent: emitEvent,
  );

  @override
  void upsertValue(
    LoginForm? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    final formElements = LoginFormForm.formElements(value);

    currentForm.addAll(formElements.controls);
  }

  @override
  void reset({
    LoginForm? value,
    bool updateParent = true,
    bool emitEvent = true,
  }) => currentForm.reset(
    value: value != null ? formElements(value).rawValue : null,
    updateParent: updateParent,
    emitEvent: emitEvent,
  );

  String pathBuilder(String? pathItem) =>
      [path, pathItem].whereType<String>().join(".");

  static FormGroup formElements(LoginForm? loginForm) => FormGroup(
    {
      usernameControlName: FormControl<String>(
        value: loginForm?.username,
        validators: [RequiredValidator(), MinLengthValidator(3)],
        asyncValidators: [],
        asyncValidatorsDebounceTime: 250,
        disabled: false,
        touched: false,
      ),
      passwordControlName: FormControl<String>(
        value: loginForm?.password,
        validators: [RequiredValidator(), MinLengthValidator(6)],
        asyncValidators: [],
        asyncValidatorsDebounceTime: 250,
        disabled: false,
        touched: false,
      ),
    },
    validators: [],
    asyncValidators: [],
    asyncValidatorsDebounceTime: 250,
    disabled: false,
  );
}

class ReactiveLoginFormFormArrayBuilder<ReactiveLoginFormFormArrayBuilderT>
    extends StatelessWidget {
  const ReactiveLoginFormFormArrayBuilder({
    Key? key,
    this.control,
    this.formControl,
    this.builder,
    required this.itemBuilder,
    this.emptyBuilder,
    this.controlFilter,
  }) : assert(
         control != null || formControl != null,
         "You have to specify `control` or `formControl`!",
       ),
       super(key: key);

  final FormArray<ReactiveLoginFormFormArrayBuilderT>? formControl;

  final FormArray<ReactiveLoginFormFormArrayBuilderT>? Function(
    LoginFormForm formModel,
  )?
  control;

  final Widget Function(
    BuildContext context,
    List<Widget> itemList,
    LoginFormForm formModel,
  )?
  builder;

  final Widget Function(
    BuildContext context,
    int i,
    FormControl<ReactiveLoginFormFormArrayBuilderT> control,
    ReactiveLoginFormFormArrayBuilderT? item,
    LoginFormForm formModel,
  )
  itemBuilder;

  final Widget Function(BuildContext context)? emptyBuilder;

  final bool Function(FormControl<ReactiveLoginFormFormArrayBuilderT> control)?
  controlFilter;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveLoginFormForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    final builder = this.builder;
    final itemBuilder = this.itemBuilder;

    return ReactiveFormArrayItemBuilder<ReactiveLoginFormFormArrayBuilderT>(
      formControl: formControl ?? control?.call(formModel),
      builder: builder != null
          ? (context, itemList) => builder(context, itemList, formModel)
          : null,
      itemBuilder: (context, i, control, item) =>
          itemBuilder(context, i, control, item, formModel),
      emptyBuilder: emptyBuilder,
      controlFilter: controlFilter,
    );
  }
}

class ReactiveLoginFormFormArrayBuilder2<ReactiveLoginFormFormArrayBuilderT>
    extends StatelessWidget {
  const ReactiveLoginFormFormArrayBuilder2({
    Key? key,
    this.control,
    this.formControl,
    this.builder,
    required this.itemBuilder,
    this.emptyBuilder,
    this.controlFilter,
  }) : assert(
         control != null || formControl != null,
         "You have to specify `control` or `formControl`!",
       ),
       super(key: key);

  final FormArray<ReactiveLoginFormFormArrayBuilderT>? formControl;

  final FormArray<ReactiveLoginFormFormArrayBuilderT>? Function(
    LoginFormForm formModel,
  )?
  control;

  final Widget Function(
    ({BuildContext context, List<Widget> itemList, LoginFormForm formModel})
    params,
  )?
  builder;

  final Widget Function(
    ({
      BuildContext context,
      int i,
      FormControl<ReactiveLoginFormFormArrayBuilderT> control,
      ReactiveLoginFormFormArrayBuilderT? item,
      LoginFormForm formModel,
    })
    params,
  )
  itemBuilder;

  final Widget Function(BuildContext context)? emptyBuilder;

  final bool Function(FormControl<ReactiveLoginFormFormArrayBuilderT> control)?
  controlFilter;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveLoginFormForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    final builder = this.builder;
    final itemBuilder = this.itemBuilder;

    return ReactiveFormArrayItemBuilder<ReactiveLoginFormFormArrayBuilderT>(
      formControl: formControl ?? control?.call(formModel),
      builder: builder != null
          ? (context, itemList) => builder((
              context: context,
              itemList: itemList,
              formModel: formModel,
            ))
          : null,
      itemBuilder: (context, i, control, item) => itemBuilder((
        context: context,
        i: i,
        control: control,
        item: item,
        formModel: formModel,
      )),
      emptyBuilder: emptyBuilder,
      controlFilter: controlFilter,
    );
  }
}

class ReactiveLoginFormFormFormGroupArrayBuilder<
  ReactiveLoginFormFormFormGroupArrayBuilderT
>
    extends StatelessWidget {
  const ReactiveLoginFormFormFormGroupArrayBuilder({
    Key? key,
    this.extended,
    this.getExtended,
    this.builder,
    required this.itemBuilder,
  }) : assert(
         extended != null || getExtended != null,
         "You have to specify `control` or `formControl`!",
       ),
       super(key: key);

  final ExtendedControl<
    List<Map<String, Object?>?>,
    List<ReactiveLoginFormFormFormGroupArrayBuilderT>
  >?
  extended;

  final ExtendedControl<
    List<Map<String, Object?>?>,
    List<ReactiveLoginFormFormFormGroupArrayBuilderT>
  >
  Function(LoginFormForm formModel)?
  getExtended;

  final Widget Function(
    BuildContext context,
    List<Widget> itemList,
    LoginFormForm formModel,
  )?
  builder;

  final Widget Function(
    BuildContext context,
    int i,
    ReactiveLoginFormFormFormGroupArrayBuilderT? item,
    LoginFormForm formModel,
  )
  itemBuilder;

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
                .map(
                  (i, item) =>
                      MapEntry(i, itemBuilder(context, i, item, formModel)),
                )
                .values
                .toList();

        return builder?.call(context, itemList, formModel) ??
            Column(children: itemList);
      },
    );
  }
}
