import 'package:flutter/material.dart';
import '../network/api_exception.dart';
import '../utils/responsive.dart';

class ErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const ErrorView({
    super.key,
    required this.error,
    required this.onRetry,
  });

  bool _isNetworkError(Object error) {
    if (error is ApiException) {
      return error.message.toLowerCase().contains('no internet') || 
             error.message.toLowerCase().contains('connection') ||
             error.message.toLowerCase().contains('host lookup');
    }
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('socketexception') ||
        errorStr.contains('failed host lookup') ||
        errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('no internet');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNetwork = _isNetworkError(error);
    
    final title = isNetwork ? 'No Internet Connection' : 'Something went wrong';
    final subtitle = isNetwork 
        ? 'Please check your connection and try again.'
        : 'An unexpected error occurred. Please try again.';
    final icon = isNetwork ? Icons.wifi_off_rounded : Icons.error_outline_rounded;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Responsive.maxContentWidth(context),
        ),
        child: Padding(
          padding: EdgeInsets.all(Responsive.contentPadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 54,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text(
                'Retry',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: onRetry,
            ),
          ],
          ),
        ),
      ),
    );
  }
}
