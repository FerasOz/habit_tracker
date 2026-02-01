import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/generated/locale_keys.g.dart';

Future<bool?> showConfirmDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final textTheme = Theme.of(context).textTheme;

      return AlertDialog(
        title: Text(
          LocaleKeys.dialogs_confirmDeleteTitle.tr(),
          style: textTheme.titleMedium,
        ),
        content: Text(
          LocaleKeys.dialogs_confirmDeleteMessage.tr(),
          style: textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(LocaleKeys.dialogs_cancel.tr()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(LocaleKeys.dialogs_delete.tr()),
          ),
        ],
      );
    },
  );
}
