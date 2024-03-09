import 'package:flutter/material.dart';
import 'package:mobigic_task/providers/grid_provider.dart';
import 'package:mobigic_task/widgets/snachbar.dart';
import 'package:provider/provider.dart';

class GridSearchScreen extends StatefulWidget {
  const GridSearchScreen({super.key});

  @override
  State<GridSearchScreen> createState() => _GridSearchScreenState();
}

class _GridSearchScreenState extends State<GridSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<GridProvider>(builder: (context, gridProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter Text to Search:'),
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(labelText: 'Search Text'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  bool res = gridProvider.searchAndHighlightText(context,
                      searchText: _searchController.text.trim());
                  if (res) {
                    showSnackbar(context, text: 'Text Found');
                  } else {
                    showSnackbar(context, text: 'Text Not Found');
                  }
                },
                child: const Text('Search'),
              ),
              const SizedBox(height: 20),
              if (gridProvider.gridList.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridProvider.gridList.isNotEmpty
                          ? gridProvider.gridList[0].length
                          : 1,
                    ),
                    itemCount: gridProvider.gridList.length *
                        gridProvider.gridList[0].length,
                    itemBuilder: (BuildContext context, int index) {
                      int rowIndex =
                          (index / gridProvider.gridList[0].length).floor();
                      int colIndex = index % gridProvider.gridList[0].length;
                      return Center(
                        child: Text(
                          gridProvider.gridList[rowIndex][colIndex].character,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: gridProvider
                                    .gridList[rowIndex][colIndex].isHighlighted
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
