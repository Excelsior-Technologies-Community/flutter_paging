class PagingState<PageKeyType, ItemType> {
  final List<ItemType> items;
  final bool isLoading;
  final bool hasMore;
  final Object? error;
  final PageKeyType? pageKey;

  PagingState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.error,
    this.pageKey,
  });

  PagingState<PageKeyType, ItemType> copyWith({
    List<ItemType>? items,
    bool? isLoading,
    bool? hasMore,
    Object? error,
    bool clearError = false,
    PageKeyType? pageKey,
  }) {
    return PagingState<PageKeyType, ItemType>(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: clearError ? null : error ?? this.error,
      pageKey: pageKey ?? this.pageKey,
    );
  }

  bool get hasError => error != null;

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;
}