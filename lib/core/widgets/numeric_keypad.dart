import 'package:flutter/material.dart';

class NumericKeypad extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback? onClear;
  final VoidCallback? onBackspace;

  const NumericKeypad({
    Key? key,
    required this.onNumberPressed,
    this.onClear,
    this.onBackspace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 8),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 8),
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 8),
        _buildRow(['C', '0', '⌫']),
      ],
    );
  }

  Widget _buildRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) => _buildKey(number)).toList(),
    );
  }

  Widget _buildKey(String value) {
    // Determine button color
    Color? backgroundColor = Colors.grey[300];
    Color foregroundColor = Colors.black;
    
    if (value == 'C') {
      backgroundColor = Colors.red[400];
      foregroundColor = Colors.white;
    } else if (value == '⌫') {
      backgroundColor = Colors.orange[400];
      foregroundColor = Colors.white;
    }
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            if (value == 'C' && onClear != null) {
              onClear!();
            } else if (value == '⌫' && onBackspace != null) {
              onBackspace!();
            } else if (value != 'C' && value != '⌫') {
              onNumberPressed(value);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
