import 'dart:convert';
import 'dart:io';

import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:app_frontend/screen/ImagePickerScreen/filemodel_call.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:flutter/material.dart';

import '../../constant/get_constant.dart';
import '../share_experience_screen/share_experience_screen.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImagePath();
  }

  FileModel? selectedModel;
  late List<FileModel> files;
  getImagePath() async {
    var imagepath = await StoragePath.imagesPath;
    var images = jsonDecode(imagepath!) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files!.isNotEmpty) {
      setState(() {
        selectedModel = files![0];
        image = files![0].files[0];
      });
    }
  }

  String image = '';

  Widget build(BuildContext context) {
    ScreenWidth s = ScreenWidth(context);
    ThemeHelper theme = ThemeHelper();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                              image = d?.files[0];
                            });
                          },
                        )),
                        SizedBox(
                          width: s.width / 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              detail.write("key1", image);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddExperienceScreen()));
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: theme.buttoncolor),
                              child: Text('Next',
                                  style: theme.font2
                                      .copyWith(color: theme.white))),
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
              SizedBox(
                height: s.height / 150,
              ),
              selectedModel == null && selectedModel!.files.isEmpty
                  ? Container()
                  : Container(
                      height: s.height / 2.5,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 1.5,
                                mainAxisSpacing: 1.5),
                        itemBuilder: (_, i) {
                          var file = selectedModel?.files[i];
                          return GestureDetector(
                            child: Image.file(
                              File(file!),
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              setState(() {
                                image = file;
                              });
                            },
                          );
                        },
                        itemCount: selectedModel?.files.length,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> getItems() {
    return files
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.folder),
                ))
            .toList() ??
        [];
  }
}
