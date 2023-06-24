class AppInfo {
  int revision; // int 32 on Server

  AppInfo({
    required this.revision,
  });

  AppInfo.defaultSettings() : revision = 0;

  AppInfo.fromJson(Map<dynamic, dynamic> json) : revision = json['revision'];

  Map<dynamic, dynamic> toJson() => {'revision': revision};
}
