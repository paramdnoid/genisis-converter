import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController(text: 'techniker@example.ch');
  final _passwordController = TextEditingController(text: 'offline-demo');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.loginTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              context.l10n.loginAccessTitle,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.loginAccessMessage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(
                labelText: context.l10n.emailFieldLabel,
                prefixIcon: const Icon(Icons.mail_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                labelText: context.l10n.passwordFieldLabel,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton.icon(
              onPressed: () => _login(context),
              icon: const Icon(Icons.check_circle_outline),
              label: Text(context.l10n.openDemoSessionAction),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: () => _login(context),
              icon: const Icon(Icons.sync_disabled),
              label: Text(context.l10n.continueOfflineAction),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final repository = ref.read(authRepositoryProvider);
    final controller = ref.read(authSessionProvider);
    await controller.login(
      repository: repository,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (context.mounted) {
      context.go(AppRoutes.initialSync);
    }
  }
}
