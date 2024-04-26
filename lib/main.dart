import 'package:flutter/material.dart';
import './screens/forms_screen.dart'; // Assurez-vous d'importer form_screen.dart
import './screens/dropdown_screen.dart'; // Assurez-vous d'importer form_screen.dart
import './screens/message_screen.dart'; // Assurez-vous d'importer form_screen.dart
import './screens/home_screen.dart'; // Assurez-vous d'importer form_screen.dart
import './controller/user_controller.dart'; // Assurez-vous d'importer form_screen.dart
// import './model/user.dart'; // Assurez-vous d'importer form_screen.dart
import 'package:http/http.dart' as http;
import 'dart:convert'; // pour le JSON decode

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final UserController userController = UserController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NAVBAR'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/flutter.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('API EXPRESS'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Le Dropdown'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  DropdownButtonApp()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Les Users'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  HomeScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Forum'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MessageListScreen(userController: userController)),
                );
              },
            ),
           
            Expanded( // Ajout d'un widget Expanded
              child: FutureBuilder<List<User>>(
                future: fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Erreur: ${snapshot.error}");
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true, // Ajoutez ceci pour des performances optimisées
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        User user = snapshot.data![index];
                        return ListTile(
                          title: Text(user.title),
                          subtitle: Text(user.body),
                        );
                      },
                    );
                  } else {
                    return Text("Aucune donnée trouvée.");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/flutter.png',
            width: 300, // Définissez la largeur selon vos besoins
            height: 200, // Définissez la hauteur selon vos besoins
            fit: BoxFit.cover, // Adaptez l'image à la taille du conteneur
          ),
          SizedBox(height: 20), // Espace entre l'image et le texte
          Text(
            'Voici une belle image !',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}



class User {
  final int userId;
  final int id;
  final String title;
  final String body;

  User(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

Future<List<User>> fetchUser() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> usersJson = json.decode(response.body);
    return Future<List<User>>.value(
        usersJson.map((usersJson) => User.fromJson(usersJson)).toList());
  } else {
    throw Exception('Échec du chargement de l’utilisateur');
  }
}
