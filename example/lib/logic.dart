import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_options/share_options.dart';
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
  Future<List<ShareOptions>> getShareOptions;

  Logic() {
    getShareOptions = ShareOptions.getShareOptions(SharedContent(
        text: textController.text,
        filePaths: filesPaths,
        subject: subjectController.text));
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
    getShareOptions = ShareOptions.getShareOptions(SharedContent(
        text: textController.text,
        filePaths: filesPaths,
        subject: subjectController.text));
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
      await ShareOptions.customShare(
          SharedContent(
              text: textController.text,
              filePaths: filesPaths,
              subject: subjectController.text),
          ActivityInfo(classNameController.text, packageNameController.text));
    } catch (e) {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
