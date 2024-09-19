// ignore_for_file: prefer_const_constructors

import 'package:astronacci_test_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:astronacci_test_app/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UserBloc>(context).add(UsersLoadEvent());
  }

  void _searchProducts(String query) {
    BlocProvider.of<UserBloc>(context).add(SearchUsersEvent(query));
  }

  void _deleteSearch() {
    setState(() {
      _searchController.clear();
    });
    BlocProvider.of<UserBloc>(context).add(UsersLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HOME PAGE')),
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
                context.read<UserBloc>().add(UsersLoadEvent());
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(12)),
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
                                leading: CircleAvatar(
                                  backgroundImage:
                                      user.image != null || user.image!.isNotEmpty ? NetworkImage(user.image!) : null,
                                  child: user.image == null || user.image!.isEmpty
                                      ? Text(getInitials(user.name ?? ''))
                                      : SizedBox.shrink(),
                                ),
                                title: Text(user.name ?? ''),
                                subtitle: Text(user.email ?? ''),
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
