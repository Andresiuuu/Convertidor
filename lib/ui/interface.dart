import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../converter.dart';
import '../utils.dart';

class NumberConverterInterface extends StatefulWidget {
  const NumberConverterInterface({Key? key}) : super(key: key);

  @override
  _NumberConverterInterfaceState createState() => _NumberConverterInterfaceState();
}

class _NumberConverterInterfaceState extends State<NumberConverterInterface> {
  final TextEditingController _inputController = TextEditingController();
  NumberSystem _selectedSystem = NumberSystem.decimal;
  
  final Map<NumberSystem, TextEditingController> _outputControllers = {
    NumberSystem.decimal: TextEditingController(),
    NumberSystem.binary: TextEditingController(),
    NumberSystem.octal: TextEditingController(),
    NumberSystem.hexadecimal: TextEditingController(),
  };

  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _inputController.dispose();
    for (var controller in _outputControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onInputChanged() {
    setState(() {
      _errorMessage = '';
      String inputValue = _inputController.text.trim();
      
      if (inputValue.isEmpty) {
        _clearOutputs();
        return;
      }

      if (!Utils.isValidLength(inputValue, _selectedSystem)) {
        _errorMessage = 'Número demasiado largo';
        _clearOutputs();
        return;
      }

      try {
        Map<NumberSystem, String> conversions = NumberConverter.convertToAll(inputValue, _selectedSystem);
        
        for (NumberSystem system in NumberSystem.values) {
          _outputControllers[system]!.text = conversions[system] ?? '';
        }
      } catch (e) {
        _errorMessage = e.toString();
        _clearOutputs();
      }
    });
  }

  void _clearOutputs() {
    for (var controller in _outputControllers.values) {
      controller.clear();
    }
  }

  void _onSystemChanged(NumberSystem? newSystem) {
    if (newSystem != null) {
      setState(() {
        _selectedSystem = newSystem;
        _inputController.clear();
        _clearOutputs();
        _errorMessage = '';
      });
    }
  }

  Widget _buildSystemSelector() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sistema de entrada:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<NumberSystem>(
              value: _selectedSystem,
              onChanged: _onSystemChanged,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: NumberSystem.values.map((NumberSystem system) {
                return DropdownMenuItem<NumberSystem>(
                  value: system,
                  child: Text('${Utils.getSystemName(system)} (Base ${Utils.getSystemBase(system)})'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Número en ${Utils.getSystemName(_selectedSystem)}:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Ingrese el número aquí...',
                prefixText: Utils.getSystemPrefix(_selectedSystem),
                errorText: _errorMessage.isEmpty ? null : _errorMessage,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp('[${Utils.getValidCharacters(_selectedSystem)}]'),
                ),
              ],
              keyboardType: _selectedSystem == NumberSystem.decimal 
                  ? TextInputType.number 
                  : TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputField(NumberSystem system) {
    bool isCurrentSystem = system == _selectedSystem;
    
    return Card(
      elevation: isCurrentSystem ? 0 : 2,
      color: isCurrentSystem ? Colors.grey[100] : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${Utils.getSystemName(system)}:',
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: isCurrentSystem ? Colors.grey[600] : null,
                  ),
                ),
                const Spacer(),
                Text(
                  'Base ${Utils.getSystemBase(system)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _outputControllers[system],
              readOnly: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixText: Utils.getSystemPrefix(system),
                filled: true,
                fillColor: isCurrentSystem ? Colors.grey[200] : Colors.grey[50],
              ),
              style: TextStyle(
                fontFamily: 'monospace',
                color: isCurrentSystem ? Colors.grey[600] : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Sistemas Numéricos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSystemSelector(),
            const SizedBox(height: 16),
            _buildInputField(),
            const SizedBox(height: 24),
            const Text(
              'Conversiones:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...NumberSystem.values.map((system) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildOutputField(system),
            )).toList(),
            const SizedBox(height: 24),
            Card(
              elevation: 1,
              color: Colors.blue[50],
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('• Decimal: Números del 0-9'),
                    Text('• Binario: Solo 0 y 1'),
                    Text('• Octal: Números del 0-7'),
                    Text('• Hexadecimal: 0-9 y A-F'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _inputController.clear();
            _clearOutputs();
            _errorMessage = '';
          });
        },
        tooltip: 'Limpiar',
        child: const Icon(Icons.clear),
      ),
    );
  }
}