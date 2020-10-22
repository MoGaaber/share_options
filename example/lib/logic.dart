import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_options/share_options.dart';

import 'ui/filter_share_options_dialog.dart';

class Logic extends ChangeNotifier {
  final textController = TextEditingController(text: "hello world");
  final subjectController = TextEditingController();
  var oldSelectedIndex = 0;
  String path = '';
  List<bool> selected;
  Future<List<ShareOption>> getShareOptions;

  void setSelectedToDefault() => this.selected = [true, false];

  Future<List<ShareOption>> get getFileShareOptions =>
      ShareOptions.getFilesShareOptions(['path1', 'path2'],
          text: 'text', subject: 'subject');

  Logic() {
    getShareOptions = ShareOptions.getTextShareOptions(textController.text,
        subject: subjectController.text);
    setSelectedToDefault();
  }

  void showFilterOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => FilterShareOptionsDialog(),
    );
  }

  Future<void> pickFiles() async {
    final files = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (files != null) {
      this.path = files?.path;
      notifyListeners();
    }
  }

  bool get isFilesShareEnabled => selected[1];

  bool get isImageVisible => path.isNotEmpty && isFilesShareEnabled;

  void refreshOptions() {
    getShareOptions = null;
    if (isFilesShareEnabled) {
      getShareOptions = ShareOptions.getFilesShareOptions([path],
          subject: subjectController.text, text: textController.text);
    } else {
      getShareOptions = ShareOptions.getTextShareOptions(textController.text,
          subject: subjectController.text);
    }
    notifyListeners();
  }

  void confirm(BuildContext context) {
    Navigator.pop(context);
    refreshOptions();
  }

  void clearFilter() {
    path = '';
    setSelectedToDefault();
    textController.clear();
    subjectController.clear();
    notifyListeners();
  }

  void onPressedToggleButton(int index) {
    if (oldSelectedIndex != index) {
      selected[index] = true;
      selected[oldSelectedIndex] = false;
      oldSelectedIndex = index;
      notifyListeners();
    }
  }
}
