class FileInformation {
  FileInformation({
    this.height,
    this.width,
    this.fileSize,
  });

  int? height;
  int? width;
  int? fileSize;

  factory FileInformation.fromJson(dynamic json) =>
      FileInformation(
        height: json["height"],
        width: json["width"],
        fileSize: json["file_size"],
      );
}
