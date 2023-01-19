import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}
class _ProfileEditPageState extends State<ProfileEditPage> {
  File? pfp;
  Future pickImage(ImageSource source) async {
    try {
      final pfp = await ImagePicker().pickImage(source: source);
      if (pfp == null) return;
      final pfpTemp = File(pfp.path);
      setState(() => this.pfp = pfpTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double size = MediaQuery.of(context).size.width / baseWidth;
    double sizes = size * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.fromLTRB(0 * size, 0 * size, 0 * size, 45.78 * size),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff19191c),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 361 * size,
              height: 95 * size,
              child: Stack(
                children: [
                  Positioned(
                    left: 0 * size,
                    top: 0 * size,
                    child: SizedBox(
                      width: 360 * size,
                      height: 95 * size,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 361 * size,
                          height: 95 * size,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xff0075ff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 143.4743652344 * size,
                    top: 49.984588623 * size,
                    child: SizedBox(
                      width: 74 * size,
                      height: 21 * size,
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 13.8846149445 * sizes,
                            fontWeight: FontWeight.w600,
                            height: 1.5 * sizes / size,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:
              EdgeInsets.fromLTRB(0 * size, 0 * size, 0 * size, 26.56 * size),
              width: 361 * size,
              height: 249.44 * size,
              child: Stack(
                children: [
                  Positioned(
                    left: 115 * size,
                    top: 101 * size,
                    child: SizedBox(
                      width: 131.44 * size,
                      height: 148.44 * size,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * size, 0 * size, 0 * size, 0 * size),
                            width: double.infinity,
                            child: Center(
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 131.44 * size,
                                  child: pfp != null
                                      ? ClipOval(
                                    child: Image.file(
                                      pfp!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : const FlutterLogo()),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                23.14 * size, 0 * size, 22.3 * size, 0 * size),
                            width: double.infinity,
                            height: 17 * size,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      context: context,
                                      builder: (BuildContext context){
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget> [
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
                                              onTap: (){
                                                pickImage(ImageSource.camera);
                                                Navigator.of(context).pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 17 * size,
                                  child: Center(
                                    child: Text(
                                      'Change Picture',
                                      style: TextStyle(
                                        fontSize: 11.1076917648 * sizes,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * sizes / size,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}