import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) deleteTransaction;
  const TransactionList(this.transactions, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, consraints) {
            return Column(
              children: [
                Text(
                  "No transactions added yet!",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: consraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).errorColor,
                          ),
                          onPressed: () => deleteTransaction(transactions[index].id),
                        )
                      : IconButton(
                          onPressed: () => deleteTransaction(transactions[index].id),
                          color: Theme.of(context).errorColor,
                          icon: const Icon(Icons.delete),
                        ),
                ),
              );
            },
          );
  }
}
