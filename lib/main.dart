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