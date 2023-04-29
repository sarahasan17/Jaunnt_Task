import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/themehelper.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key key,
    @required this.theme,
  }) : super(key: key);

  final ThemeHelper theme;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController place;
  @override
  void initState() {
    super.initState();
    place = TextEditingController();
    focusnode.addListener(() {
      if (focusnode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
      } else {
        hideOverlay();
      }
    });
  }

  List items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  final layerLink = LayerLink();
  OverlayEntry entry;
  final focusnode = FocusNode();
  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderbox = context.findRenderObject() as RenderBox;
    final size = renderbox.size;
    final offset = renderbox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
        builder: (context) => Positioned(
            width: size.width,
            child: CompositedTransformFollower(
                offset: Offset(0, size.height + 10),
                showWhenUnlinked: false,
                link: layerLink,
                child: buildOverlay())));
    overlay.insert(entry);
  }

  void hideOverlay() {
    entry.remove();
    entry = null;
  }

  Widget buildOverlay() => Material(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: ThemeHelper().white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: ListView.builder(
              padding: EdgeInsets.only(top: 5.0),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10),
                  child: GestureDetector(
                    onTap: () {
                      place.text = items[index];
                      hideOverlay();
                      focusnode.unfocus();
                    },
                    child: Text(
                      items[index],
                      style: ThemeHelper().font2,
                    ),
                  ),
                );
              }),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: TextFormField(
        style: ThemeHelper().font2,
        focusNode: focusnode,
        textAlign: TextAlign.start,
        cursorColor: widget.theme.borderColor,
        controller: place,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
