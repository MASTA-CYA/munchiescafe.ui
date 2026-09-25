import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/common/models/file_type_enum.dart';
import 'package:munchies_cafe/common/models/media_document_action_enum.dart';

class MediaDocumentWidget extends StatelessWidget {
  final String name;
  final FileType? fileType;
  final List<MediaDocumentAction>? actions;

  const MediaDocumentWidget({
    super.key,
    required this.name,
    this.fileType,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      shape: const RoundedRectangleBorder(),
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconAndName(),
            _buildActionIcons(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconAndName() {
    return Row(
      children: [
        _buildFileIcon(),
        const SizedBox(width: 10),
        Text(
          name,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  Widget _buildFileIcon() {
    final FileType type = fileType ?? FileType.resolveFileTypeFromName(name);
    String icon;

    switch (type) {
      case FileType.pdf:
      case FileType.jpg:
      case FileType.png:
        icon = type.name;
        break;
      case FileType.docx:
        icon = 'doc';
        break;
      default:
        icon = 'file';
        break;
    }

    return Image(
      image: ResizeImage(
        AssetImage('assets/images/$icon.png'),
        width: 70,
        height: 70,
        allowUpscaling: false,
      ),
      color: null,
      width: 25,
      height: 25,
    );
  }

  Widget _buildActionIcons() {
    List<Widget> icons = [];

    if (actions.isNull) {
      icons.add(MediaDocumentAction.delete.icon);
    } else {
      for (MediaDocumentAction action in actions!) {
        if (actions!.indexOf(action) != 0) icons.add(const SizedBox(width: 10));
        icons.add(action.icon);
      }
    }

    return Row(
      children: icons,
    );
  }
}
