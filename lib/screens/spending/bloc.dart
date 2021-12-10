import 'package:beer_app/data/api/finance.dart';
import 'package:beer_app/data/api/spending.dart';
import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/spending.dart';
import 'package:beer_app/screens/home/home_page.dart';
import 'package:beer_app/screens/spending/page.dart';
import 'package:beer_app/utils/bloc_base.dart';

class SpendingBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final SpendingApi _spendingApi = SpendingApi();
  final FinanceApi _financeApi = FinanceApi();

  SpendingBloc() {
    setState(ScreenState(
        allSpending: AllSpendingModel(0, 0, 0, 0, 0),
        filterListSpending: ListFinance(data: <FinanceModel>[])));
  }

  Future<void> init() async {
    final spending = await _spendingApi.getSpending();
    final finances = await _financeApi.getFinances();
    final allFinance = AllSpendingModel(0, 0, 0, 0, 0);

    if (spending.data?.isNotEmpty ?? false) {
      for (SpendingModel e in spending.data ?? []) {
        switch (e.category) {
          case SpendingCategoryEnum.PRODUCTS:
            allFinance.products += (e.amount ?? 0);
            break;
          case SpendingCategoryEnum.ENTERTAINMENT:
            allFinance.entertainment += (e.amount ?? 0);
            break;
          case SpendingCategoryEnum.TRANSPORT:
            allFinance.transport += (e.amount ?? 0);
            break;
          case SpendingCategoryEnum.HOMEPRODUCTS:
            allFinance.homeproducts += (e.amount ?? 0);
            break;
          case SpendingCategoryEnum.OTHER:
            allFinance.other += (e.amount ?? 0);
            break;
          default:
            break;
        }
      }
    }
    setState(currentState.copyWith(
        listSpending: spending, finances: finances, allSpending: allFinance));
  }

  deleteItem(id) async {
    await _spendingApi.deleteSpending(id);
    init();
  }

  prepareDateForChart(List allSpending) {
    final data = <ChartData>[];
    for (int i = 0; 5 > i; i++) {
      data.add(ChartData(spendingNames[i], allSpending[i], spendingColors[i]));
    }

    return data;
  }

  findCategory(FinanceModel listItem, List<SpendingModel>? data) {
    for (var item in data ?? []) {
      if (listItem.id == item.id) {
        return item.category;
      }
    }
  }

  filtering(FiltersEnum filter, ScreenState state) {
    if (state.filter == filter) {
      setState(state.copyWith(
          filter: FiltersEnum.NONE,
          filterListSpending: ListFinance(data: <FinanceModel>[])));
    } else {
      final filterList = state.listSpending?.data ?? [];
      switch (filter) {
        case FiltersEnum.DATE:
          filterList.sort((a, b) => (a.date ?? 0) > (b.date ?? 0) ? -1 : 1);
          break;
        case FiltersEnum.CAT:
          filterList.sort((a, b) => a.category == b.category ? -1 : 1);
          break;
        case FiltersEnum.PRICE:
          filterList.sort((a, b) => (a.amount ?? 0) > (b.amount ?? 0) ? -1 : 1);
          break;
        case FiltersEnum.NONE:
          break;
      }
      setState(state.copyWith(
          filter: filter,
          filterListSpending:
              ListSpending().toFinanceList(ListSpending(data: filterList))));
    }
  }
}

class ScreenState {
  final String? spendingType;
  final ListSpending? listSpending;
  final ListFinance filterListSpending;
  final ListFinance? finances;
  final AllSpendingModel allSpending;
  final FiltersEnum? filter;

  ScreenState({
    this.spendingType,
    this.listSpending,
    required this.filterListSpending,
    this.finances,
    required this.allSpending,
    this.filter,
  });

  ScreenState copyWith({
    String? spendingType,
    ListSpending? listSpending,
    ListFinance? filterListSpending,
    ListFinance? finances,
    AllSpendingModel? allSpending,
    FiltersEnum? filter,
  }) {
    return ScreenState(
      spendingType: spendingType ?? this.spendingType,
      listSpending: listSpending ?? this.listSpending,
      filterListSpending: filterListSpending ?? this.filterListSpending,
      finances: finances ?? this.finances,
      allSpending: allSpending ?? this.allSpending,
      filter: filter ?? this.filter,
    );
  }
}

class AllSpendingModel {
  AllSpendingModel(this.products, this.entertainment, this.transport,
      this.homeproducts, this.other);

  double products = 0;
  double entertainment = 0;
  double transport = 0;
  double homeproducts = 0;
  double other = 0;
}
