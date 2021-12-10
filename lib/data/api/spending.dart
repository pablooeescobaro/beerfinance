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

    if (result != null) {
      return ListSpending.fromJson(jsonDecode(result));
    } else {
      return ListSpending();
    }
  }

  Future<void> deleteSpending(String id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(id);
    final list = prefs.getString('spending');
    final listSpending = ListSpending.fromJson(jsonDecode(list!));
    listSpending.data!.removeWhere((element) => element.id == id);
    await prefs.setString('spending', jsonEncode(listSpending));
  }

  Future<List<FinanceModel>> getFinanceList() async {
    final prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('spending') ?? '';
    final List<FinanceModel> finances = [];
    if (response != '') {
      final result = ListSpending.fromJson(jsonDecode(response)).data;
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
    } else {
      return <FinanceModel>[];
    }
  }
}
