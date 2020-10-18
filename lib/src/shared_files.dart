/// Shared files entity
class SharedFiles {
  /// path of files which we are going to share it
  final List<String> paths;

  /// action of intent
  final String action;

  /// mime type of [paths]
  final String mimeType;

  const SharedFiles(this.action, this.mimeType, this.paths);

  Map<String, dynamic> get toMap => {
        'action': this.action,
        'mimeType': this.mimeType,
        'paths': this.paths,
      };
}
