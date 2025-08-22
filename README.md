# ConversionesAPP

Una aplicación Flutter que permite convertir números entre diferentes sistemas numéricos: Decimal, Binario, Octal y Hexadecimal.

## Imagenes
![](/Imagenes/image-1.png)
![](/Imagenes/image-4.jpg)
![](/Imagenes/image-3.png)

## Características

- Conversión automática entre 4 sistemas numéricos
- Interfaz intuitiva y responsive
- Conversión en tiempo real mientras escribes
- Validación de entrada automática
- Cobertura completa de pruebas unitarias
- Diseño Material Design

## Estructura del Proyecto

```
ConversionesAPP/
├── lib/
│   ├── main.dart              # Punto de entrada de la aplicación
│   ├── converter.dart         # Lógica de conversión entre sistemas
│   ├── utils.dart            # Utilidades y funciones auxiliares
│   └── ui/
│       └── interface.dart    # Interfaz de usuario principal
├── test/
│   └── test_converter.dart   # Pruebas unitarias
├── pubspec.yaml              # Dependencias del proyecto
└── README.md                 # Este archivo
```

## Sistemas Numéricos Soportados

| Sistema | Base | Caracteres Válidos | Prefijo |
|---------|------|-------------------|---------|
| Decimal | 10 | 0-9 | - |
| Binario | 2 | 0-1 | 0b |
| Octal | 8 | 0-7 | 0o |
| Hexadecimal | 16 | 0-9, A-F | 0x |

## Instalación

1. Asegúrate de tener Flutter instalado en tu sistema
2. Clona este repositorio:
   ```bash
   git clone <url-del-repositorio>
   cd ConversionesAPP
   ```
3. Instala las dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## Uso

1. **Selecciona el sistema de entrada**: Elige entre Decimal, Binario, Octal o Hexadecimal
2. **Ingresa el número**: Escribe el número en el campo de entrada
3. **Ve las conversiones**: La aplicación mostrará automáticamente las conversiones a todos los otros sistemas

### Ejemplos de Uso

- Ingresa `255` en Decimal → Verás: Binario: `11111111`, Octal: `377`, Hex: `FF`
- Ingresa `1010` en Binario → Verás: Decimal: `10`, Octal: `12`, Hex: `A`
- Ingresa `FF` en Hexadecimal → Verás: Decimal: `255`, Binario: `11111111`, Octal: `377`

## Funcionalidades Técnicas

### Validación de Entrada
- Solo permite caracteres válidos para cada sistema
- Valida la longitud para evitar overflow
- Muestra errores descriptivos

### Conversión en Tiempo Real
- Las conversiones se actualizan automáticamente mientras escribes
- No requiere botones adicionales

### Manejo de Errores
- Captura y maneja errores de formato
- Proporciona mensajes de error claros al usuario

## Arquitectura del Código

### `converter.dart`
Contiene la clase `NumberConverter` con métodos estáticos para: