import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/providers.dart';
import 'plate_label.dart';

class CrossingCard extends StatelessWidget {
  const CrossingCard({super.key, required this.view, this.onTap});

  final CrossingView view;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = view.crossing;
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
        title: PlateLabel(
          plateNumber: c.plateNumber,
          country: c.plateCountry,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(view.vehicleLabel),
            Text('${view.companyName} • ${view.cargoTypeName}'),
            Text(df.format(c.crossedAt),
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        isThreeLine: true,
        trailing: c.cargoQuantity != null
            ? Chip(
                label: Text(
                  '${_fmtQty(c.cargoQuantity!)} ${c.quantityUnit ?? ''}'.trim(),
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  String _fmtQty(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}
