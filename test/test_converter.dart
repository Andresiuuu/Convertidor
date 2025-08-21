import 'package:flutter_test/flutter_test.dart';
import '../lib/converter.dart';
import '../lib/utils.dart';

void main() {
  group('NumberConverter Tests', () {
    
    test('Conversión de decimal a otros sistemas', () {
      expect(NumberConverter.convert('10', NumberSystem.decimal, NumberSystem.binary), '1010');
      expect(NumberConverter.convert('10', NumberSystem.decimal, NumberSystem.octal), '12');
      expect(NumberConverter.convert('10', NumberSystem.decimal, NumberSystem.hexadecimal), 'A');
    });

    test('Conversión de binario a otros sistemas', () {
      expect(NumberConverter.convert('1010', NumberSystem.binary, NumberSystem.decimal), '10');
      expect(NumberConverter.convert('1010', NumberSystem.binary, NumberSystem.octal), '12');
      expect(NumberConverter.convert('1010', NumberSystem.binary, NumberSystem.hexadecimal), 'A');
    });

    test('Conversión de octal a otros sistemas', () {
      expect(NumberConverter.convert('12', NumberSystem.octal, NumberSystem.decimal), '10');
      expect(NumberConverter.convert('12', NumberSystem.octal, NumberSystem.binary), '1010');
      expect(NumberConverter.convert('12', NumberSystem.octal, NumberSystem.hexadecimal), 'A');
    });

    test('Conversión de hexadecimal a otros sistemas', () {
      expect(NumberConverter.convert('A', NumberSystem.hexadecimal, NumberSystem.decimal), '10');
      expect(NumberConverter.convert('A', NumberSystem.hexadecimal, NumberSystem.binary), '1010');
      expect(NumberConverter.convert('A', NumberSystem.hexadecimal, NumberSystem.octal), '12');
    });

    test('Conversión a decimal', () {
      expect(NumberConverter.toDecimal('255', NumberSystem.decimal), 255);
      expect(NumberConverter.toDecimal('11111111', NumberSystem.binary), 255);
      expect(NumberConverter.toDecimal('377', NumberSystem.octal), 255);
      expect(NumberConverter.toDecimal('FF', NumberSystem.hexadecimal), 255);
    });

    test('Conversión desde decimal', () {
      expect(NumberConverter.fromDecimal(255, NumberSystem.decimal), '255');
      expect(NumberConverter.fromDecimal(255, NumberSystem.binary), '11111111');
      expect(NumberConverter.fromDecimal(255, NumberSystem.octal), '377');
      expect(NumberConverter.fromDecimal(255, NumberSystem.hexadecimal), 'FF');
    });

    test('Conversión a todos los sistemas', () {
      var result = NumberConverter.convertToAll('16', NumberSystem.decimal);
      expect(result[NumberSystem.decimal], '16');
      expect(result[NumberSystem.binary], '10000');
      expect(result[NumberSystem.octal], '20');
      expect(result[NumberSystem.hexadecimal], '10');
    });

    test('Validación de valores', () {
      expect(NumberConverter.isValidForSystem('123', NumberSystem.decimal), true);
      expect(NumberConverter.isValidForSystem('1010', NumberSystem.binary), true);
      expect(NumberConverter.isValidForSystem('777', NumberSystem.octal), true);
      expect(NumberConverter.isValidForSystem('ABC', NumberSystem.hexadecimal), true);
      
      expect(NumberConverter.isValidForSystem('129', NumberSystem.binary), false);
      expect(NumberConverter.isValidForSystem('89', NumberSystem.octal), false);
      expect(NumberConverter.isValidForSystem('XYZ', NumberSystem.hexadecimal), false);
    });

    test('Manejo de valores vacíos', () {
      expect(NumberConverter.convert('', NumberSystem.decimal, NumberSystem.binary), '');
      expect(NumberConverter.toDecimal('', NumberSystem.decimal), 0);
      
      var result = NumberConverter.convertToAll('', NumberSystem.decimal);
      for (var system in NumberSystem.values) {
        expect(result[system], '');
      }
    });

    test('Manejo de errores', () {
      expect(() => NumberConverter.convert('abc', NumberSystem.decimal, NumberSystem.binary), 
             throwsA(isA<FormatException>()));
      expect(() => NumberConverter.convert('2', NumberSystem.binary, NumberSystem.decimal), 
             throwsA(isA<FormatException>()));
      expect(() => NumberConverter.convert('8', NumberSystem.octal, NumberSystem.decimal), 
             throwsA(isA<FormatException>()));
    });
  });

  group('Utils Tests', () {
    
    test('Nombres de sistemas', () {
      expect(Utils.getSystemName(NumberSystem.decimal), 'Decimal');
      expect(Utils.getSystemName(NumberSystem.binary), 'Binario');
      expect(Utils.getSystemName(NumberSystem.octal), 'Octal');
      expect(Utils.getSystemName(NumberSystem.hexadecimal), 'Hexadecimal');
    });

    test('Prefijos de sistemas', () {
      expect(Utils.getSystemPrefix(NumberSystem.decimal), '');
      expect(Utils.getSystemPrefix(NumberSystem.binary), '0b');
      expect(Utils.getSystemPrefix(NumberSystem.octal), '0o');
      expect(Utils.getSystemPrefix(NumberSystem.hexadecimal), '0x');
    });

    test('Bases de sistemas', () {
      expect(Utils.getSystemBase(NumberSystem.decimal), 10);
      expect(Utils.getSystemBase(NumberSystem.binary), 2);
      expect(Utils.getSystemBase(NumberSystem.octal), 8);
      expect(Utils.getSystemBase(NumberSystem.hexadecimal), 16);
    });

    test('Caracteres válidos', () {
      expect(Utils.getValidCharacters(NumberSystem.decimal), '0123456789');
      expect(Utils.getValidCharacters(NumberSystem.binary), '01');
      expect(Utils.getValidCharacters(NumberSystem.octal), '01234567');
      expect(Utils.getValidCharacters(NumberSystem.hexadecimal), '0123456789ABCDEFabcdef');
    });

    test('Filtro de caracteres válidos', () {
      expect(Utils.filterValidCharacters('1a2b3c', NumberSystem.decimal), '123');
      expect(Utils.filterValidCharacters('1a0b1c', NumberSystem.binary), '101');
      expect(Utils.filterValidCharacters('1a2b8c', NumberSystem.octal), '12');
      expect(Utils.filterValidCharacters('1G2H3I', NumberSystem.hexadecimal), '123');
    });

    test('Formato con prefijo', () {
      expect(Utils.formatWithPrefix('123', NumberSystem.decimal), '123');
      expect(Utils.formatWithPrefix('101', NumberSystem.binary), '0b101');
      expect(Utils.formatWithPrefix('123', NumberSystem.octal), '0o123');
      expect(Utils.formatWithPrefix('ABC', NumberSystem.hexadecimal), '0xABC');
    });

    test('Validación de longitud', () {
      expect(Utils.isValidLength('123', NumberSystem.decimal), true);
      expect(Utils.isValidLength('1' * 20, NumberSystem.decimal), false);
      expect(Utils.isValidLength('1' * 60, NumberSystem.binary), true);
      expect(Utils.isValidLength('1' * 70, NumberSystem.binary), false);
    });
  });

  group('Casos de prueba específicos', () {
    
    test('Números grandes', () {
      expect(NumberConverter.convert('1023', NumberSystem.decimal, NumberSystem.binary), '1111111111');
      expect(NumberConverter.convert('FF', NumberSystem.hexadecimal, NumberSystem.decimal), '255');
      expect(NumberConverter.convert('377', NumberSystem.octal, NumberSystem.decimal), '255');
    });

    test('Casos límite', () {
      expect(NumberConverter.convert('0', NumberSystem.decimal, NumberSystem.binary), '0');
      expect(NumberConverter.convert('1', NumberSystem.decimal, NumberSystem.binary), '1');
      expect(NumberConverter.convert('0', NumberSystem.binary, NumberSystem.decimal), '0');
      expect(NumberConverter.convert('1', NumberSystem.binary, NumberSystem.decimal), '1');
    });

    test('Hexadecimal con minúsculas y mayúsculas', () {
      expect(NumberConverter.convert('ff', NumberSystem.hexadecimal, NumberSystem.decimal), '255');
      expect(NumberConverter.convert('FF', NumberSystem.hexadecimal, NumberSystem.decimal), '255');
      expect(NumberConverter.convert('aB', NumberSystem.hexadecimal, NumberSystem.decimal), '171');
    });
  });
}