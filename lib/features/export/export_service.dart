import 'dart:io';

import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';

class ExportService {
  final _df = DateFormat('dd.MM.yyyy HH:mm');

  List<String> _headers() =>
      ['Дата/Время', 'Гос.номер', 'Компания', 'Авто', 'Грузы', 'Заметка'];

  List<String> _rowOf(CrossingView v) {
    final c = v.crossing;
    final cargo = v.cargos
        .map((cg) => cg.quantityLabel.isEmpty
            ? cg.cargoTypeName
            : '${cg.cargoTypeName} (${cg.quantityLabel})')
        .join(', ');
    return [
      _df.format(c.crossedAt),
      c.plateNumber ?? 'Без номера',
      v.companyName,
      v.vehicleLabel,
      cargo,
      c.note ?? '',
    ];
  }

  Future<File> exportExcel(List<CrossingView> data) async {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];
    sheet.appendRow(_headers().map((h) => TextCellValue(h)).toList());
    for (final v in data) {
      sheet.appendRow(_rowOf(v).map((c) => TextCellValue(c)).toList());
    }
    final dir = await getTemporaryDirectory();
    final file = File(p.join(dir.path,
        'export_${DateTime.now().millisecondsSinceEpoch}.xlsx'));
    await file.writeAsBytes(excel.encode()!);
    return file;
  }

  Future<File> exportPdf(List<CrossingView> data) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        build: (_) => [
          pw.Header(level: 0, text: 'Контроль таможни — отчёт'),
          pw.TableHelper.fromTextArray(
            headers: _headers(),
            data: data.map(_rowOf).toList(),
            cellStyle: const pw.TextStyle(fontSize: 8),
            headerStyle:
                pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
    final dir = await getTemporaryDirectory();
    final file = File(p.join(dir.path,
        'export_${DateTime.now().millisecondsSinceEpoch}.pdf'));
    await file.writeAsBytes(await doc.save());
    return file;
  }

  Future<void> share(File file) async {
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }
}
