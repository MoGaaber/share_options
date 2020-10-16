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
  // List<String> get notNullFilePaths =>
  //     filePaths.where((element) => element != null).toList();

  // bool get isPathsExist => notNullFilePaths.isEmpty
  //     ? false
  //     : notNullFilePaths.where((e) => File(e).existsSync());

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

  Map<String, dynamic> get toMap => {
        'text': this.text,
        'subject': this.subject,
        'paths': this.filePaths,
      };

  Map<String, dynamic> get toSpecificMap => {
        'text': this.text,
        'paths': this.filePaths,
      };
}
