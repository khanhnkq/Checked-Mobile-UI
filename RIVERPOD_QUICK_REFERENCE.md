# Riverpod Migration - Quick Reference Guide

## 📚 Provider Usage Patterns

### Auth Feature

```dart
// Watch full state
final authState = ref.watch(authProvider);

// Watch specific fields (selectors)
final status = ref.watch(authStatusProvider);
final user = ref.watch(userProfileProvider);
final isAuth = ref.watch(isAuthenticatedProvider);

// Call methods
final auth = ref.read(authProvider.notifier);
await auth.login(email, password);
await auth.logout();
```

### Camera Feature

```dart
// Watch state
final camera = ref.watch(cameraProvider);

// Watch specific fields
final isReady = ref.watch(cameraInitializedProvider);
final isSending = ref.watch(isSendingProvider);

// Call methods
final cameraNotifier = ref.read(cameraProvider.notifier);
await cameraNotifier.initialize();
final xFile = await cameraNotifier.takePicture();
await cameraNotifier.flipCamera();
```

### Photo/Feed Feature

```dart
// Watch state
final photos = ref.watch(photoProvider);

// Watch specific fields
final photos = ref.watch(photosProvider);
final isLoading = ref.watch(photoIsLoadingProvider);
final hasMore = ref.watch(photoHasMoreProvider);

// Call methods
final photoNotifier = ref.read(photoProvider.notifier);
await photoNotifier.fetchPhotos();
await photoNotifier.loadMore();
photoNotifier.setFilter(PhotoFilter.me);
```

### Expense Feature

```dart
// Watch state
final expense = ref.watch(expenseProvider);

// Watch specific fields
final summary = ref.watch(expenseCurrentSummaryProvider);
final budget = ref.watch(expenseCurrentBudgetProvider);
final entries = ref.watch(expenseEntriesProvider);

// Call methods
final expenseNotifier = ref.read(expenseProvider.notifier);
await expenseNotifier.fetchMonthlyData('202603');
await expenseNotifier.updateBudget('202603', 5000000, 80);
```

---

## 🔄 Widget Type Conversions

### Watching State with Rebuild

**Old Way (Provider):**
```dart
class MyWidget extends StatelessWidget {
  build(context) {
    final provider = context.watch<AuthProvider>();
    return Text(provider.status.toString());
  }
}
```

**New Way (Riverpod):**
```dart
class MyWidget extends ConsumerWidget {
  build(context, ref) {
    final status = ref.watch(authStatusProvider);
    return Text(status.toString());
  }
}
```

### StatefulWidget with Initialization

**Old Way:**
```dart
class MyScreen extends StatefulWidget {
  createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  void initState() {
    context.read<CameraProvider>().initialize();
  }
}
```

**New Way:**
```dart
class MyScreen extends ConsumerStatefulWidget {
  createState() => _MyScreenState();
}

class _MyScreenState extends ConsumerState<MyScreen> {
  void initState() {
    ref.read(cameraProvider.notifier).initialize();
  }
}
```

---

## 💾 State Update Patterns

All state updates use `copyWith()` (immutable):

```dart
// Single field update
state = state.copyWith(status: AuthStatus.loading);

// Multiple fields
state = state.copyWith(
  isLoading: false,
  errorMessage: 'Login failed',
);

// Preserve other fields automatically
state = state.copyWith(status: AuthStatus.authenticated);
// Other fields remain unchanged
```

---

## 🎯 Common Tasks

### Initialize on Screen Load
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted) {
      ref.read(cameraProvider.notifier).initialize();
    }
  });
}
```

### Handle Async Operations
```dart
void _login() async {
  final notifier = ref.read(authProvider.notifier);
  await notifier.login(email, password);
  
  // Check result
  final authState = ref.read(authProvider);
  if (authState.status == AuthStatus.authenticated) {
    context.go('/home');
  }
}
```

### Listen to State Changes
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  ref.listen(authProvider, (previous, next) {
    if (next.status == AuthStatus.authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
    }
  });
  
  return Container();
}
```

### Conditional Rebuilds with Selectors
```dart
// Only rebuild when status changes
final status = ref.watch(
  authProvider.select((state) => state.status),
);

// Only rebuild when user profile changes
final profile = ref.watch(
  authProvider.select((state) => state.userProfile),
);
```

