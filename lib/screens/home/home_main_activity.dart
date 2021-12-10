import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/income.dart';
import 'package:beer_app/data/dto/saving.dart';
import 'package:beer_app/data/dto/spending.dart';
import 'package:beer_app/routes/router.gr.dart';
import 'package:beer_app/screens/home/home_bloc.dart';
import 'package:beer_app/widget/activity_item.dart';
import 'package:beer_app/widget/empty_screen.dart';
import 'package:beer_app/widget/title_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMainActivity extends StatelessWidget {
  HomeMainActivity({Key? key, required this.state, required this.bloc})
      : super(key: key);
  final ScreenState state;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    final incomes = state.incomes;
    final savings = state.savings;
    final spending = state.spending;
    final finances = state.finances;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _activityBlock(
                'ПОСЛЕДНЯЯ АКТИВНОСТЬ',
                () async => {
                      await context.router.push(const ActivityPageRoute()),
                      bloc.init()
                    },
                finances ?? ListFinance(),
                colorful: true),
            const SizedBox(height: 24),
            _activityBlock(
                'ДОХОДЫ ЗА МЕСЯЦ',
                () async => {
                      await context.router.push(const IncomePageRoute()),
                      bloc.init()
                    },
                ListIncome().toFinanceList(incomes)),
            const SizedBox(height: 24),
            _activityBlock(
                'РАСХОДЫ ЗА МЕСЯЦ',
                () async => {
                      await context.router.push(const SpendingPageRoute()),
                      bloc.init()
                    },
                ListSpending().toFinanceList(spending)),
            const SizedBox(height: 24),
            _activityBlock(
                'СБЕРЕЖЕНИЕ ЗА МЕСЯЦ',
                () async => {
                      await context.router.push(const SavingPageRoute()),
                      bloc.init()
                    },
                ListSaving().toFinanceList(savings)),
          ],
        ),
      ),
    );
  }

  _activityBlock(String title, void Function() onTap, ListFinance list,
      {bool colorful = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleBar(title: title, onTap: onTap),
        const SizedBox(height: 6),
        if (list.data != null && list.data!.isNotEmpty)
          for (var i = 0;
              (list.data!.length < 5 ? list.data!.length : 5) > i;
              i++)
            CustomActivityItem(
              item: list.data![i],
              colorful: colorful,
            )
        else
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: CustomEmptyScreen(center: false),
          ),
      ],
    );
  }
}
