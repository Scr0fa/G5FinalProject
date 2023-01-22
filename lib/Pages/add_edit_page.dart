import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddEditPage extends StatefulWidget {
  final Map? todo;
  const AddEditPage({ super.key, this.todo
  });

  @override
  State<AddEditPage> createState() => _AddEditPageState();

}

class _AddEditPageState extends State<AddEditPage> {

  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState(){
    final todo = widget.todo;

    super.initState();
    if(todo !=null){
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            isEdit? 'EDIT MY DAY':'ADD MY DAY'),

      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                  hintText: '01-21-2022',
                  labelText: 'Date Today'
              ),
              validator: (value) {
                return (value == '') ? 'Required Date' : null;
              },

            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Start your day',
              ),
              keyboardType: TextInputType.multiline,
              minLines: 29,
              maxLines: 50,



            ),



            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: isEdit? updateData : submitData,
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Text(
                      isEdit? 'update':'save'),
                )
            )

          ]
      ),
      )

    );
  }
  Future <void> updateData() async{
    final todo = widget.todo;
    if(todo == null){
      return;
    }
    final id = todo ['_id'];
    //final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    final url ='https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);

    final response = await http.put(
        uri,
        body:
        jsonEncode(body),
        headers: {
          'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200){
      titleController.text = '';
      descriptionController.text = '';

      showSuccessMessage('Update successfully');

    }else{
      showErrorMessage('Update unsuccessful');

    }

  }

//-------------------------------------------------
  Future <void> submitData() async{
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    final url ='https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);

    final response = await http.post(
        uri,
        body:
        jsonEncode(body),
        headers: {
          'Content-Type': 'application/json'}
    );

    if (response.statusCode == 201){
      titleController.text = '';
      descriptionController.text = '';

      showSuccessMessage('Create successfully');

    }else{
      showErrorMessage('Unable to create');

    }

  }
  void showSuccessMessage(String message){
    final snackBar = SnackBar(
        content: Text(message,
            style: const TextStyle(
                color: Colors.green)
        )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showErrorMessage(String message){
    final snackBar = SnackBar(
        content: Text(message,
            style: const TextStyle(
                color: Colors.redAccent)
        )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
