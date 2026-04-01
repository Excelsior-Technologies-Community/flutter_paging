import 'package:flutter/material.dart';
import 'paging_controller.dart';
import 'paging_indicator.dart';

class PagingGridView<PageKeyType, ItemType> extends StatefulWidget {
  final PagingController<PageKeyType, ItemType> controller;
  final Future<List<ItemType>> Function(PageKeyType? pageKey) onLoad;
  final PageKeyType Function(
      List<ItemType> items,
      PageKeyType? currentKey,
      ) nextPageKey;
  final Widget Function(
      BuildContext context,
      ItemType item,
      int index,
      ) itemBuilder;
  final SliverGridDelegate gridDelegate;
  final EdgeInsets padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Widget? loadingIndicator;
  final Widget? noMoreIndicator;

  const PagingGridView({
    super.key,
    required this.controller,
    required this.onLoad,
    required this.nextPageKey,
    required this.itemBuilder,
    required this.gridDelegate,
    this.padding = EdgeInsets.zero,
    this.physics,
    this.shrinkWrap = false,
    this.loadingIndicator,
    this.noMoreIndicator,
  });

  @override
  State<PagingGridView<PageKeyType, ItemType>> createState() =>
      _PagingGridViewState<PageKeyType, ItemType>();
}

class _PagingGridViewState<PageKeyType, ItemType>
    extends State<PagingGridView<PageKeyType, ItemType>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    if (widget.controller.state.items.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.controller.loadPage(
          onLoad: widget.onLoad,
          nextPageKey: widget.nextPageKey,
        );
      });
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 200) {
      widget.controller.loadPage(
        onLoad: widget.onLoad,
        nextPageKey: widget.nextPageKey,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final state = widget.controller.state;

        if (state.isLoading && state.items.isEmpty) {
          return widget.loadingIndicator ??
              const PagingLoadingIndicator();
        }

        if (state.hasError && state.items.isEmpty) {
          return PagingErrorIndicator(
            error: state.error,
            onRetry: () {
              widget.controller.retry(
                onLoad: widget.onLoad,
                nextPageKey: widget.nextPageKey,
              );
            },
          );
        }

        return GridView.builder(
          controller: _scrollController,
          padding: widget.padding,
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap,
          gridDelegate: widget.gridDelegate,
          itemCount: state.items.length + 1,
          itemBuilder: (context, index) {
            if (index < state.items.length) {
              return widget.itemBuilder(
                context,
                state.items[index],
                index,
              );
            }

            if (state.isLoading) {
              return widget.loadingIndicator ??
                  const PagingLoadingIndicator();
            }

            if (!state.hasMore) {
              return widget.noMoreIndicator ??
                  const PagingNoMoreIndicator();
            }

            return const SizedBox();
          },
        );
      },
    );
  }
}