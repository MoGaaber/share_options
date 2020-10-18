class SharedTextAndSubject {
  /// text which we are going to share it
  final String text;

  /// subject/title of share activity/intent
  /// few apps display it
  final String subject;

  SharedTextAndSubject(this.text, this.subject);

  Map<String, dynamic> get toMap => {
        'text': this.text,
        'subject': this.subject,
      };
}
