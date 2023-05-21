import 'dart:convert';
import 'dart:io';
import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:flutter/material.dart';
import '../../../../constant/hive.dart';
import '../../../ProfileScreen/presentation/ImagePickerScreen2/filemodel_call.dart';
import '../AddExperienceScreen.dart';

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
    tick = List.filled(100, List.filled(10000, false));
  }

  FileModel? selectedModel;
  List<FileModel>? files;
  getImagePath() async {
    var imagepath = await StoragePath.imagesPath;
    var images = jsonDecode(imagepath!) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files!.isNotEmpty) {
      setState(() {
        selectedModel = files![0];
        image = files![0].files![0];
        index = 0;
      });
    }
  }

  int index = 0;
  int count = 0;
  bool multiple = false;
  String? image;
  List<List<bool>> tick = [[]];
  List<String> multipleimage = [];
  Widget build(BuildContext context) {
    ScreenWidth s = ScreenWidth(context);
    ThemeHelper theme = ThemeHelper();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: Icon(Icons.clear)),
                    Expanded(
                      flex: 6,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<dynamic>(
                        value: selectedModel,
                        items: getItems(),
                        onChanged: (d) {
                          setState(() {
                            selectedModel = d as FileModel;
                            image = d.files![0];
                            for (int i = 0; i < files!.length; i++) {
                              if (selectedModel == files?[i]) {
                                index = i;
                              }
                            }
                          });
                        },
                      )),
                    ),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          mybox.put(1, image);
                          mybox.put(2, multiple);
                          mybox.put(3, multipleimage);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddExperienceScreen()));
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: theme.buttoncolor),
                            child: Center(
                              child: Text('Next',
                                  style:
                                      theme.font2.copyWith(color: theme.white)),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Stack(children: [
                SizedBox(
                  height: s.height / 2.3,
                  width: s.width,
                  child: image != null
                      ? Image.file(
                          File(image!),
                          fit: BoxFit.cover,
                          height: s.height / 2.3,
                          width: s.width,
                        )
                      : Container(),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          multiple = !multiple;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme.buttoncolor.withOpacity(0.5)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.copy,
                              color: theme.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'SELECT MULTIPLE',
                              style: theme.font1
                                  .copyWith(color: theme.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ))
              ]),
              SizedBox(
                height: s.height / 150,
              ),
              selectedModel != null && selectedModel!.files!.isNotEmpty
                  ? SizedBox(
                      height: s.height / 2.5,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 1.5,
                                mainAxisSpacing: 1.5),
                        itemBuilder: (context, i) {
                          var file = selectedModel?.files![i];
                          return GestureDetector(
                            child: Stack(children: [
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Image.file(
                                  File(file!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (multiple == true)
                                Positioned(
                                    top: 2,
                                    right: 2,
                                    child: GestureDetector(
                                      child: CircleAvatar(
                                        backgroundColor: theme.white,
                                        radius: 8,
                                        child: (tick[index][i] == true)
                                            ? Icon(
                                                Icons.circle,
                                                color: theme.buttoncolor,
                                                size: 11,
                                              )
                                            : Container(),
                                      ),
                                    ))
                              else
                                Container()
                            ]),
                            onTap: () {
                              setState(() {
                                if (multiple == true) {
                                  tick[index][i] = !tick[index][i];
                                  if (tick[index][i] == true) {
                                    multipleimage.add(file!);
                                  }
                                  if (tick[index][i] == false) {
                                    multipleimage.remove(file);
                                  }
                                }
                                image = file;
                              });
                            },
                          );
                        },
                        itemCount: selectedModel!.files!.length,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> getItems() {
    final files = this.files;
    if (files != null) {
      return files
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.folder!),
              ))
          .toList();
    } else {
      return [];
    }
  }
}
