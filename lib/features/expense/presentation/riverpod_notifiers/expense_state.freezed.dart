// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExpenseState {
  List<ExpenseCategory> get categories => throw _privateConstructorUsedError;
  ExpenseSummary? get currentSummary => throw _privateConstructorUsedError;
  CashflowSummary? get currentCashflow => throw _privateConstructorUsedError;
  MonthlyBudget? get currentBudget => throw _privateConstructorUsedError;
  List<ExpenseEntry> get entries => throw _privateConstructorUsedError;
  Map<TransactionType, List<ExpenseEntry>> get entriesByType =>
      throw _privateConstructorUsedError;
  TransactionType get selectedType => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseStateCopyWith<ExpenseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseStateCopyWith<$Res> {
  factory $ExpenseStateCopyWith(
    ExpenseState value,
    $Res Function(ExpenseState) then,
  ) = _$ExpenseStateCopyWithImpl<$Res, ExpenseState>;
  @useResult
  $Res call({
    List<ExpenseCategory> categories,
    ExpenseSummary? currentSummary,
    CashflowSummary? currentCashflow,
    MonthlyBudget? currentBudget,
    List<ExpenseEntry> entries,
    Map<TransactionType, List<ExpenseEntry>> entriesByType,
    TransactionType selectedType,
    bool isLoading,
    String? errorMessage,
  });

  $ExpenseSummaryCopyWith<$Res>? get currentSummary;
  $CashflowSummaryCopyWith<$Res>? get currentCashflow;
  $MonthlyBudgetCopyWith<$Res>? get currentBudget;
}

