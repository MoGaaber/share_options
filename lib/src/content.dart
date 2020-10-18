import 'dart:io';

class SharedContent {
  final String text;
  final String subject;
  final List<String> filePaths;

  const SharedContent({
    this.text,
    this.filePaths,
    this.subject,
  });

  // bool get isValid => !isEmptyText && !isEmptyPaths && !isPathsExist;

  // bool get isEmpty => text.isEmpty && filePaths.isEmpty ?? true;
  //
  // bool get isNull => text == null && filePaths == null;
  // bool get isEmptyText => text == null ? true : text.isEmpty;
  //
  // bool get isEmptyPaths => filePaths == null ? true : notNullFilePaths.isEmpty;

  List<String> get _notNullFilePaths =>
      filePaths.where((element) => element != null).toList();

  List<String> get _validPaths => _notNullFilePaths.isEmpty
      ? []
      : _notNullFilePaths.where((e) => File(e).existsSync()).toList();

  bool get isFoundValidPaths => _validPaths.isNotEmpty;
  SharedContent copyWith({
    String text,
    String subject,
    List<String> filesPaths,
  }) {
    if ((text == null || identical(text, this.text)) &&
        (subject == null || identical(subject, this.subject)) &&
        (filesPaths == null || identical(filesPaths, this.filePaths))) {
      return this;
    }

    return SharedContent(
      text: text ?? this.text,
      subject: subject ?? this.subject,
      filePaths: filesPaths ?? this.filePaths,
    );
  }

  factory SharedContent.fromMap(Map<String, dynamic> map) {
    return new SharedContent(
      text: map['text'] as String,
      subject: map['subject'] as String,
      filePaths: map['filePaths'] as List<String>,
    );
  }
  factory SharedContent.fromMapText(Map<String, dynamic> map) {
    return new SharedContent(
      text: map['text'] as String,
      subject: map['subject'] as String,
    );
  }
  factory SharedContent.fromMapFiles(Map<String, dynamic> map) {
    return new SharedContent(
      text: map['text'] as String,
      subject: map['subject'] as String,
      filePaths: map['filePaths'] as List<String>,
    );
  }
  Map<String, dynamic> get toMapText => {
        'text': this.text,
        'subject': this.subject,
      };
  Map<String, dynamic> get toMapFiles => {
        'text': this.text,
        'subject': this.subject,
        'paths': this.filePaths,
      };

  Map<String, dynamic> get toMap => {
        'text': this.text,
        'subject': this.subject,
        'paths': this.filePaths,
      };

  Map<String, dynamic> get toSpecificMap => {
        'text': this.text,
        'paths': this.filePaths,
      };

  @override
  String toString() {
    return 'SharedContent{text: $text, subject: $subject, paths: $filePaths}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SharedContent &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          subject == other.subject &&
          filePaths == other.filePaths);

  @override
  int get hashCode => text.hashCode ^ subject.hashCode ^ filePaths.hashCode;
}
