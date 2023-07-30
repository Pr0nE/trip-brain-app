class AppVersion {
  final int major;
  final int minor;
  final int patch;

  AppVersion(this.major, this.minor, this.patch);

  AppVersion.fromString(String versionString)
      : major = int.parse(versionString.split('.')[0]),
        minor = int.parse(versionString.split('.')[1]),
        patch = int.parse(versionString.split('.')[2]);
}
