import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:beer_app/generated/assets.gen.dart';
import 'package:beer_app/screens/activity/bloc.dart';
import 'package:beer_app/styles.dart';
import 'package:beer_app/widget/activity_item.dart';
import 'package:beer_app/widget/empty_screen.dart';
import 'package:beer_app/widget/title_bar.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final ActivityBloc _bloc = ActivityBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text('Активность',
          style: BS.bold18.apply(color: BC.brandWhite)),
      centerTitle: true,
      leading: IconButton(
        icon: Assets.icons.iLeftArrow.svg(color: BC.brandWhite),
        onPressed: () => context.router.pop(),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<ScreenState>(
        stream: _bloc.state,
        initialData: _bloc.currentState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state != null &&
              state.finances != null &&
              state.finances!.data!.isNotEmpty) {
            final list = state.finances!.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomTitleBar(
                      title: 'ПОСЛЕДНЯЯ АКТИВНОСТЬ', onTap: null),
                  const SizedBox(height: 6),
                  if (list != null && list.isNotEmpty)
                    for (var i = 0; list.length > i; i++)
                      CustomActivityItem(
                        item: list[i],
                        canDelete: true,
                        onDelete: () => _bloc.deleteItem(list[i].type, list[i].id),
                        colorful: true,
                      )
                ],
              ),
            );
          } else {
            return CustomEmptyScreen();
          }
        });
  }
}
