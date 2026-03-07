import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shuttlers/ui/screens/ledger_screen.dart';
import 'package:shuttlers/ui/screens/member_screen.dart';
import 'package:shuttlers/utils/auth.dart';
import 'package:shuttlers/utils/pretty.dart';
import 'package:shuttlers/utils/store.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MenuItem currentItem = MenuItems.members;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.style1,
      menuScreen: Builder(
        builder: (context) => MenuScreen(
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() => currentItem = item);
            ZoomDrawer.of(context)!.close();
          },
        ),
      ),
      mainScreen: getScreen(),
      showShadow: true,
      angle: -12.0,
      menuBackgroundColor: Theme.of(context).primaryColor,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.members:
        return MemberScreen();
      case MenuItems.ledger:
        return LedgerScreen();
      default:
        return MemberScreen();
    }
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  const MenuItem(this.title, this.icon);
}

class MenuItems {
  static const members = MenuItem('Members', Icons.people);
  static const ledger = MenuItem('Expenditure', Icons.list_alt_outlined);

  static const all = <MenuItem>[
    members,
    ledger,
  ];
}

class MenuScreen extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Auth auth = Auth();
  User? user;
  Store store = Store();
  StreamSubscription<User?>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = auth.authStateChanges.listen((usr) {
      if (mounted) {
        setState(() {
          user = usr;
        });
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('icon/icon.png'),
                      radius: 50,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Shuttlers',
                      // style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              ),
              Spacer(flex: 2),
              ...MenuItems.all.map(buildMenuItem).toList(),
              Spacer(flex: 2),
              ListTile(
                minLeadingWidth: 20,
                leading: Icon(Icons.account_balance),
                title: StreamBuilder<DocumentSnapshot>(
                    stream: store.overviewStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                          'Something went wrong...',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Text(
                        'Bank ${prettyMoney(data['bank'])}',
                        style: TextStyle(color: Colors.white),
                      );
                    }),
              ),
              ListTile(
                minLeadingWidth: 20,
                leading: user == null ? Icon(Icons.login) : Icon(Icons.logout),
                title: user == null ? Text("Login") : Text("Logout"),
                onTap: () async {
                  user == null
                      ? await passwordDialog(context)
                      : await auth.signOut();
                  //setState(() {});
                  ZoomDrawer.of(context)!.toggle();
                },
              ),
              user == null
                  ? Container()
                  : ListTile(
                      minLeadingWidth: 20,
                      leading: Icon(Icons.password),
                      title: Text('Change Password'),
                      onTap: () async {
                        await _changePasswordDialog(context);
                        ZoomDrawer.of(context)!.toggle();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTile(
        selectedTileColor: Colors.black26,
        selectedColor: Colors.white,
        selected: widget.currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => widget.onSelectedItem(item),
      );

  Future<void> passwordDialog(BuildContext context) async {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(hintText: 'Enter Email'),
                ),
                TextField(
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Enter Password'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('LOGIN'),
                onPressed: () async {
                  try {
                    await auth.signIn(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Logged in!")));
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Login failed.")));
                    }
                  }
                  if (context.mounted) Navigator.pop(context);
                },
              ),
            ],
          );
        });

    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _changePasswordDialog(BuildContext context) async {
    final TextEditingController _currentPasswordController =
        TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _passwordControllerConfirm =
        TextEditingController();

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Change Password'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: _currentPasswordController,
                  decoration:
                      const InputDecoration(hintText: 'Enter Current Password'),
                ),
                TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: _passwordController,
                  decoration:
                      const InputDecoration(hintText: 'Enter New Password'),
                ),
                TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: _passwordControllerConfirm,
                  decoration:
                      const InputDecoration(hintText: 'Confirm New Password'),
                )
              ],
            ),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('CHANGE'),
                onPressed: () async {
                  if (_passwordController.text ==
                      _passwordControllerConfirm.text) {
                    try {
                      await auth.changePassword(
                        currentPassword: _currentPasswordController.text,
                        newPassword: _passwordController.text,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Password changed!")));
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Failed to change password. Check your current password.")));
                      }
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Passwords didn't match!")));
                    }
                  }
                },
              ),
            ],
          );
        });

    _currentPasswordController.dispose();
    _passwordController.dispose();
    _passwordControllerConfirm.dispose();
  }
}
