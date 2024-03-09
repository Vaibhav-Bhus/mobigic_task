import 'package:flutter/material.dart';
import 'package:mobigic_task/providers/grid_provider.dart';
import 'package:mobigic_task/screens/grid_search_screen.dart';
import 'package:mobigic_task/widgets/snachbar.dart';
import 'package:provider/provider.dart';

class GridSetupScreen extends StatefulWidget {
  const GridSetupScreen({super.key});

  @override
  State<GridSetupScreen> createState() => _GridSetupScreenState();
}

class _GridSetupScreenState extends State<GridSetupScreen> {
  final TextEditingController _gridRowsController = TextEditingController();
  final TextEditingController _gridColsController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter Grid Size:'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _gridRowsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Rows'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _gridColsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Columns'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Enter Alphabets for Grid:'),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: 'Alphabets'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int rows = int.parse(_gridRowsController.text.trim());
                int cols = int.parse(_gridColsController.text.trim());
                if (_textEditingController.text.trim().split(" ").length ==
                    rows * cols) {
                  context.read<GridProvider>().createGrid(
                      rows, cols, _textEditingController.text.trim());

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GridSearchScreen(),
                      ));
                } else {
                  showSnackbar(context, text: "Length doesn't match");
                }
              },
              child: const Text('Create Grid'),
            ),
          ],
        ),
      ),
    );
  }
}
