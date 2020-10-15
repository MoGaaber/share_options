class SharedContent {
  final String text;
  final String subject;
  final List<String> paths;

  const SharedContent({
    this.text,
    this.subject,
    this.paths,
  });

  SharedContent copyWith({
    String text,
    String subject,
    List<String> filesPaths,
  }) {
    if ((text == null || identical(text, this.text)) &&
        (subject == null || identical(subject, this.subject)) &&
        (filesPaths == null || identical(filesPaths, this.paths))) {
      return this;
    }

    return SharedContent(
      text: text ?? this.text,
      subject: subject ?? this.subject,
      paths: filesPaths ?? this.paths,
    );
  }

  @override
  String toString() {
    return 'SharedContent{text: $text, subject: $subject, paths: $paths}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SharedContent &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          subject == other.subject &&
          paths == other.paths);

  @override
  int get hashCode => text.hashCode ^ subject.hashCode ^ paths.hashCode;

  Map<String, dynamic> get toMap => {
        'text': this.text,
        'subject': this.subject,
        'paths': this.paths,
      };
  Map<String, dynamic> get toSpecificMap => {
        'text': this.text,
        'paths': this.paths,
      };
}
