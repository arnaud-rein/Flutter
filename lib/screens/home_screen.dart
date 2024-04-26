import 'package:flutter/material.dart';
import './../controller/user_controller.dart';
import './../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  UserController _userController = UserController();
  @override
  void initState() {
    super.initState();
    _userController.loadUsers();
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _userController.users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = _userController.users[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('${user.prenom} ${user.nom}'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Container(
                    width: MediaQuery.of(context).size.width *
                        0.9, // 90% of screen width
                    height: MediaQuery.of(context).size.height *
                        0.7, // 70% of screen height
                    child: Text(
                        'Vous avez sélectionné ${user.prenom} ${user.nom}'),
                  ),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _addUser(User user) {
    // User user = User('nom', 'prenom');
    _userController.users.add(user);
    // _userController.createDefaultMessageForUser(user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter', style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Column(
        children: [
          MyCustomForm(onSubmit: _addUser),
          Expanded(child: _buildUserList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addUser(User('nom', 'prenom')),
        child: const Icon(Icons.add),
      ),
    );
  }
}
