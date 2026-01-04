import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

class StorageHelper {
  static Future<void> compactAllBoxes() async {
    try {
      await Hive.box("Invoices").compact();
      await Hive.box("Clients").compact();
      await Hive.box("Settings").compact();
      await Hive.box("keeperBox").compact();
      debugPrint('Storage compacted successfully');
    } catch (e) {
      debugPrint('Error compacting storage: $e');
    }
  }

  static Future<Map<String, int>> getStorageStats() async {
    final stats = <String, int>{};

    try {
      final invoicesBox = Hive.box("Invoices");
      final clientsBox = Hive.box("Clients");
      final settingsBox = Hive.box("Settings");

      stats['invoices'] = invoicesBox.length;
      stats['clients'] = clientsBox.length;
      stats['settings'] = settingsBox.length;

      return stats;
    } catch (e) {
      debugPrint('Error getting storage stats: $e');
      return stats;
    }
  }

  static Future<void> cleanupOldData({int daysToKeep = 365}) async {
    try {
      final invoicesBox = Hive.box("Invoices");
      final rawData = invoicesBox.get('invoicesList');

      if (rawData != null) {
        List<dynamic> invoices = rawData is String ? [] : (rawData as List);

        final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));

        final filtered = invoices.where((invoice) {
          final createdAt = invoice['createdAt']?.toString();
          if (createdAt == null) return true;

          try {
            final date = DateTime.parse(createdAt);
            return date.isAfter(cutoffDate);
          } catch (e) {
            return true;
          }
        }).toList();

        if (filtered.length < invoices.length) {
          await invoicesBox.put('invoicesList', filtered);
          debugPrint(
            'Cleaned up ${invoices.length - filtered.length} old invoices',
          );
        }
      }
    } catch (e) {
      debugPrint('Error cleaning up old data: $e');
    }
  }

  static Future<void> optimizeStorage() async {
    await cleanupOldData();
    await compactAllBoxes();
  }
}
