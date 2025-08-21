import 'converter.dart';

class Utils {
  /// Obtiene el nombre legible de un sistema numérico
  static String getSystemName(NumberSystem system) {
    switch (system) {
      case NumberSystem.decimal:
        return 'Decimal';
      case NumberSystem.binary:
        return 'Binario';
      case NumberSystem.octal:
        return 'Octal';
      case NumberSystem.hexadecimal:
        return 'Hexadecimal';
    }
  }

  /// Obtiene el prefijo típico de un sistema numérico
  static String getSystemPrefix(NumberSystem system) {
    switch (system) {
      case NumberSystem.decimal:
        return '';
      case NumberSystem.binary:
        return '0b';
      case NumberSystem.octal:
        return '0o';
      case NumberSystem.hexadecimal:
        return '0x';
    }
  }

  /// Obtiene la base de un sistema numérico
  static int getSystemBase(NumberSystem system) {
    switch (system) {
      case NumberSystem.decimal:
        return 10;
      case NumberSystem.binary:
        return 2;
      case NumberSystem.octal:
        return 8;
      case NumberSystem.hexadecimal:
        return 16;
    }
  }

  /// Obtiene los caracteres válidos para un sistema numérico
  static String getValidCharacters(NumberSystem system) {
    switch (system) {
      case NumberSystem.decimal:
        return '0123456789';
      case NumberSystem.binary:
        return '01';
      case NumberSystem.octal:
        return '01234567';
      case NumberSystem.hexadecimal:
        return '0123456789ABCDEFabcdef';
    }
  }

  /// Filtra caracteres no válidos para un sistema específico
  static String filterValidCharacters(String input, NumberSystem system) {
    String validChars = getValidCharacters(system);
    String filtered = '';
    
    for (int i = 0; i < input.length; i++) {
      if (validChars.contains(input[i])) {
        filtered += input[i];
      }
    }
    
    return filtered;
  }

  /// Formatea un número con su prefijo
  static String formatWithPrefix(String value, NumberSystem system) {
    if (value.isEmpty) return '';
    String prefix = getSystemPrefix(system);
    return prefix + value;
  }

  /// Valida la longitud máxima para evitar overflow
  static bool isValidLength(String value, NumberSystem system) {
    // Limitamos a valores que no causen overflow en int de 64 bits
    switch (system) {
      case NumberSystem.decimal:
        return value.length <= 18; // Aproximadamente 2^63
      case NumberSystem.binary:
        return value.length <= 63; // 63 bits máximo
      case NumberSystem.octal:
        return value.length <= 21; // Aproximadamente 2^63 en octal
      case NumberSystem.hexadecimal:
        return value.length <= 15; // Aproximadamente 2^63 en hexadecimal
    }
  }
}