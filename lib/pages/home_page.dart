import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/utils/pallete.dart';
import 'package:to_do_app/utils/storage.dart';

class HomePage extends StatefulWidget {
  late Image myImage;
  HomePage({Key? key, required this.myImage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool emptyValue = false;
  bool changeUi = false;

  List<String> data = [];

  final myController = TextEditingController();

  String? get _errorText {
    if (!emptyValue) {
      return null;
    }

    return "Please Add a To-do";
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Liste à Faire",
            style: GoogleFonts.lora(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              widget.myImage,
              const SizedBox(
                height: 30,
              ),
              FittedBox(
                child: Text(
                  '"I don\'t usually remember anything,\n     If i do i will forget again"',
                  style: GoogleFonts.allura(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      controller: myController,
                      decoration: InputDecoration(
                          hintText: "What are your To-Do's, Today?",
                          labelText: "To-Do's",
                          errorText: _errorText,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        if (myController.text.isNotEmpty) {
                          data = Storage.getData() ?? [];
                          data.add(myController.text);
                          await Storage.setData(data);
                          myController.clear();
                          setState(() {
                            changeUi = true;
                          });
                          await Future.delayed(const Duration(seconds: 2));
                          setState(() {
                            changeUi = false;
                          });
                        } else {
                          setState(() {
                            emptyValue = true;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 40,
                        width: changeUi == true ? 50 : 80,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 7,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                changeUi == true ? Icons.check : Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                changeUi == true ? "" : "Add",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Palette.kToDark,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(79, 0, 0, 0),
                              blurRadius: 12.0,
                              offset: Offset(0.0, 5.0),
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
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/mainPage");
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text(
            "See your To-Do List",
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Palette.kToDark,
        ),
      ),
    );
  }
}
