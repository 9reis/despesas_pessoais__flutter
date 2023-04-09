import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm(this.onSubmit);

  final void Function(String, double)? onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit!(title, value);
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
            Container(
              height: 70,
              child: Row(
                children: [
                  Text('Nenhuma data selecionada'),
                  TextButton(
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.white),
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
