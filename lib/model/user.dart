import 'package:flutter/material.dart';

class User {
  String _nom;
  String _prenom;
  User(this._nom, this._prenom);
  String get nom => _nom;
  String get prenom => _prenom;
  set nom(String value) {
    if (value.isNotEmpty) {
      _nom = value;
    }
  }

  set prenom(String value) {
    if (value.isNotEmpty) {
      _prenom = value;
    }
  }
}

class MyCustomForm extends StatefulWidget {
  final Function(User) onSubmit;

  MyCustomForm({required this.onSubmit});
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _prenomController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _prenomController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      User newUser = User(_nameController.text, _prenomController.text);
      widget.onSubmit(newUser);
      // Vous pouvez maintenant utiliser newUser pour ajouter l'utilisateur à votre liste d'utilisateurs

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Formulaire soumis'),
          content: Text('Bonjour, ${newUser.nom} ${newUser.prenom}!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              // Reste du code pour le TextFormField
            ),
            TextFormField(
              controller: _prenomController,
              // Vous devrez ajouter le reste du code pour ce TextFormField, similaire à celui du nom
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String subject;
  final String content;
  final DateTime sentDate;
  final User author;

  Message(this.subject, this.content, this.sentDate, this.author);
}

class UserDetailsScreen extends StatelessWidget {
  final User user;

  UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.prenom} ${user.nom}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(1.0),
        child: Text('Nom: ${user.nom}, Prénom: ${user.prenom}'),
      ),
    );
  }
}


