import 'utils.dart';

enum NumberSystem { decimal, binary, octal, hexadecimal }

class NumberConverter {
  /// Convierte un número desde cualquier sistema a decimal
  static int toDecimal(String value, NumberSystem fromSystem) {
    if (value.isEmpty) return 0;
    
    try {
      switch (fromSystem) {
        case NumberSystem.decimal:
          return int.parse(value);
        case NumberSystem.binary:
          return int.parse(value, radix: 2);
        case NumberSystem.octal:
          return int.parse(value, radix: 8);
        case NumberSystem.hexadecimal:
          return int.parse(value, radix: 16);
      }
    } catch (e) {
      throw FormatException('Valor inválido para el sistema ${Utils.getSystemName(fromSystem)}');
    }
  }

  /// Convierte un número decimal a cualquier sistema
  static String fromDecimal(int decimal, NumberSystem toSystem) {
    switch (toSystem) {
      case NumberSystem.decimal:
        return decimal.toString();
      case NumberSystem.binary:
        return decimal.toRadixString(2);
      case NumberSystem.octal:
        return decimal.toRadixString(8);
      case NumberSystem.hexadecimal:
        return decimal.toRadixString(16).toUpperCase();
    }
  }

  /// Convierte directamente entre sistemas numéricos
  static String convert(String value, NumberSystem fromSystem, NumberSystem toSystem) {
    if (value.isEmpty) return '';
    
    try {
      int decimal = toDecimal(value, fromSystem);
      return fromDecimal(decimal, toSystem);
    } catch (e) {
      throw FormatException('Error en la conversión: ${e.toString()}');
    }
  }

  /// Convierte un valor a todos los sistemas numéricos
  static Map<NumberSystem, String> convertToAll(String value, NumberSystem fromSystem) {
    Map<NumberSystem, String> results = {};
    
    if (value.isEmpty) {
      for (NumberSystem system in NumberSystem.values) {
        results[system] = '';
      }
      return results;
    }

    try {
      int decimal = toDecimal(value, fromSystem);
      
      for (NumberSystem system in NumberSystem.values) {
        results[system] = fromDecimal(decimal, system);
      }
      
      return results;
    } catch (e) {
      throw FormatException('Error en la conversión: ${e.toString()}');
    }
  }

  /// Valida si un valor es válido para un sistema numérico específico
  static bool isValidForSystem(String value, NumberSystem system) {
    if (value.isEmpty) return true;
    
    try {
      toDecimal(value, system);
      return true;
    } catch (e) {
      return false;
    }
  }
}