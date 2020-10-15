import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_options/share_options.dart';
import 'package:share_options_example/ui/dialogs/filter_options.dart';

import 'ui/dialogs/custom_share.dart';

class Logic extends ChangeNotifier {
  var textController = TextEditingController();
  var subjectController = TextEditingController();
  var classNameController =
      TextEditingController(text: "com.whatsapp.ContactPicker");
  var packageNameController = TextEditingController(text: "com.whatsapp");
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> filesPaths = [];
  Future<List<ShareOptions>> getShareOptions;

  Logic() {
    getShareOptions = ShareOptions.getShareOptions(
        sharedContent: SharedContent(
            text: textController.text,
            paths: filesPaths,
            subject: subjectController.text));
  }

  void showFilterOptionsDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => FilterOptionsDialog());
    // showModalBottomSheet(context: context, );
  }

  void showCustomShareDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => CustomShareDialog());
  }

  Future<void> pickFiles() async {
    var files = await FilePicker.platform.pickFiles(allowMultiple: true);
    this.filesPaths = files.paths;
  }

  void refreshOptions() {
    getShareOptions = null;
    getShareOptions = ShareOptions.getShareOptions(
        sharedContent: SharedContent(
            text: textController.text,
            paths: filesPaths,
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
              paths: filesPaths,
              subject: subjectController.text),
          ActivityInfo(
              name: classNameController.text,
              packageName: packageNameController.text));
    } on PlatformException catch (e) {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
