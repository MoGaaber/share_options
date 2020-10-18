class TextAndSubject {
  final String text, subject;

  TextAndSubject(this.text, this.subject);

  Map<String, dynamic> get toMap => {
        'text': this.text,
        'subject': this.subject,
      };
}