---

## ⚠️ Common Mistakes to Avoid

### ❌ Don't use context in async methods
```dart
// BAD
await auth.login(...);
context.go('/home'); // May fail if widget disposed

// GOOD
await auth.login(...);
if (mounted && context.mounted) {
  context.go('/home');
}
```

### ❌ Don't watch in build if not using value
```dart
// BAD - unnecessary rebuild
final fullState = ref.watch(authProvider);

// GOOD - only watch what you need
final status = ref.watch(authStatusProvider);
```

### ❌ Don't call notifier methods in build
```dart
// BAD
build(context, ref) {
  ref.read(cameraProvider.notifier).initialize(); // Runs every build!
}

// GOOD
initState() {
  ref.read(cameraProvider.notifier).initialize();
}
```

---

## 📂 File Organization

```
lib/features/{feature}/presentation/
├── riverpod_notifiers/        # New!
│   ├── {feature}_state.dart
│   └── {feature}_notifier.dart
├── riverpod_providers.dart    # New!
├── screens/
├── widgets/
├── viewmodels/                # Kept for reference
└── providers/                 # Old (deprecated)
```

---

## 🔗 Import Examples

**For Auth Features:**
```dart
import '../riverpod_providers.dart';
// Then use: authProvider, authStatusProvider, etc.
```

**For Home Features:**
```dart
import '../riverpod_providers.dart';
// Then use: cameraProvider, photoProvider, photosProvider, etc.
```

**For Expense Features:**
```dart
import '../riverpod_providers.dart';
// Then use: expenseProvider, expenseCurrentSummaryProvider, etc.
```

---

## 🧪 Testing

### Test a Notifier
```dart
test('login updates auth state', () async {
  final notifier = AuthNotifier();
  
  await notifier.login('test@example.com', 'password123');
  
  expect(notifier.state.status, AuthStatus.authenticated);
  expect(notifier.state.errorMessage, isNull);
});
```

### Test with ProviderContainer
```dart
test('login with Riverpod container', () async {
  final container = ProviderContainer();
  
  await container.read(authProvider.notifier).login('email', 'pass');
  
  expect(
    container.read(authStatusProvider),
    AuthStatus.authenticated,
  );
});
```

---

## 📈 Migration Checklist for New Screens

When migrating a new screen:

- [ ] Change `StatefulWidget` → `ConsumerStatefulWidget`
- [ ] Change `State` → `ConsumerState`
- [ ] Update imports to use `riverpod_providers.dart`
- [ ] Replace `context.watch<T>()` → `ref.watch(provider)`
- [ ] Replace `context.read<T>()` → `ref.read(provider.notifier)`
- [ ] Move `initState` logic to use `ref.read()` or `ref.listen()`
- [ ] Remove old `Provider.of<T>()` patterns
- [ ] Test with `flutter analyze` (should pass)

---

## 🔥 Pro Tips

1. **Use selector providers** for better performance
   ```dart
   final status = ref.watch(authStatusProvider); // Better than watching full state
   ```

2. **Combine listeners with navigation**
   ```dart
   ref.listen(authProvider, (prev, next) {
     if (next.isProfileIncomplete) {
       context.go('/complete-profile');
     }
   });
   ```

3. **Use `select()` for complex selectors**
   ```dart
   final hasPhotos = ref.watch(
     photoProvider.select((state) => state.photos.isNotEmpty),
   );
   ```

4. **Keep notifiers pure** - no context usage
   ```dart
   // ✅ GOOD - Notifier is pure
   class CameraNotifier extends StateNotifier<CameraState> {
     Future<void> initialize() { ... }
   }
   
   // ❌ BAD - Don't access context in notifier
   // This won't work and defeats the purpose
   ```

---

## 📞 Support & Issues

- **Flutter Analyze:** `flutter analyze` (should show 0 errors)
- **Build Runner:** `flutter pub run build_runner build --delete-conflicting-outputs`
- **Watch Mode:** `flutter pub run build_runner watch`

---

**Last Updated:** March 19, 2026  
**Migration Status:** ✅ Complete

