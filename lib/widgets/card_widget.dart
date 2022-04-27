import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:to_do_app/utils/list_item.dart';
import 'dart:math' as math;
import 'package:to_do_app/utils/pallete.dart';
import 'package:to_do_app/utils/storage.dart';

class CardWidget extends StatefulWidget {
  List<String> data;
  late Function? removeData;
  CardWidget({Key? key, required this.data, this.removeData}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late List<ListItem<String>> list;

  @override
  void initState() {
    super.initState();
    populdateData();
  }

  void populdateData() {
    list = [];
    for (int i = 0; i < widget.data.length; i++) {
      list.add(ListItem<String>(widget.data[i]));
    }
  }

  int taskCompleted = 0;
  final snackBar = SnackBar(
    duration: const Duration(seconds: 2),
    backgroundColor: Palette.kToDark,
    behavior: SnackBarBehavior.floating,
    width: 200,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    content: Text(
      "Hurriah!🥳🥳",
      textAlign: TextAlign.center,
      style: GoogleFonts.lora(
        fontSize: 24,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 5),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: _getListItemTile,
        ),
      ],
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 15,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.8),
            ),
            Checkbox(
              value: list[index].isSelected,
              fillColor: MaterialStateProperty.all(Palette.kToDark),
              onChanged: (value) {
                setState(() {
                  list[index].isSelected = !list[index].isSelected;
                  taskCompleted += list[index].isSelected == true ? 1 : -1;
                  if (taskCompleted == list.length) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                list[index].data!,
                textAlign: TextAlign.start,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.removeData!(index);
                setState(() {
                  list.removeAt(index);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.delete,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
