import 'package:flutter/material.dart';
import './../model/user.dart';
import './../controller/user_controller.dart';

class MessageListScreen extends StatefulWidget {
  final UserController userController;

  MessageListScreen({required this.userController});

  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  List<Message> get messages => widget.userController.messages;

  void _addMessage(Message message) {
    setState(() {
      messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index].subject),
            subtitle: Text('Auteur: ${messages[index].author.nom} ${messages[index].author.prenom}, Date: ${messages[index].sentDate}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessageDetailsScreen(message: messages[index], onUpdate: (updatedMessage) {
                  setState(() {
                    messages[index] = updatedMessage;
                  });
                })),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewMessageScreen(onSubmit: _addMessage)),
          );
        },
      ),
    );
  }
}


class NewMessageScreen extends StatefulWidget {
  final Function(Message) onSubmit;

  NewMessageScreen({required this.onSubmit});

  @override
  _NewMessageScreenState createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();
  final _authorNomController = TextEditingController();
  final _authorPrenomController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _contentController.dispose();
    _authorNomController.dispose();
    _authorPrenomController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      User author = User(_authorNomController.text, _authorPrenomController.text);
      Message newMessage = Message(_subjectController.text, _contentController.text, DateTime.now(), author);
      widget.onSubmit(newMessage);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau message'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Sujet'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un sujet';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Contenu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un contenu';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorNomController,
                decoration: InputDecoration(labelText: 'Nom de l\'auteur'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorPrenomController,
                decoration: InputDecoration(labelText: 'Prénom de l\'auteur'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prénom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageDetailsScreen extends StatefulWidget {
  final Message message;
  final Function(Message) onUpdate;

  MessageDetailsScreen({required this.message, required this.onUpdate});

  @override
  _MessageDetailsScreenState createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _subjectController.text = widget.message.subject;
    _contentController.text = widget.message.content;
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Message updatedMessage = Message(_subjectController.text, _contentController.text, widget.message.sentDate, widget.message.author);
      widget.onUpdate(updatedMessage);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du message'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('Auteur: ${widget.message.author.nom} ${widget.message.author.prenom}, Date: ${widget.message.sentDate}'),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Sujet'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un sujet';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Contenu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un contenu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Mettre à jour'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}