import 'package:flutter/material.dart';
import 'paging_controller.dart';
import 'paging_indicator.dart';

class PagingBuilder<PageKeyType, ItemType> extends StatefulWidget {
  final PagingController<PageKeyType, ItemType> controller;
  final Future<List<ItemType>> Function(PageKeyType? pageKey) onLoad;
  final PageKeyType Function(
      List<ItemType> items,
      PageKeyType? currentKey,
      ) nextPageKey;
  final Widget Function(
      BuildContext context,
      List<ItemType> items,
      ) builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;

  const PagingBuilder({
    super.key,
    required this.controller,
    required this.onLoad,
    required this.nextPageKey,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
  });

  @override
  State<PagingBuilder<PageKeyType, ItemType>> createState() =>
      _PagingBuilderState<PageKeyType, ItemType>();
}

class _PagingBuilderState<PageKeyType, ItemType>
    extends State<PagingBuilder<PageKeyType, ItemType>> {
  @override
  void initState() {
    super.initState();

    if (widget.controller.state.items.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.controller.loadPage(
          onLoad: widget.onLoad,
          nextPageKey: widget.nextPageKey,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final state = widget.controller.state;

        if (state.isLoading && state.items.isEmpty) {
          return widget.loadingWidget ??
              const Center(
                child: CircularProgressIndicator(),
              );
        }

        if (state.hasError && state.items.isEmpty) {
          return widget.errorWidget ??
              PagingErrorIndicator(
                error: state.error,
                onRetry: () {
                  widget.controller.retry(
                    onLoad: widget.onLoad,
                    nextPageKey: widget.nextPageKey,
                  );
                },
              );
        }

        if (state.items.isEmpty) {
          return widget.emptyWidget ??
              const Center(
                child: Text('No data found'),
              );
        }

        return widget.builder(context, state.items);
      },
    );
  }
}
