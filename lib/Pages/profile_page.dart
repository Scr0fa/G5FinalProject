import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group5finalproject/Pages/login_screen.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? pfp;
  File? background;

  Future pickImage(ImageSource source) async {
    try {
      final pfp = await ImagePicker().pickImage(source: source);
      if (pfp == null) return;

      //final pfpTemp = File(pfp.path);
      final permImage = await saveImagePerm(pfp.path);
      setState(() => this.pfp = permImage);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePerm(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final pfp = File('${directory.path}/$name');
    return File(imagePath).copy(pfp.path);
  }

  Future bgPickImage(ImageSource source) async {
    try {
      final background = await ImagePicker().pickImage(source: source);
      if (background == null) return;

      //final pfpTemp = File(pfp.path);
      final permBgImage = await saveBgPerm(background.path);
      setState(() => this.background = permBgImage);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveBgPerm(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final pfp = File('${directory.path}/$name');
    return File(imagePath).copy(pfp.path);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360.0015258789;
    double size = MediaQuery.of(context).size.width / baseWidth;
    double sizes = size * 0.97;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: SizedBox(
          width: double.infinity,
          height: 800 * size,
          child: Stack(
            children: [
              Positioned(
                left: 0 * size,
                top: 0 * size,
                child: Align(
                  child: SizedBox(
                      width: 360 * size,
                      height: 360 * size,
                      child: background != null
                          ? Image.file(background!, fit: BoxFit.cover)
                          : Image.asset(
                              'assets/app/images/profilecover.jpg',
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              Positioned(
                left: 315 * size,
                top: 30 * size,
                child: Align(
                  child: SizedBox(
                    width: 24.69 * size,
                    height: 24 * size,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text('Pick Image In Gallery'),
                                  onTap: () {
                                    bgPickImage(ImageSource.gallery);
                                    Navigator.of(context).pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text('Use Camera'),
                                  onTap: () {
                                    bgPickImage(ImageSource.camera);
                                    Navigator.of(context).pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blue,
                            border: Border.all(color: Colors.blue)),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0015258789 * size,
                top: 320 * size,
                child: Align(
                  child: SizedBox(
                    width: 360 * size,
                    height: 448 * size,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(31.3846111298 * size),
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 122.0015258789 * size,
                top: 406 * size,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 113 * size,
                    height: 37 * size,
                    decoration: BoxDecoration(
                      color: const Color(0xff0075ff),
                      borderRadius: BorderRadius.circular(20 * size),
                    ),
                    child: Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 11.0500001907 * sizes,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * sizes / size,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 138.0015258789 * size,
                top: 370 * size,
                child: Align(
                  child: SizedBox(
                    width: 82 * size,
                    height: 23 * size,
                    child: Text(
                      '@group5',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15 * sizes,
                        fontWeight: FontWeight.w700,
                        height: 1.5 * sizes / size,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 138.0015258789 * size,
                top: 280 * size,
                child: Align(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text('Pick Image In Gallery'),
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Use Camera'),
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                  Navigator.of(context).pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      width: 84 * size,
                      height: 84 * size,
                      child: pfp != null
                          ? ClipOval(
                              child: Image.file(
                                pfp!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/app/images/defaultprofile.png'),
                            ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 190 * size,
                top: 333 * size,
                child: Align(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                        border: Border.all(width: 5, color: Colors.blue)),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
