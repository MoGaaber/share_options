class ShareFileUtility {
  final String action, mimeType;
  final List<String> paths;

  ShareFileUtility(this.action, this.mimeType, this.paths);

  Map<String, dynamic> get toMap => {
        'action': this.action,
        'mimeType': this.mimeType,
        'paths': this.paths,
      };
}
