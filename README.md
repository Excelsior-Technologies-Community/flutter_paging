# 📚 flutter_paging

```
flutter_paging is a lightweight and powerful infinite scroll pagination library for Flutter.

It helps developers easily load paginated API data, large lists, grid views and endless scrolling interfaces without writing complex scroll listeners or pagination logic.

The library provides a simple PagingController, automatic next page loading, refresh support, retry handling, loading indicators, error widgets, list view pagination and grid view pagination.

Developers can create modern, scalable and high performance pagination UIs for Android, iOS, Web and Desktop applications using a clean and reusable API.
```

---

## ✨ Features

```
- ♾ Infinite scroll pagination
- 📄 PagingController for page management
- 📦 PagingState for loading, error and data states
- 📃 PagingListView with automatic load more
- 🟦 PagingGridView with automatic load more
- 🔄 Pull to refresh and manual refresh support
- ⚠️ Built-in retry and error handling
- ⏳ Loading indicator widget
- 🚫 No more items indicator
- 🧩 Custom builder support with PagingBuilder
- ⚡ Lightweight and easy to use
- 🌐 Supports Android, iOS, Web & Desktop
```

---

## 📦 Installation

Add dependency in your `pubspec.yaml`

```
dependencies:
  flutter_paging:
    path: https://github.com/Excelsior-Technologies-Community/flutter_paging/tree/stage
```

Then run:

```
flutter pub get
```

---

## 🎬 Preview



---

## 🗂 File Structure

```
flutter_paging/
│
├─ lib/
│   ├─ flutter_paging.dart
│   │   // Main export file
│   │
│   ├─ main.dart
│   │   // Example application
│   │
│   └─ src/
│       ├─ paging_controller.dart
│       │   // Handles page loading and refresh
│       │
│       ├─ paging_state.dart
│       │   // Stores items, loading, error and page key
│       │
│       ├─ paging_builder.dart
│       │   // Builder widget for custom paging UI
│       │
│       ├─ paging_list_view.dart
│       │   // Infinite scrolling ListView widget
│       │
│       ├─ paging_grid_view.dart
│       │   // Infinite scrolling GridView widget
│       │
│       └─ paging_indicator.dart
│           // Loading, error and no-more widgets
│ 
├─ README.md
│   // Package documentation
│
├─ LICENSE
│   // Open source license file
│
└─ pubspec.yaml
│   // Package configuration file
```

---

## 🚀 How To Use

### 1️⃣ Import Package

```
import 'package:flutter_paging/flutter_paging.dart';
```

---

### 2️⃣ Create Controller

```
final PagingController<int, String> controller =
    PagingController<int, String>();
```

---

### 3️⃣ Create Load Function

```
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
```

---

### 4️⃣ Create Next Page Key

```
int nextPageKey(List<String> items, int? currentKey) {
  return (currentKey ?? 1) + 1;
}
```

---

### 5️⃣ Use PagingListView

```
PagingListView<int, String>(
  controller: controller,
  onLoad: loadItems,
  nextPageKey: nextPageKey,
  itemBuilder: (context, item, index) {
    return ListTile(
      title: Text(item),
    );
  },
)
```

---

### 6️⃣ Use PagingGridView

```
PagingGridView<int, String>(
  controller: controller,
  onLoad: loadItems,
  nextPageKey: nextPageKey,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  itemBuilder: (context, item, index) {
    return Card(
      child: Center(
        child: Text(item),
      ),
    );
  },
)
```

---

### 7️⃣ Refresh Data

```
controller.refresh(
  onLoad: loadItems,
  nextPageKey: nextPageKey,
);
```

---

### 8️⃣ Retry On Error

```
controller.retry(
  onLoad: loadItems,
  nextPageKey: nextPageKey,
);
```

---

## 🎨 Available Widgets

| Widget                   | Description                          |
| ------------------------ | ------------------------------------ |
| `PagingController`       | Controls page loading and refresh    |
| `PagingState`            | Stores current pagination state      |
| `PagingBuilder`          | Creates custom pagination UI         |
| `PagingListView`         | Infinite scrolling ListView          |
| `PagingGridView`         | Infinite scrolling GridView          |
| `PagingLoadingIndicator` | Loading spinner widget               |
| `PagingErrorIndicator`   | Error widget with retry button       |
| `PagingNoMoreIndicator`  | Shows when no more data is available |

---

## 🧪 Full Example

```
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
      home: PagingExamplePage(),
    );
  }
}

class PagingExamplePage extends StatefulWidget {
  @override
  State<PagingExamplePage> createState() => _PagingExamplePageState();
}

class _PagingExamplePageState extends State<PagingExamplePage> {
  final PagingController<int, String> controller =
      PagingController<int, String>();

  Future<List<String>> loadItems(int? pageKey) async {
    await Future.delayed(const Duration(seconds: 1));

    int currentPage = pageKey ?? 1;

    if (currentPage > 3) {
      return [];
    }

    return List.generate(
      10,
      (index) => 'Item ${(currentPage - 1) * 10 + index + 1}',
    );
  }

  int nextPageKey(List<String> items, int? currentKey) {
    return (currentKey ?? 1) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Paging'),
      ),
      body: PagingListView<int, String>(
        controller: controller,
        onLoad: loadItems,
        nextPageKey: nextPageKey,
        itemBuilder: (context, item, index) {
          return Card(
            child: ListTile(
              title: Text(item),
            ),
          );
        },
      ),
    );
  }
}
```

---

## 📄 MIT License

```
Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files to deal in the Software without restriction.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
```
