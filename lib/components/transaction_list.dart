import 'package:despesas_pessoais__flutter/models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.onRemove);

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Nenhuma Transação cadastrada',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 20),
                Container(
                  height: 220,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    // O pai tem que ter uma altura definida
                    // para esse att funcionar
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              // Quantidade de itens que serão renderizadas
              itemCount: (transactions.length),
              itemBuilder: (ctx, index) {
                final tr = transactions[index];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            'R\$${tr.value}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                        size: 25,
                      ),
                      onPressed: () => onRemove(tr.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
