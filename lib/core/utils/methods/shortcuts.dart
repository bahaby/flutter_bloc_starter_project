import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../futures/app/presentation/blocs/app_bloc.dart';

String colorToHex(Color c) {
  return '#${c.value.toRadixString(16).substring(2)}';
}

Color? hexToColor(String h) {
  try {
    return Color(int.parse(h.substring(1, 7), radix: 16) + 0xFF000000);
  } catch (_) {
    return null;
  }
}

LinearGradient colorsToGradient(List<Color> colors, {double opacity = 1}) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: colors.map((c) => c.withOpacity(opacity)).toList(),
  );
}

bool isLoggedIn(BuildContext context) {
  try {
    return context.read<AppBloc>().state.currentUser != null;
  } catch (_) {
    return false;
  }
}
