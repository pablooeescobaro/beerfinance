import 'dart:convert';

import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/spending.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpendingApi {
  Future<void> saveSpending(spending) async {
    final prefs = await SharedPreferences.getInstance();

    final result =
        await prefs.setString(spending.id ?? '', jsonEncode(spending));
    final list = prefs.getString('spending');
    if (list != null) {
      final listSpending = ListSpending.fromJson(jsonDecode(list));
      listSpending.data!.add(spending);
      final result =
          await prefs.setString('spending', jsonEncode(listSpending));
    } else {
      final result = await prefs.setString(
          'spending', jsonEncode(ListSpending(data: [spending])));
    }
  }

  Future<SpendingModel> getOneSpending(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(id);

    return SpendingModel.fromJson(jsonDecode(result ?? ''));
  }

  Future<ListSpending> getSpending() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('spending');

    return ListSpending.fromJson(jsonDecode(result ?? ''));
  }

  Future<List<FinanceModel>> getFinanceList() async {
    final prefs = await SharedPreferences.getInstance();
    final result =
        ListSpending.fromJson(jsonDecode(prefs.getString('spending') ?? ''))
            .data;

    final List<FinanceModel> finances = [];
    if (result != null) {
      for (var i = 0; result.length > i; i++) {
        final e = result[i];
        finances.add(FinanceModel(
            id: e.id,
            date: e.date,
            amount: e.amount,
            type: e.type,
            name: e.name));
      }
      return finances;
    } else {
      return <FinanceModel>[];
    }
  }
}
