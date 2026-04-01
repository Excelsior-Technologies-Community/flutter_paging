import 'package:flutter/material.dart';

class PagingLoadingIndicator extends StatelessWidget {
  final EdgeInsets padding;

  const PagingLoadingIndicator({
    super.key,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PagingErrorIndicator extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetry;
  final EdgeInsets padding;

  const PagingErrorIndicator({
    super.key,
    this.error,
    required this.onRetry,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error?.toString() ?? 'Something went wrong',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class PagingNoMoreIndicator extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const PagingNoMoreIndicator({
    super.key,
    this.text = 'No more items',
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
