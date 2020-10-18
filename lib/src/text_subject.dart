class TextAndSubject {
  final String text, subject;

  TextAndSubject({this.text, this.subject});

  factory TextAndSubject.fromMap(Map<String, dynamic> map) {
    return new TextAndSubject(
      text: map['text'] as String,
      subject: map['subject'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'text': this.text,
      'subject': this.subject,
    } as Map<String, dynamic>;
  }
}
