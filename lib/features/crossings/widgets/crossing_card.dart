import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/providers.dart';
import 'plate_label.dart';

class CrossingCard extends StatelessWidget {
  const CrossingCard({super.key, required this.view, this.onTap});

  final CrossingView view;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = view.crossing;
    final l10n = context.l10n;
    final df = DateFormat('dd.MM.yyyy HH:mm');
    final thumb = view.photos.isNotEmpty ? view.photos.first.thumbPath : null;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: SizedBox(
          width: 56,
          height: 56,
          child: thumb != null && File(thumb).existsSync()
              ? Image.file(File(thumb), fit: BoxFit.cover)
              : Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.local_shipping_outlined),
                ),
        ),
        title: view.hasPlate
            ? PlateLabel(
                plateNumber: c.plateNumber!,
                country: c.plateCountry!,
              )
            : Text(
                l10n.noPlateNumber,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(view.vehicleLabel),
            Text('${view.companyName} • ${view.cargoSummary}'),
            Text(df.format(c.crossedAt),
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }
}
