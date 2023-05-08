import 'package:flutter/material.dart';
import '../../../constant/theme/themehelper.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    Key key,
    @required this.place,
    @required this.theme,
  }) : super(key: key);
  TextEditingController place;
  final ThemeHelper theme;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      focusnode.addListener(() {
        if (focusnode.hasFocus) {
          showOverlay();
        } else {
          hideOverlay();
        }
      });
    });
  }

  @override
  static List<String> items = [
    'Nandi Fallsssss',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  List<String> getItems = List.from(items);
  void searchBook(String query) {
    setState(() {
      getItems = items
          .where(
              (element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  final layerLink = LayerLink();
  OverlayEntry entry;
  final focusnode = FocusNode();
  void showOverlay() {
    setState(() {
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
    });
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  int count = 0;
  StatefulWidget buildOverlay() => Material(
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
          child: getItems.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 5.0),
                  itemCount: getItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          widget.place.text = getItems[index];
                          hideOverlay();
                          focusnode.unfocus();
                        },
                        child: Text(
                          getItems[index],
                          style: ThemeHelper().font2,
                        ),
                      ),
                    );
                  })
              : Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10),
                  child: Text(
                    'Add Places \'${widget.place.text}\'',
                    style: ThemeHelper().font2,
                  ),
                ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: TextFormField(
        onChanged: (value) {
          hideOverlay();
          showOverlay();
          searchBook(value);
        },
        style: ThemeHelper().font2,
        focusNode: focusnode,
        textAlign: TextAlign.start,
        cursorColor: widget.theme.borderColor,
        controller: widget.place,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
