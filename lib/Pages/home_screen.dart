import 'package:flutter/material.dart';
import 'package:group5finalproject/Pages/add_edit_page.dart';
import 'package:group5finalproject/Pages/diary_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    // getTodo();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("My Diary")
        ),
        body:Container(
          height: 900,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login-bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: RefreshIndicator(
              onRefresh: fetchTodo,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index] as Map;
                      final id = items[index]['_id'] as String;
                      return
                        Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                            decoration: const BoxDecoration(color: Color.fromARGB(90, 50, 40, 100)),
                            child: Column(
                                children: [
                                  ListTile(
                                    leading: Text('${index + 1}', style:
                                    const TextStyle(
                                        fontSize: 20,

                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                    title: Text(items[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),

                                    //subtitle: Text(items[index]['description']),
                                    trailing: PopupMenuButton(
                                      onSelected: (value) {
                                        if(value == 'edit'){
                                          navigateToEditTodo(item);
                                        } else if(value == 'delete'){
                                          deleteById(id);
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          const PopupMenuItem(
                                            value: 'edit',
                                            child: Icon(Icons.edit_rounded, color: Colors.green,),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Icon(Icons.delete_rounded, color: Colors.red),
                                          ),
                                        ];
                                      },
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(todo: items[index]))
                                      );
                                    },
                                  ),
                                ]
                            )
                        );
                    }),
              ),
            ),


        floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage,
          label: const Text('Add Diary'),
        )
    );
  }
  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => const AddEditPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditTodo(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddEditPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if(response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
        showSuccessMessage('Deleted successfully');
      });
    }
    else {
      showErrorMessage('Unable to Delete');
    }
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = true;
    });
    const url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
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
