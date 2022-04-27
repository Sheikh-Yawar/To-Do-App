import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:to_do_app/utils/pallete.dart';
import 'package:to_do_app/utils/storage.dart';
import 'package:to_do_app/widgets/calender.dart';
import 'package:to_do_app/widgets/card_widget.dart';
import 'package:to_do_app/widgets/empty_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> data = [];

  void removeData(int index) async {
    data = Storage.getData() ?? [];
    data.removeAt(index);
    await Storage.setData(data);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    data = Storage.getData() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            const Calender(),
            if (data.isNotEmpty)
              CardWidget(
                data: data,
                removeData: removeData,
              )
            else
              const EmptyAnimation(),
          ],
        ),
      ),
    );
  }
}
