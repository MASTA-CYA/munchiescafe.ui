import 'package:flutter/material.dart';

enum MediaDocumentAction {
  view,
  download,
  upload,
  delete,
}

extension MediaDocumentActionExtension on MediaDocumentAction {
  Widget get icon => _getActionIcon();

  Widget _getActionIcon() {
    switch (this) {
      case MediaDocumentAction.view:
        return const Icon(
          Icons.visibility,
        );
      case MediaDocumentAction.download:
        return const Icon(
          Icons.file_download_outlined,
        );
      case MediaDocumentAction.upload:
        return const Icon(
          Icons.upload,
        );
      case MediaDocumentAction.delete:
        return const Icon(
          Icons.delete,
          color: Colors.red,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
