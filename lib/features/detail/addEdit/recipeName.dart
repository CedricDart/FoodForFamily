import 'package:flutter/material.dart';

class RecipeNameInput extends StatefulWidget {
  final TextEditingController controller;

  const RecipeNameInput({Key? key, required this.controller}) : super(key: key);

  @override
  _RecipeNameInputState createState() => _RecipeNameInputState();
}

class _RecipeNameInputState extends State<RecipeNameInput> {
  String? _errorMessage;

  // Validation logic: Recipe name must not be empty and must be at least 3 characters long
  String? _validateRecipeName(String value) {
    if (value.isEmpty) {
      return "Recipe name cannot be empty!";
    } else if (value.length < 3) {
      return "Name must be at least 3 characters long!";
    }
    return null; // No errors
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          _errorMessage = _validateRecipeName(value);
        });
      },
      decoration: InputDecoration(
        labelText: 'Recipe Name',
        labelStyle: TextStyle(
          color: _errorMessage == null ? Colors.teal : Colors.red, // Label color changes if error
        ),
        hintText: 'Enter a unique recipe name',
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontStyle: FontStyle.italic,
        ),
        errorText: _errorMessage,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        enabledBorder: _buildEnabledBorder(),
        focusedBorder: _buildFocusedBorder(),
        errorBorder: _buildErrorBorder(),
        focusedErrorBorder: _buildErrorBorder(),
      ),
    );
  }

  // Enabled border with gradient outline
  OutlineInputBorder _buildEnabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Rounded corners
      borderSide: BorderSide(
        color: Colors.teal, // Default color
        width: 2,
      ),
    );
  }

  // Focused border with gradient effect
  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.tealAccent,
        width: 3,
      ),
    );
  }

  // Error border with red outline
  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 2,
      ),
    );
  }
}
