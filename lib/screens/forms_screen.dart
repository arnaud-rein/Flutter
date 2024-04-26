import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API EXPRESS'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'url manquante';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text("Méthdoe GET"),
                value: _isChecked1,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked1 = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Méthdoe POST"),
                value: _isChecked2,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked2 = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Méthdoe PUT"),
                value: _isChecked3,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked3 = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Méthdoe DELETE"),
                value: _isChecked4,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked4 = value ?? false;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Soumettre'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
