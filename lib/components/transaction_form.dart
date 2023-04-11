import 'package:despesas_pessoais__flutter/components/adaptative_button.dart';
import 'package:despesas_pessoais__flutter/components/adaptative_date_picker.dart';
import 'package:despesas_pessoais__flutter/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm(this.onSubmit);

  final void Function(String, double, DateTime)? onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit!(title, value, _selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              AdaptativeTextField(
                label: 'Titulo',
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeTextField(
                // Teclado numerico com separador decimal - IOS
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                label: 'Valor (R\$)',
                controller: _valueController,
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate!,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
