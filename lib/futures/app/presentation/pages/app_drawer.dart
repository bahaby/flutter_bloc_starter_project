import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/generated/translations.g.dart';
import '../../../../core/utils/methods/shortcuts.dart';
import '../blocs/app_bloc.dart';

import '../widgets/user_profile_picture.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isLoggedIn(context))
                          UserProfilePicture(
                            imageUrl: state.currentUser?.image,
                          ),
                        Text(
                          '${context.tr.core.drawer.hello}, ${state.currentUser?.username ?? context.tr.core.drawer.guest}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          state.currentUser?.email ??
                              context.tr.core.drawer.youAreNotLoggedIn,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: Text(context.tr.core.drawer.themeColor),
                subtitle:
                    Text(context.tr.core.drawer.changeTheColorOfTheAppTheme),
                trailing: Wrap(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.square_rounded,
                          color: Colors.yellow),
                      onPressed: () {
                        context.read<AppBloc>().add(
                            const AppEvent.changeThemeColor(Colors.yellow));
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.square_rounded, color: Colors.blue),
                      onPressed: () {
                        context
                            .read<AppBloc>()
                            .add(const AppEvent.changeThemeColor(Colors.blue));
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.brightness_4),
                title: Text(context.tr.core.drawer.themeMode),
                subtitle:
                    Text(context.tr.core.drawer.switchBetweenLightAndDarkMode),
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    context.read<AppBloc>().add(AppEvent.changeThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light));
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(context.tr.core.drawer.uiLanguage),
                subtitle:
                    Text(context.tr.core.drawer.changeTheLanguageOfTheAppUi),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Text('EN'),
                      onPressed: () {
                        context
                            .read<AppBloc>()
                            .add(const AppEvent.changeLocale(AppLocale.en));
                      },
                    ),
                    IconButton(
                      icon: const Text('TR'),
                      onPressed: () {
                        context
                            .read<AppBloc>()
                            .add(const AppEvent.changeLocale(AppLocale.tr));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          if (isLoggedIn(context))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: ListTile(
                title: Row(
                  children: [
                    const Spacer(),
                    const Icon(Icons.logout),
                    const SizedBox(width: 8.0),
                    Text(context.tr.core.drawer.logout),
                  ],
                ),
                onTap: () {
                  context.read<AppBloc>().add(const AppEvent.userLogout());
                },
              ),
            ),
        ],
      ),
    );
  }
}
