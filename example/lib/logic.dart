import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options/share_options.dart';
// import 'package:share_options/share_options.dart';
import 'package:share_options_example/ui/dialogs/my_dialog.dart';

class Logic extends ChangeNotifier {
  var textController = TextEditingController(text: "hello");
  var subjectController = TextEditingController();
  var classNameController =
      TextEditingController(text: "com.whatsapp.ContactPicker");
  var packageNameController = TextEditingController(text: "com.whatsapp");
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> filesPaths = [];

  /*
      // "/data/user/0/com.example.get_share_options_example/cache/file_picker/Screenshot_2020-10-14-00-09-39-68.jpg"

   */
  Future<List<ShareOption>> getShareOptions;

  Logic() {
    // getShareOptions = ShareOptions.textShareOptions('hello', subject: 'world');
    getShareOptions = ShareOptions.filesShareOptions([
      '/data/user/0/com.example.get_share_options_example/cache/file_picker/Screenshot_2020-10-18-06-23-08-04_8850cb4e4bfcc15527143476c3381b12.jpg',
      // '/data/user/0/com.example.get_share_options_example/cache/file_picker/Screenshot_2020-10-18-09-57-00-61_f598e1360c96b5a5aa16536c303cff92.jpg'
    ], text: 'hello', subject: 'world');
  }

  // List<ShareOptions> shareOptions;

  // Future<List<ShareOptions>> get getShareOptionss async =>
  //     this.shareOptions = await ShareOptions.getShareOptions(
  //         SharedContent(text: "", subject: "", filePaths: []));

  // void share() async {
  //   var shareOptions = await getShareOptionss;
  //   shareOptions[0].share();
  // }

  void showFilterOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => MyDialog("Filter Share Options", () => confirm(context)),
    );
    // showModalBottomSheet(context: context, );
  }

  void showCustomShareDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => MyDialog(
              "Share to specific app",
              customShare,
              extraTextFields: test(context),
            ));
  }

  List<Widget> test(BuildContext context) {
    var logic = Provider.of<Logic>(context, listen: false);
    return [
      SizedBox(
        height: 20,
      ),
      TextField(
        decoration: InputDecoration(hintText: "Class Name"),
        controller: logic.classNameController,
      ),
      SizedBox(
        height: 20,
      ),
      TextField(
        controller: logic.packageNameController,
        decoration: InputDecoration(hintText: "Package Name"),
      ),
    ];
  }

  Future<void> pickFiles() async {
    var files = await FilePicker.platform.pickFiles(allowMultiple: true);
    this.filesPaths = files.paths;
    notifyListeners();
  }

  void refreshOptions() {
    getShareOptions = null;
    getShareOptions = ShareOptions.textShareOptions("hello", subject: 'world');
    notifyListeners();
  }

  void confirm(BuildContext context) {
    Navigator.pop(context);
    refreshOptions();
  }

  void clearFilter() {
    filesPaths.clear();
    textController.clear();
    subjectController.clear();
    refreshOptions();
  }

  Future<void> customShare() async {
    try {
      // await ShareOptions.customShare(
      //     ActivityInfo(classNameController.text, packageNameController.text));
    } catch (e) {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
