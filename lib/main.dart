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
      title: 'Flutter Images Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Images Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ejemplo de Image.network
            const Text('Image.network básico:'),
            Image.network(
              'https://picsum.photos/250?image=9',
              width: 200,
              height: 200,
            ),
            
            const SizedBox(height: 20),
            
            // Ejemplo de CachedNetworkImage
            const Text('CachedNetworkImage:'),
            CachedNetworkImage(
              imageUrl: 'https://picsum.photos/250?image=9',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}