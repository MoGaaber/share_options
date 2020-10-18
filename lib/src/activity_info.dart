class ActivityInfo {
  const ActivityInfo(
    this.className,
    this.packageName,
  );

  /// Class name of app's share intent.
  final String className;

  /// Package name of app's share intent.
  final String packageName;

  factory ActivityInfo.fromMap(Map<String, String> map) =>
      ActivityInfo(map['name'], map['packageName']);

  Map<String, String> get toMap => {
        'name': this.className,
        'packageName': this.packageName,
      };
}
