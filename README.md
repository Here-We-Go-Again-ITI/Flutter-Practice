# Guía Completa de Flutter: Imágenes y Desarrollo

## ¿Qué es Flutter?

Flutter es un framework de código abierto desarrollado por Google para crear aplicaciones nativas multiplataforma (iOS, Android, Web, Desktop) con un único código base. Utiliza el lenguaje de programación Dart y se destaca por:

- **Hot Reload**: Permite ver cambios en tiempo real sin reiniciar la aplicación
- **Widgets personalizables**: Todo en Flutter es un widget
- **Alto rendimiento**: Compila a código nativo
- **Diseño adaptativo**: Se ajusta a diferentes tamaños de pantalla

## Requisitos Previos

1. **Windows**:
   - Windows 10 o superior (64-bit)
   - Mínimo 8GB de RAM
   - Git instalado
   - Visual Studio Code o Android Studio
   - Java Development Kit (JDK)

2. **Android**:
   - Android Studio
   - Android SDK
   - Emulador Android o dispositivo físico

## Instalación Paso a Paso

### 1. Descargar Flutter

```bash
# Crear directorio para Flutter
mkdir C:\flutter
cd C:\flutter

# Clonar Flutter
git clone https://github.com/flutter/flutter.git -b stable .
```

### 2. Agregar Flutter a las variables de entorno

1. **Abrir Variables de Entorno**:
   - Click derecho en "Este Equipo" o "Mi PC"
   - Click en "Propiedades"
   - Click en "Configuración avanzada del sistema"
   - Click en "Variables de entorno"

2. **Editar la variable PATH**:
   - En la sección "Variables del sistema", busca la variable "Path"
   - Click en "Editar"
   - Click en "Nuevo"
   - Agrega la ruta: `C:\flutter\bin`
   - Click en "Aceptar" en todas las ventanas

3. **Verificar la instalación**:
   - Abre una **nueva** ventana de PowerShell o CMD
   - Ejecuta el comando:
   ```bash
   flutter --version
   ```
   - Si ves la versión de Flutter, la configuración fue exitosa

Nota: Si el comando no funciona, reinicia tu computadora para que los cambios surtan efecto.

### 2. Verificar Requisitos

```bash
flutter doctor
```

Resuelve cualquier problema que muestre el comando anterior.

### 3. Configurar IDE

- Instalar la extensión "Flutter" en VS Code
- Reiniciar VS Code

## Solución de Problemas de Instalación


### 2. Instalar Componentes Faltantes

1. **Android SDK Command-line Tools**:
   - Abrir Android Studio
   - Ir a Tools > SDK Manager
   - En la pestaña "SDK Tools", marcar "Android SDK Command-line Tools"
   - Click en "Apply" y "OK"

3. **Visual Studio para Windows**:
   - Descargar [Visual Studio Community](https://visualstudio.microsoft.com/downloads/)
   - Durante la instalación, seleccionar:
     - "Desarrollo de escritorio con C++"
     - "Desarrollo de la plataforma universal de Windows"

Una vez resueltos los problemas anteriores:
```bash
C:\flutter\bin\flutter.bat create mi_app_imagenes
cd mi_app_imagenes
```

## Crear Nuevo Proyecto

```bash
# Crear nuevo proyecto
flutter create mi_app_imagenes
cd mi_app_imagenes
```

## Estructura del Proyecto con Imágenes

### Configurar dependencias
Edita el archivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cached_network_image: ^3.3.0  # Para imágenes en caché
```

Ejecuta:
```bash
flutter pub get
```

## Componentes de Imágenes en Flutter

### 1. Image Widget
`Image` es el widget básico para mostrar imágenes en Flutter. Tiene varios constructores:

- `Image.network()`: Carga imágenes desde URL
- `Image.asset()`: Carga imágenes locales
- `Image.file()`: Carga imágenes desde archivos
- `Image.memory()`: Carga imágenes desde memoria

### 2. CachedNetworkImage
Es un widget que mejora el manejo de imágenes de red:
- Almacena en caché las imágenes
- Muestra placeholder mientras carga
- Maneja errores de carga
- Mejor rendimiento en imágenes repetidas

## Ejemplo Práctico

1. Crear archivo `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Lista de ejemplo de items
  final List<Map<String, dynamic>> items = const [
    {
      'title': 'Item 1',
      'subtitle': 'Descripción del item 1',
      'imageUrl': 'https://picsum.photos/250?image=1'
    },
    {
      'title': 'Item 2',
      'subtitle': 'Descripción del item 2',
      'imageUrl': 'https://picsum.photos/250?image=2'
    },
    {
      'title': 'Item 3',
      'subtitle': 'Descripción del item 3',
      'imageUrl': 'https://picsum.photos/250?image=3'
    },
    {
      'title': 'Item 4',
      'subtitle': 'Descripción del item 4',
      'imageUrl': 'https://picsum.photos/250?image=4'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Lists Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'ListView'),
              Tab(text: 'GridView'),
              Tab(text: 'ListTile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Ejemplo de ListView
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: items[index]['imageUrl'],
                          width: 100,
                          height: 100,
                          placeholder: (context, url) => 
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => 
                              const Icon(Icons.error),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index]['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(items[index]['subtitle']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Ejemplo de GridView
            GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: items[index]['imageUrl'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => 
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => 
                              const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          items[index]['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Ejemplo de ListTile
            ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(items[index]['imageUrl']),
                  ),
                  title: Text(items[index]['title']),
                  subtitle: Text(items[index]['subtitle']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Seleccionaste ${items[index]['title']}'),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Ejecutar el Proyecto

1. **Conecta un dispositivo o inicia un emulador**

2. **Ejecuta el proyecto**:
```bash
flutter run
```

## Verificación y Pruebas

1. **Verificar que todo esté correcto**:
```bash
flutter doctor
flutter analyze
```

2. **Probar en diferentes dispositivos**:
- Emulador Android
- Dispositivo físico Android
- Chrome (web)

## Solución de Problemas Comunes

1. Si `flutter doctor` muestra errores:
   - Verifica las variables de entorno
   - Instala los componentes faltantes
   - Acepta las licencias de Android: `flutter doctor --android-licenses`

2. Si las imágenes no cargan:
   - Verifica tu conexión a internet
   - Comprueba que las URLs sean válidas
   - Verifica los permisos de internet en Android

## Recursos Adicionales

- [Documentación oficial de Flutter](https://flutter.dev/docs)
- [Widget catalog](https://flutter.dev/docs/development/ui/widgets)
- [Pub.dev (paquetes de Flutter)](https://pub.dev)
