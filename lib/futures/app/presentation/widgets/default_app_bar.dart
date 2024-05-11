import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/app_bloc.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.title = "",
  });

  final String title;

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(widget.title),
      actions: [
        BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return state.isInternetConnected
                ? const SizedBox()
                : const Icon(Icons
                    .signal_wifi_statusbar_connected_no_internet_4_rounded);
          },
        ),
        const EndDrawerButton(),
      ],
      leading: const AutoLeadingButton(),
    );
  }
}
