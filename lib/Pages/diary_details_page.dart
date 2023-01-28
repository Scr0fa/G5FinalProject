import 'package:flutter/material.dart';
import 'package:group5finalproject/Pages/add_edit_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// save image on cache using shared_preferences throw image's path

File? imgFile;
String? imgPath;

class Diarydetails extends StatefulWidget {
  final dynamic todo;

  const Diarydetails({Key? key, this.todo}) : super(key: key);

  @override
  State<Diarydetails> createState() => _DiarydetailsState();
}

class _DiarydetailsState extends State<Diarydetails> {
  final double coverHeight = 280;
  final double profileHeight = 144;

  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("My Diary"),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: InkWell(
                    onTap: () {
                      getImg();
                    },
                    child: const Icon(Icons.image_outlined,
                        color: Colors.green, size: 35))),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                if (imgPath != null)
                  Expanded(
                      child: Image.file(File(imgPath!),
                          width: double.infinity,
                          height: coverHeight,
                          fit: BoxFit.cover)),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                columnTitle(
                  "Title",
                  widget.todo['title'],
                ),
                columnDescription("Description", widget.todo["description"])
              ],
            ),
          ],
        ));
  }

  Widget columnTitle(String title, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 1),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget columnDescription(String description, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 50),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> fetchTodo() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddEditPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
      showSuccessMessage('Updated successfully');
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(
        () {
          items = filtered;
          showSuccessMessage('delete successfully');
        },
      );
    } else {
      showErrorMessage('Unable to delete');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.green)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
        content:
            Text(message, style: const TextStyle(color: Colors.redAccent)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // get image from gallery
  void getImg() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      saveData(pickedImage.path.toString()); // path cache
      setState(() {
        imgFile = File(pickedImage.path);
      });
    }
  }

  void saveData(String val) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('path', val);
    getData();
  }

  void getData() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      imgPath = sharedPref.getString('path');
    });
  }

  void deleteData() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('path');
    getData();
  }
}
