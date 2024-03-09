import 'package:flutter/material.dart';
import 'package:mobigic_task/models/grid_alphabet_model.dart';

class GridProvider extends ChangeNotifier {
  int _rows = 0;
  int _cols = 0;
  List<String> _enteredChars = [];
  final List<List<GridAlphabetModel>> _gridList = [];
  List<List<GridAlphabetModel>> get gridList => _gridList;
  int get cols => _cols;
  int get rows => _rows;

  void createGrid(int rows, int cols, String inputChars) {
   
    _enteredChars = inputChars.split(" ");
    _gridList.clear();
    _rows = rows;
    _cols = rows;

    for (int i = 0; i < rows; i++) {
      List<GridAlphabetModel> model = [];
      for (int j = 0; j < cols; j++) {
        model.add(GridAlphabetModel(
          character: _enteredChars[i * cols + j],
          isHighlighted: false,
        ));
      }
      _gridList.add(model);
    }
    notifyListeners();
  }

  bool searchAndHighlightText(context, {required String searchText}) {
    String text = searchText.toLowerCase();

    for (int i = 0; i < _rows; i++) {
      for (int j = 0; j < _cols; j++) {
        if (j + text.length <= _cols) {
          String horizontalText = '';
          for (int k = 0; k < text.length; k++) {
            horizontalText += _gridList[i][j + k].character.toLowerCase();
          }
          if (horizontalText == text) {
            for (int k = j; k < j + text.length; k++) {
              _gridList[i][k].isHighlighted = true;
            }
            notifyListeners();
            return true;
          }
        }

        if (i + text.length <= _rows) {
          String verticalText = '';
          for (int k = i; k < i + text.length; k++) {
            verticalText += _gridList[k][j].character.toLowerCase();
          }
          if (verticalText == text) {
            for (int k = i; k < i + text.length; k++) {
              _gridList[k][j].isHighlighted = true;
            }
            notifyListeners();

            return true;
          }
        }

        if (i + text.length <= _rows && j + text.length <= _cols) {
          String diagonalText = '';
          for (int k = 0; k < text.length; k++) {
            diagonalText += _gridList[i + k][j + k].character.toLowerCase();
          }
          if (diagonalText == text) {
            for (int k = 0; k < text.length; k++) {
              _gridList[i + k][j + k].isHighlighted = true;
            }
            notifyListeners();
            return true;
          }
        }
      }
    }
    return false;
  }
}
