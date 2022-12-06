import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/services/auth_service.dart';
import '../../domain/models/user.dart';
import '../../internal/config/app_config.dart';
import '../../internal/config/shared_prefs.dart';
import '../../internal/config/token_storage.dart';
import '../app_navigator.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  final _authService = AuthService();

  _ViewModel({required this.context}) {
    asyncInit();
  }

  User? _user;

  User? get user => _user;

  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  Map<String, String>? headers;

  void asyncInit() async {
    var token = await TokenStorage.getAccessToken();
    headers = {"Authorization": "Bearer $token"};
    user = await SharedPrefs.getStoredUser();
  }

  void _logout() async {
    await _authService.logout().then((value) => AppNavigator.toLoader());
  }
}

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: viewModel._logout),
          ],
          title: const Text("Profile"),
        ),
        body: (viewModel.user != null)
            ? ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                children: [
                  Center(
                      child: Stack(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: (viewModel.user != null)
                              ? Ink.image(
                                  image: NetworkImage(
                                      "$baseUrl${viewModel.user!.avatarLink}"),
                                  fit: BoxFit.cover,
                                  width: 128,
                                  height: 128)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: buildEditIcon(
                            Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  )),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      Text(
                        viewModel._user!.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        viewModel._user!.email,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildButton(context, 'Following'),
                      buildDivider(),
                      buildButton(context, 'Followers'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          viewModel._user!.about,
                          style: const TextStyle(fontSize: 16, height: 1.4),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : null);
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(context: context),
      child: const Account(),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Widget buildDivider() => Container(
        height: 24,
        child: const VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
          ],
        ),
      );
}
