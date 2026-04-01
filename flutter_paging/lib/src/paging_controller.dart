// lib/src/paging_controller.dart
import 'package:flutter/foundation.dart';
import 'paging_state.dart';

class PagingController<PageKeyType, ItemType> extends ChangeNotifier {
  PagingState<PageKeyType, ItemType> _state =
  PagingState<PageKeyType, ItemType>();

  PagingState<PageKeyType, ItemType> get state => _state;

  bool _isLoading = false;

  Future<void> loadPage({
    required Future<List<ItemType>> Function(PageKeyType? pageKey) onLoad,
    required PageKeyType Function(
        List<ItemType> items,
        PageKeyType? currentKey,
        ) nextPageKey,
  }) async {
    if (_isLoading || !_state.hasMore) {
      return;
    }

    _isLoading = true;

    _state = _state.copyWith(
      isLoading: true,
      error: null,
      clearError: true,
    );
    notifyListeners();

    try {
      List<ItemType> newItems = await onLoad(_state.pageKey);

      List<ItemType> allItems = List<ItemType>.from(_state.items)
        ..addAll(newItems);

      _state = _state.copyWith(
        items: allItems,
        pageKey: newItems.isEmpty
            ? _state.pageKey
            : nextPageKey(newItems, _state.pageKey),
        hasMore: newItems.isNotEmpty,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh({
    required Future<List<ItemType>> Function(PageKeyType? pageKey) onLoad,
    required PageKeyType Function(
        List<ItemType> items,
        PageKeyType? currentKey,
        ) nextPageKey,
  }) async {
    _state = PagingState<PageKeyType, ItemType>();
    notifyListeners();

    await loadPage(
      onLoad: onLoad,
      nextPageKey: nextPageKey,
    );
  }

  void retry({
    required Future<List<ItemType>> Function(PageKeyType? pageKey) onLoad,
    required PageKeyType Function(
        List<ItemType> items,
        PageKeyType? currentKey,
        ) nextPageKey,
  }) {
    loadPage(
      onLoad: onLoad,
      nextPageKey: nextPageKey,
    );
  }

  void clear() {
    _state = PagingState<PageKeyType, ItemType>();
    notifyListeners();
  }
}
