import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker({
    Key? key,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key);

  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoDatePicker(
            //Pega somente a data
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(2019),
            maximumDate: DateTime.now(),
            onDateTimeChanged: onDateChanged,
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(selectedDate == null
                      ? 'Nenhuma data selecionada'
                      : 'Data Selecionada: ${DateFormat('d/MMM/y').format(selectedDate)}'),
                ),
                TextButton(
                  child: Text(
                    'Selecionar data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _showDatePicker(context),
                ),
              ],
            ),
          );
  }

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      // Func chamada quando o user selecionar ou cancelar
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }
}
