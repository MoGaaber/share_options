class SharedContent {
  final String text, subject;
  final List<String> paths;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

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

    return new SharedContent(
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

  factory SharedContent.fromMap(Map<String, dynamic> map) {
    return new SharedContent(
      text: map['text'] as String,
      subject: map['subject'] as String,
      paths: map['paths'] as List<String>,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': this.text,
      'subject': this.subject,
      'paths': this.paths,
    };
  }

//</editor-fold>

}
