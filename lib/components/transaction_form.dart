import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm(this.onSubmit);

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double)? onSubmit;

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    onSubmit!(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Titulo'),
              controller: titleController,
              // Envia o form ao clicar no enter do teclado
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              // Teclado numerico com separador decimal - IOS
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              controller: valueController,
              onSubmitted: (_) => _submitForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.purple[50]),
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.purple[600]),
                  ),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
