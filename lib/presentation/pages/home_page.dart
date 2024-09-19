// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:astronacci_test_app/routes/router.dart';
import 'package:astronacci_test_app/tools.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  final UserEntity user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  int _currentPage = 1;
  final int _pageSize = 5;

  void _nextPage() {
    setState(() {
      _currentPage++;
    });
    _loadUsers();
  }

  void _prevPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _loadUsers();
    }
  }

  void _loadUsers() {
    BlocProvider.of<UserBloc>(context).add(UsersLoadEvent(page: _currentPage, pageSize: _pageSize));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UserBloc>(context).add(UsersLoadEvent(page: _currentPage, pageSize: _pageSize));
  }

  void _searchProducts(String query) {
    BlocProvider.of<UserBloc>(context).add(SearchUsersEvent(query));
  }

  void _deleteSearch() {
    setState(() {
      _searchController.clear();
    });
    BlocProvider.of<UserBloc>(context).add(UsersLoadEvent(page: 1, pageSize: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentPage > 1)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _prevPage();
                  },
                  child: Text('Prev'),
                ),
              ),
            if (_currentPage > 1) SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _nextPage();
                },
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('List User'),
        actions: [
          BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is AuthLoggedOut) {
                  goRouter.pushReplacementNamed(Routes.loginRoute);
                  GlobalSnackBar.showSnackBar(
                      'Success', 'Success logged out', Duration(seconds: 2));
                }
              },
              child: IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Logged Out'),
                          content: Text('Are you sure want to logged out ?'),
                          actions: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('No')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
                                },
                                child: Text('Yes')),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.logout, color: Colors.white))),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            GlobalSnackBar.showSnackBar('Failed', state.message, Duration(seconds: 2));
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final users = state.result;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<UserBloc>().add(UsersLoadEvent(page: 1, pageSize: 5));
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Cari User',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(onPressed: _deleteSearch, icon: Icon(Icons.close)),
                      ),
                      onEditingComplete: () {
                        _searchProducts(_searchController.text);
                      },
                    ),
                  ),
                  Expanded(
                    child: users.isEmpty
                        ? Center(
                            child: Text(
                              'No users available',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: users.length,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final user = users[index];

                              return ListTile(
                                onTap: () {
                                  goRouter.pushNamed(Routes.profileRoute, extra: user);
                                },
                                leading: CircleAvatar(
                                  backgroundImage: user.image != null || user.image!.isNotEmpty
                                      ? NetworkImage(user.image!)
                                      : null,
                                  child: user.image == null || user.image!.isEmpty
                                      ? Text(getInitials(user.name ?? ''))
                                      : SizedBox.shrink(),
                                ),
                                title: user.id! == firebaseAuth.currentUser!.uid
                                    ? Text('${user.name} (Me)')
                                    : Text(user.name ?? ''),
                                subtitle: Text(user.email ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    InkWell(
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          }
          return Center(child: Text('Users Not Found'));
        },
      ),
    );
  }
}
