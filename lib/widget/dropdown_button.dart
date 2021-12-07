import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {Key? key,
      required this.values,
      required this.actualValue,
      required this.onChanged})
      : super(key: key);

  final List<String>? values;
  final String? actualValue;
  final Function? onChanged;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String dropdownValue = '';

  @override
  void initState() {
    setState(() {
      dropdownValue = widget.values?.first ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.values != null && widget.values!.isNotEmpty) {
      return Container(
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: BC.brandBlack, width: 2.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(0),
          ),
        ),
        child: DropdownButton<String>(
          iconEnabledColor: BC.brandBlack,
          value: widget.actualValue ?? dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 16,
          elevation: 1,
          style: BS.reg12.apply(color: BC.brandBlack),
          isExpanded: true,
          underline: const SizedBox.shrink(),
          onChanged: (newValue) => widget.onChanged!(newValue) ?? (String? newValue) => {},
          items: widget.values!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
