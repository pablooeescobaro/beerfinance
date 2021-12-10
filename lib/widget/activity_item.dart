import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/generated/assets.gen.dart';
import 'package:beer_app/styles.dart';
import 'package:beer_app/utils/custom_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActivityItem extends StatelessWidget {
  const CustomActivityItem(
      {Key? key,
      required this.item,
      this.canDelete = false,
      this.onDelete,
      this.colorful = false,
      this.categoryEnum,
      this.categoryEnumParser})
      : super(key: key);

  final FinanceModel item;
  final bool canDelete;
  final bool colorful;
  final void Function()? onDelete;
  final dynamic categoryEnum;
  final Map? categoryEnumParser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name ?? '',
                      style: BS.reg12.apply(color: BC.brandWhite),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    if (categoryEnum != null && categoryEnumParser != null)
                      Text(
                        categoryEnumParser![categoryEnum] ?? '',
                        style: BS.reg10.apply(
                          color: BC.brandWhite,
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Row(
                children: [
                  Text(
                    parseDate(item.date ?? 0),
                    style: BS.reg12.apply(color: BC.brandWhite),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 76,
                    child: Text(
                      parseAmount(item.amount, item.type,
                          withIndicator: colorful),
                      style: BS.reg12.apply(
                        color:
                            colorful ? _parseColor(item.type) : BC.brandWhite,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
              if (onDelete != null)
                InkWell(
                    onTap: onDelete,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                      child: Assets.icons.iDelete
                          .svg(color: BC.brandWhite, height: 16, width: 16),
                    ))
            ]),
          ],
        ),
      ),
    );
  }

  _parseColor(FinanceTypeEnum? type) {
    switch (type) {
      case FinanceTypeEnum.INCOME:
        return BC.brandGreen100;
      case FinanceTypeEnum.SPENDING:
        return BC.brandRed100;
      case FinanceTypeEnum.SAVING:
        return BC.brandRed100;
      default:
        return BC.brandWhite;
    }
  }
}
