import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/deal_model.dart';

class InterestService {
  static const key = "interested_deals";

  /// Save Deal (Prevent duplicates)
  static Future<void> saveDeal(Deal deal) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];

    final dealJson = jsonEncode(deal.toJson());

    if (!list.contains(dealJson)) {
      list.add(dealJson);
      await prefs.setStringList(key, list);
    }

    print("✅ SAVED DEALS: $list"); // 🔥 ADD THIS
  }

  /// Get Deals
  static Future<List<Deal>> getDeals() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];

    print("📦 LOADED DEALS: $list"); // 🔥 ADD THIS

    return list.map((e) => Deal.fromJson(jsonDecode(e))).toList();
  }

  /// Remove Deal
  static Future<void> removeDeal(Deal deal) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];

    list.removeWhere((e) {
      final d = Deal.fromJson(jsonDecode(e));
      return d.companyName == deal.companyName;
    });

    await prefs.setStringList(key, list);
  }
}