/// @nodoc
class _$ExpenseStateCopyWithImpl<$Res, $Val extends ExpenseState>
    implements $ExpenseStateCopyWith<$Res> {
  _$ExpenseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? currentSummary = freezed,
    Object? currentCashflow = freezed,
    Object? currentBudget = freezed,
    Object? entries = null,
    Object? entriesByType = null,
    Object? selectedType = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<ExpenseCategory>,
            currentSummary: freezed == currentSummary
                ? _value.currentSummary
                : currentSummary // ignore: cast_nullable_to_non_nullable
                      as ExpenseSummary?,
            currentCashflow: freezed == currentCashflow
                ? _value.currentCashflow
                : currentCashflow // ignore: cast_nullable_to_non_nullable
                      as CashflowSummary?,
            currentBudget: freezed == currentBudget
                ? _value.currentBudget
                : currentBudget // ignore: cast_nullable_to_non_nullable
                      as MonthlyBudget?,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<ExpenseEntry>,
            entriesByType: null == entriesByType
                ? _value.entriesByType
                : entriesByType // ignore: cast_nullable_to_non_nullable
                      as Map<TransactionType, List<ExpenseEntry>>,
            selectedType: null == selectedType
                ? _value.selectedType
                : selectedType // ignore: cast_nullable_to_non_nullable
                      as TransactionType,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpenseSummaryCopyWith<$Res>? get currentSummary {
    if (_value.currentSummary == null) {
      return null;
    }

    return $ExpenseSummaryCopyWith<$Res>(_value.currentSummary!, (value) {
      return _then(_value.copyWith(currentSummary: value) as $Val);
    });
  }

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CashflowSummaryCopyWith<$Res>? get currentCashflow {
    if (_value.currentCashflow == null) {
      return null;
    }

    return $CashflowSummaryCopyWith<$Res>(_value.currentCashflow!, (value) {
      return _then(_value.copyWith(currentCashflow: value) as $Val);
    });
  }

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MonthlyBudgetCopyWith<$Res>? get currentBudget {
    if (_value.currentBudget == null) {
      return null;
    }

    return $MonthlyBudgetCopyWith<$Res>(_value.currentBudget!, (value) {
      return _then(_value.copyWith(currentBudget: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExpenseStateImplCopyWith<$Res>
    implements $ExpenseStateCopyWith<$Res> {
  factory _$$ExpenseStateImplCopyWith(
    _$ExpenseStateImpl value,
    $Res Function(_$ExpenseStateImpl) then,
  ) = __$$ExpenseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ExpenseCategory> categories,
    ExpenseSummary? currentSummary,
    CashflowSummary? currentCashflow,
    MonthlyBudget? currentBudget,
    List<ExpenseEntry> entries,
    Map<TransactionType, List<ExpenseEntry>> entriesByType,
    TransactionType selectedType,
    bool isLoading,
    String? errorMessage,
  });

  @override
  $ExpenseSummaryCopyWith<$Res>? get currentSummary;
  @override
  $CashflowSummaryCopyWith<$Res>? get currentCashflow;
  @override
  $MonthlyBudgetCopyWith<$Res>? get currentBudget;
}

/// @nodoc
class __$$ExpenseStateImplCopyWithImpl<$Res>
    extends _$ExpenseStateCopyWithImpl<$Res, _$ExpenseStateImpl>
    implements _$$ExpenseStateImplCopyWith<$Res> {
  __$$ExpenseStateImplCopyWithImpl(
    _$ExpenseStateImpl _value,
    $Res Function(_$ExpenseStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? currentSummary = freezed,
    Object? currentCashflow = freezed,
    Object? currentBudget = freezed,
    Object? entries = null,
    Object? entriesByType = null,
    Object? selectedType = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ExpenseStateImpl(
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<ExpenseCategory>,
        currentSummary: freezed == currentSummary
            ? _value.currentSummary
            : currentSummary // ignore: cast_nullable_to_non_nullable
                  as ExpenseSummary?,
        currentCashflow: freezed == currentCashflow
            ? _value.currentCashflow
            : currentCashflow // ignore: cast_nullable_to_non_nullable
                  as CashflowSummary?,
        currentBudget: freezed == currentBudget
            ? _value.currentBudget
            : currentBudget // ignore: cast_nullable_to_non_nullable
                  as MonthlyBudget?,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<ExpenseEntry>,
        entriesByType: null == entriesByType
            ? _value._entriesByType
            : entriesByType // ignore: cast_nullable_to_non_nullable
                  as Map<TransactionType, List<ExpenseEntry>>,
        selectedType: null == selectedType
            ? _value.selectedType
            : selectedType // ignore: cast_nullable_to_non_nullable
                  as TransactionType,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ExpenseStateImpl implements _ExpenseState {
  const _$ExpenseStateImpl({
    final List<ExpenseCategory> categories = const [],
    this.currentSummary,
    this.currentCashflow,
    this.currentBudget,
    final List<ExpenseEntry> entries = const [],
    final Map<TransactionType, List<ExpenseEntry>> entriesByType = const {},
    this.selectedType = TransactionType.expense,
    this.isLoading = false,
    this.errorMessage,
  }) : _categories = categories,
       _entries = entries,
       _entriesByType = entriesByType;

  final List<ExpenseCategory> _categories;
  @override
  @JsonKey()
  List<ExpenseCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final ExpenseSummary? currentSummary;
  @override
  final CashflowSummary? currentCashflow;
  @override
  final MonthlyBudget? currentBudget;
  final List<ExpenseEntry> _entries;
  @override
  @JsonKey()
  List<ExpenseEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  final Map<TransactionType, List<ExpenseEntry>> _entriesByType;
  @override
  @JsonKey()
  Map<TransactionType, List<ExpenseEntry>> get entriesByType {
    if (_entriesByType is EqualUnmodifiableMapView) return _entriesByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_entriesByType);
  }

  @override
  @JsonKey()
  final TransactionType selectedType;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ExpenseState(categories: $categories, currentSummary: $currentSummary, currentCashflow: $currentCashflow, currentBudget: $currentBudget, entries: $entries, entriesByType: $entriesByType, selectedType: $selectedType, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseStateImpl &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.currentSummary, currentSummary) ||
                other.currentSummary == currentSummary) &&
            (identical(other.currentCashflow, currentCashflow) ||
                other.currentCashflow == currentCashflow) &&
            (identical(other.currentBudget, currentBudget) ||
                other.currentBudget == currentBudget) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            const DeepCollectionEquality().equals(
              other._entriesByType,
              _entriesByType,
            ) &&
            (identical(other.selectedType, selectedType) ||
                other.selectedType == selectedType) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_categories),
    currentSummary,
    currentCashflow,
    currentBudget,
    const DeepCollectionEquality().hash(_entries),
    const DeepCollectionEquality().hash(_entriesByType),
    selectedType,
    isLoading,
    errorMessage,
  );

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseStateImplCopyWith<_$ExpenseStateImpl> get copyWith =>
      __$$ExpenseStateImplCopyWithImpl<_$ExpenseStateImpl>(this, _$identity);
}

abstract class _ExpenseState implements ExpenseState {
  const factory _ExpenseState({
    final List<ExpenseCategory> categories,
    final ExpenseSummary? currentSummary,
    final CashflowSummary? currentCashflow,
    final MonthlyBudget? currentBudget,
    final List<ExpenseEntry> entries,
    final Map<TransactionType, List<ExpenseEntry>> entriesByType,
    final TransactionType selectedType,
    final bool isLoading,
    final String? errorMessage,
  }) = _$ExpenseStateImpl;

  @override
  List<ExpenseCategory> get categories;
  @override
  ExpenseSummary? get currentSummary;
  @override
  CashflowSummary? get currentCashflow;
  @override
  MonthlyBudget? get currentBudget;
  @override
  List<ExpenseEntry> get entries;
  @override
  Map<TransactionType, List<ExpenseEntry>> get entriesByType;
  @override
  TransactionType get selectedType;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseStateImplCopyWith<_$ExpenseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
