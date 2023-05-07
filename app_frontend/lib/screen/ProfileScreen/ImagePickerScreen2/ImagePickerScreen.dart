// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:app_frontend/screen/ProfileScreen/profile_screen.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:flutter/material.dart';
import '../../../constant/hive.dart';
import '../../AddExperienceScreen/presentation/ImagePickerScreen/filemodel_call.dart';

class ImagePickerScreen2 extends StatefulWidget {
  const ImagePickerScreen2({Key key}) : super(key: key);

  @override
  State<ImagePickerScreen2> createState() => _ImagePickerScreen2State();
}

class _ImagePickerScreen2State extends State<ImagePickerScreen2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImagePath();
  }

  FileModel selectedModel;
  List<FileModel> files;
  getImagePath() async {
    var imagepath = await StoragePath.imagesPath;
    var images = jsonDecode(imagepath) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files.length > 0) {
      setState(() {
        selectedModel = files[0];
        image = files[0].files[0];
        index = 0;
      });
    }
  }

  int index = 0;
  int count = 0;
  String image;
  Widget build(BuildContext context) {
    ScreenWidth s = ScreenWidth(context);
    ThemeHelper theme = ThemeHelper();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.clear),
                      SizedBox(
                        width: s.width / 20,
                      ),
                      DropdownButtonHideUnderline(
                          child: DropdownButton(
                        value: selectedModel,
                        items: getItems(),
                        onChanged: (d) {
                          setState(() {
                            selectedModel = d;
                            image = d.files[0];
                            for (int i = 0; i < files.length; i++) {
                              if (selectedModel == files[i]) {
                                index = i;
                              }
                            }
                          });
                        },
                      )),
                      SizedBox(
                        width: s.width / 7,
                      ),
                      GestureDetector(
                        onTap: () {
                          mybox.put(4, image);
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: theme.buttoncolor),
                            child: Text('Next',
                                style:
                                    theme.font2.copyWith(color: theme.white))),
                      )
                    ],
                  ),
                ),
                Stack(children: [
                  Container(
                    height: s.height / 2.3,
                    width: s.width,
                    child: image != null
                        ? Image.file(
                            File(image),
                            fit: BoxFit.cover,
                            height: s.height / 2.3,
                            width: s.width,
                          )
                        : Container(),
                  ),
                ]),
                SizedBox(
                  height: s.height / 150,
                ),
                selectedModel != null && selectedModel.files.isNotEmpty
                    ? SizedBox(
                        height: s.height / 2.5,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 1.5,
                                  mainAxisSpacing: 1.5),
                          itemBuilder: (context, i) {
                            var file = selectedModel.files[i];
                            return GestureDetector(
                              child: Stack(children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Image.file(
                                    File(file),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ]),
                              onTap: () {
                                setState(() {
                                  image = file;
                                });
                              },
                            );
                          },
                          itemCount: selectedModel.files.length,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> getItems() {
    if (files != null) {
      return files
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.folder),
              ))
          .toList();
    } else {
      return [];
    }
  }
}
