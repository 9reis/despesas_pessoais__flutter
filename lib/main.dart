import 'dart:math';

import 'package:despesas_pessoais__flutter/components/chart.dart';
import 'package:despesas_pessoais__flutter/components/transaction_form.dart';
import 'package:despesas_pessoais__flutter/components/transaction_list.dart';
import 'package:despesas_pessoais__flutter/models/transaction.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});

  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    // No componente principal da app
    // A app só executa no modo retrato
    // SystemChrome.setPreferredOrientations(
    //   [DeviceOrientation.portraitUp],
    // );

    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
              primary: Colors.indigo[900],
              // Cor de destaque
              secondary: Colors.amber),
          textTheme: ThemeData.light().textTheme.copyWith(
                  headlineSmall: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  bool _showChart = false;

  // Passa as transações rencentes para o comp
  List<Transaction> get _recentTransactions {
    // Filter  / Retorna uma lista
    return _transactions.where((tr) {
      //Pega a data de agr e subtrai 7 dias
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    // Fecha o Modal
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscap = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
      ),
      centerTitle: true,
      actions: [
        if (isLandscap)
          IconButton(
              icon: Icon(_showChart ? Icons.list : Icons.show_chart),
              onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
              }),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    // Altura inicial da aplicacao
    // Removendo altura da appBar e da StatusBar da altura total
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscap)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Exibir Grafico'),
                  Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (_showChart || !isLandscap)
              Container(
                height: availableHeight * (isLandscap ? 0.7 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscap)
              Container(
                height: availableHeight * (isLandscap ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
    );
  }
}
