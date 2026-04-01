import 'package:flutter/material.dart';
import 'package:flutter_paging/flutter_paging.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Paging Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PagingExamplePage(),
    );
  }
}

class PagingExamplePage extends StatefulWidget {
  const PagingExamplePage({super.key});

  @override
  State<PagingExamplePage> createState() => _PagingExamplePageState();
}

class _PagingExamplePageState extends State<PagingExamplePage> {
  final PagingController<int, String> controller =
  PagingController<int, String>();

  Future<List<String>> loadItems(int? pageKey) async {
    await Future.delayed(const Duration(seconds: 1));

    int currentPage = pageKey ?? 1;

    if (currentPage > 5) {
      return [];
    }

    return List.generate(
      20,
          (index) => 'Item ${(currentPage - 1) * 20 + index + 1}',
    );
  }

  int nextPageKey(List<String> items, int? currentKey) {
    return (currentKey ?? 1) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade200,
        title: Text('Flutter Paging',style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.grey.shade100,
      body: PagingListView<int, String>(
        controller: controller,
        onLoad: loadItems,
        nextPageKey: nextPageKey,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, item, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(item),
              subtitle: const Text('Infinite scroll item'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.refresh(
            onLoad: loadItems,
            nextPageKey: nextPageKey,
          );
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
