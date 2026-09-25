enum FileType {
  pdf,
  docx,
  png,
  jpg,
  unknown;

  factory FileType.resolveFileTypeFromName(String name) =>
      FileTypeExtensions.resolveFileTypeFromName(name);
}

extension FileTypeExtensions on FileType {
  static FileType resolveFileTypeFromName(String fileName) {
    final String extension =
        fileName.split('.').lastOrNull?.toLowerCase() ?? '';

    if (extension.isEmpty) return FileType.unknown;

    switch (extension) {
      case 'pdf':
        return FileType.pdf;
      case 'jpg':
        return FileType.jpg;
      case 'png':
        return FileType.png;
      case 'docx':
        return FileType.docx;
      default:
        return FileType.unknown;
    }
  }
}
