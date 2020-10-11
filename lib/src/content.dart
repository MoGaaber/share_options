import 'package:flutter/cupertino.dart';

class Content {
  final String text, subject;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Content({
    @required this.text,
    @required this.subject,
  });

  Content copyWith({
    String text,
    String subject,
  }) {
    if ((text == null || identical(text, this.text)) &&
        (subject == null || identical(subject, this.subject))) {
      return this;
    }

    return new Content(
      text: text ?? this.text,
      subject: subject ?? this.subject,
    );
  }

  @override
  String toString() {
    return 'Content{text: $text, subject: $subject}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Content &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          subject == other.subject);

  @override
  int get hashCode => text.hashCode ^ subject.hashCode;

  factory Content.fromMap(Map<String, dynamic> map) {
    return new Content(
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

//</editor-fold>

}
