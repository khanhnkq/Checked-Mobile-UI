// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExpenseCategory _$ExpenseCategoryFromJson(Map<String, dynamic> json) {
  return _ExpenseCategory.fromJson(json);
}

/// @nodoc
mixin _$ExpenseCategory {
  @JsonKey(defaultValue: '')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'Chưa rõ')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get icon => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '#FFFFFF')
  String get color => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isDefault => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: true)
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this ExpenseCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseCategoryCopyWith<ExpenseCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCategoryCopyWith<$Res> {
  factory $ExpenseCategoryCopyWith(
    ExpenseCategory value,
    $Res Function(ExpenseCategory) then,
  ) = _$ExpenseCategoryCopyWithImpl<$Res, ExpenseCategory>;
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String id,
    @JsonKey(defaultValue: 'Chưa rõ') String name,
    @JsonKey(defaultValue: '') String icon,
    @JsonKey(defaultValue: '#FFFFFF') String color,
    @JsonKey(defaultValue: false) bool isDefault,
    @JsonKey(defaultValue: true) bool isActive,
  });
}

/// @nodoc
class _$ExpenseCategoryCopyWithImpl<$Res, $Val extends ExpenseCategory>
    implements $ExpenseCategoryCopyWith<$Res> {
  _$ExpenseCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? color = null,
    Object? isDefault = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseCategoryImplCopyWith<$Res>
    implements $ExpenseCategoryCopyWith<$Res> {
  factory _$$ExpenseCategoryImplCopyWith(
    _$ExpenseCategoryImpl value,
    $Res Function(_$ExpenseCategoryImpl) then,
  ) = __$$ExpenseCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String id,
    @JsonKey(defaultValue: 'Chưa rõ') String name,
    @JsonKey(defaultValue: '') String icon,
    @JsonKey(defaultValue: '#FFFFFF') String color,
    @JsonKey(defaultValue: false) bool isDefault,
    @JsonKey(defaultValue: true) bool isActive,
  });
}

/// @nodoc
class __$$ExpenseCategoryImplCopyWithImpl<$Res>
    extends _$ExpenseCategoryCopyWithImpl<$Res, _$ExpenseCategoryImpl>
    implements _$$ExpenseCategoryImplCopyWith<$Res> {
  __$$ExpenseCategoryImplCopyWithImpl(
    _$ExpenseCategoryImpl _value,
    $Res Function(_$ExpenseCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? color = null,
    Object? isDefault = null,
    Object? isActive = null,
  }) {
    return _then(
      _$ExpenseCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseCategoryImpl implements _ExpenseCategory {
  const _$ExpenseCategoryImpl({
    @JsonKey(defaultValue: '') required this.id,
    @JsonKey(defaultValue: 'Chưa rõ') required this.name,
    @JsonKey(defaultValue: '') required this.icon,
    @JsonKey(defaultValue: '#FFFFFF') required this.color,
    @JsonKey(defaultValue: false) required this.isDefault,
    @JsonKey(defaultValue: true) required this.isActive,
  });

  factory _$ExpenseCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseCategoryImplFromJson(json);

  @override
  @JsonKey(defaultValue: '')
  final String id;
  @override
  @JsonKey(defaultValue: 'Chưa rõ')
  final String name;
  @override
  @JsonKey(defaultValue: '')
  final String icon;
  @override
  @JsonKey(defaultValue: '#FFFFFF')
  final String color;
  @override
  @JsonKey(defaultValue: false)
  final bool isDefault;
  @override
  @JsonKey(defaultValue: true)
  final bool isActive;

  @override
  String toString() {
    return 'ExpenseCategory(id: $id, name: $name, icon: $icon, color: $color, isDefault: $isDefault, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, icon, color, isDefault, isActive);

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseCategoryImplCopyWith<_$ExpenseCategoryImpl> get copyWith =>
      __$$ExpenseCategoryImplCopyWithImpl<_$ExpenseCategoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseCategoryImplToJson(this);
  }
}

abstract class _ExpenseCategory implements ExpenseCategory {
  const factory _ExpenseCategory({
    @JsonKey(defaultValue: '') required final String id,
    @JsonKey(defaultValue: 'Chưa rõ') required final String name,
    @JsonKey(defaultValue: '') required final String icon,
    @JsonKey(defaultValue: '#FFFFFF') required final String color,
    @JsonKey(defaultValue: false) required final bool isDefault,
    @JsonKey(defaultValue: true) required final bool isActive,
  }) = _$ExpenseCategoryImpl;

  factory _ExpenseCategory.fromJson(Map<String, dynamic> json) =
      _$ExpenseCategoryImpl.fromJson;

  @override
  @JsonKey(defaultValue: '')
  String get id;
  @override
  @JsonKey(defaultValue: 'Chưa rõ')
  String get name;
  @override
  @JsonKey(defaultValue: '')
  String get icon;
  @override
  @JsonKey(defaultValue: '#FFFFFF')
  String get color;
  @override
  @JsonKey(defaultValue: false)
  bool get isDefault;
  @override
  @JsonKey(defaultValue: true)
  bool get isActive;

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseCategoryImplCopyWith<_$ExpenseCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyBudget _$MonthlyBudgetFromJson(Map<String, dynamic> json) {
  return _MonthlyBudget.fromJson(json);
}

/// @nodoc
mixin _$MonthlyBudget {
  @JsonKey(defaultValue: '')
  String get monthKey => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toNullableDouble)
  double? get amountLimit => throw _privateConstructorUsedError;
  int? get alertThresholdPct => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDoubleOrZero)
  double get spent => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toNullableDouble)
  double? get remaining => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get exceeded => throw _privateConstructorUsedError;

  /// Serializes this MonthlyBudget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyBudgetCopyWith<MonthlyBudget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyBudgetCopyWith<$Res> {
  factory $MonthlyBudgetCopyWith(
    MonthlyBudget value,
    $Res Function(MonthlyBudget) then,
  ) = _$MonthlyBudgetCopyWithImpl<$Res, MonthlyBudget>;
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String monthKey,
    @JsonKey(fromJson: _toNullableDouble) double? amountLimit,
    int? alertThresholdPct,
    @JsonKey(fromJson: _toDoubleOrZero) double spent,
    @JsonKey(fromJson: _toNullableDouble) double? remaining,
    @JsonKey(defaultValue: false) bool exceeded,
  });
}

/// @nodoc
class _$MonthlyBudgetCopyWithImpl<$Res, $Val extends MonthlyBudget>
    implements $MonthlyBudgetCopyWith<$Res> {
  _$MonthlyBudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? amountLimit = freezed,
    Object? alertThresholdPct = freezed,
    Object? spent = null,
    Object? remaining = freezed,
    Object? exceeded = null,
  }) {
    return _then(
      _value.copyWith(
            monthKey: null == monthKey
                ? _value.monthKey
                : monthKey // ignore: cast_nullable_to_non_nullable
                      as String,
            amountLimit: freezed == amountLimit
                ? _value.amountLimit
                : amountLimit // ignore: cast_nullable_to_non_nullable
                      as double?,
            alertThresholdPct: freezed == alertThresholdPct
                ? _value.alertThresholdPct
                : alertThresholdPct // ignore: cast_nullable_to_non_nullable
                      as int?,
            spent: null == spent
                ? _value.spent
                : spent // ignore: cast_nullable_to_non_nullable
                      as double,
            remaining: freezed == remaining
                ? _value.remaining
                : remaining // ignore: cast_nullable_to_non_nullable
                      as double?,
            exceeded: null == exceeded
                ? _value.exceeded
                : exceeded // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyBudgetImplCopyWith<$Res>
    implements $MonthlyBudgetCopyWith<$Res> {
  factory _$$MonthlyBudgetImplCopyWith(
    _$MonthlyBudgetImpl value,
    $Res Function(_$MonthlyBudgetImpl) then,
  ) = __$$MonthlyBudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String monthKey,
    @JsonKey(fromJson: _toNullableDouble) double? amountLimit,
    int? alertThresholdPct,
    @JsonKey(fromJson: _toDoubleOrZero) double spent,
    @JsonKey(fromJson: _toNullableDouble) double? remaining,
    @JsonKey(defaultValue: false) bool exceeded,
  });
}

/// @nodoc
class __$$MonthlyBudgetImplCopyWithImpl<$Res>
    extends _$MonthlyBudgetCopyWithImpl<$Res, _$MonthlyBudgetImpl>
    implements _$$MonthlyBudgetImplCopyWith<$Res> {
  __$$MonthlyBudgetImplCopyWithImpl(
    _$MonthlyBudgetImpl _value,
    $Res Function(_$MonthlyBudgetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? amountLimit = freezed,
    Object? alertThresholdPct = freezed,
    Object? spent = null,
    Object? remaining = freezed,
    Object? exceeded = null,
  }) {
    return _then(
      _$MonthlyBudgetImpl(
        monthKey: null == monthKey
            ? _value.monthKey
            : monthKey // ignore: cast_nullable_to_non_nullable
                  as String,
        amountLimit: freezed == amountLimit
            ? _value.amountLimit
            : amountLimit // ignore: cast_nullable_to_non_nullable
                  as double?,
        alertThresholdPct: freezed == alertThresholdPct
            ? _value.alertThresholdPct
            : alertThresholdPct // ignore: cast_nullable_to_non_nullable
                  as int?,
        spent: null == spent
            ? _value.spent
            : spent // ignore: cast_nullable_to_non_nullable
                  as double,
        remaining: freezed == remaining
            ? _value.remaining
            : remaining // ignore: cast_nullable_to_non_nullable
                  as double?,
        exceeded: null == exceeded
            ? _value.exceeded
            : exceeded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyBudgetImpl implements _MonthlyBudget {
  const _$MonthlyBudgetImpl({
    @JsonKey(defaultValue: '') required this.monthKey,
    @JsonKey(fromJson: _toNullableDouble) this.amountLimit,
    this.alertThresholdPct,
    @JsonKey(fromJson: _toDoubleOrZero) required this.spent,
    @JsonKey(fromJson: _toNullableDouble) this.remaining,
    @JsonKey(defaultValue: false) required this.exceeded,
  });

  factory _$MonthlyBudgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyBudgetImplFromJson(json);

  @override
  @JsonKey(defaultValue: '')
  final String monthKey;
  @override
  @JsonKey(fromJson: _toNullableDouble)
  final double? amountLimit;
  @override
  final int? alertThresholdPct;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  final double spent;
  @override
  @JsonKey(fromJson: _toNullableDouble)
  final double? remaining;
  @override
  @JsonKey(defaultValue: false)
  final bool exceeded;

  @override
  String toString() {
    return 'MonthlyBudget(monthKey: $monthKey, amountLimit: $amountLimit, alertThresholdPct: $alertThresholdPct, spent: $spent, remaining: $remaining, exceeded: $exceeded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyBudgetImpl &&
            (identical(other.monthKey, monthKey) ||
                other.monthKey == monthKey) &&
            (identical(other.amountLimit, amountLimit) ||
                other.amountLimit == amountLimit) &&
            (identical(other.alertThresholdPct, alertThresholdPct) ||
                other.alertThresholdPct == alertThresholdPct) &&
            (identical(other.spent, spent) || other.spent == spent) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.exceeded, exceeded) ||
                other.exceeded == exceeded));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    monthKey,
    amountLimit,
    alertThresholdPct,
    spent,
    remaining,
    exceeded,
  );

  /// Create a copy of MonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyBudgetImplCopyWith<_$MonthlyBudgetImpl> get copyWith =>
      __$$MonthlyBudgetImplCopyWithImpl<_$MonthlyBudgetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyBudgetImplToJson(this);
  }
}

abstract class _MonthlyBudget implements MonthlyBudget {
  const factory _MonthlyBudget({
    @JsonKey(defaultValue: '') required final String monthKey,
    @JsonKey(fromJson: _toNullableDouble) final double? amountLimit,
    final int? alertThresholdPct,
    @JsonKey(fromJson: _toDoubleOrZero) required final double spent,
    @JsonKey(fromJson: _toNullableDouble) final double? remaining,
    @JsonKey(defaultValue: false) required final bool exceeded,
  }) = _$MonthlyBudgetImpl;

  factory _MonthlyBudget.fromJson(Map<String, dynamic> json) =
      _$MonthlyBudgetImpl.fromJson;

  @override
  @JsonKey(defaultValue: '')
  String get monthKey;
  @override
  @JsonKey(fromJson: _toNullableDouble)
  double? get amountLimit;
  @override
  int? get alertThresholdPct;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  double get spent;
  @override
  @JsonKey(fromJson: _toNullableDouble)
  double? get remaining;
  @override
  @JsonKey(defaultValue: false)
  bool get exceeded;

  /// Create a copy of MonthlyBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyBudgetImplCopyWith<_$MonthlyBudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpenseSummary _$ExpenseSummaryFromJson(Map<String, dynamic> json) {
  return _ExpenseSummary.fromJson(json);
}

/// @nodoc
mixin _$ExpenseSummary {
  @JsonKey(defaultValue: '')
  String get monthKey => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDoubleOrZero)
  double get totalSpent => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toNullableDouble)
  double? get budgetLimit => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toNullableDouble)
  double? get remaining => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get budgetExceeded => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDoubleOrZero)
  double get percentUsed => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: <CategorySummary>[])
  List<CategorySummary> get byCategory => throw _privateConstructorUsedError;

  /// Serializes this ExpenseSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseSummaryCopyWith<ExpenseSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseSummaryCopyWith<$Res> {
  factory $ExpenseSummaryCopyWith(
    ExpenseSummary value,
    $Res Function(ExpenseSummary) then,
  ) = _$ExpenseSummaryCopyWithImpl<$Res, ExpenseSummary>;
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String monthKey,
    @JsonKey(fromJson: _toDoubleOrZero) double totalSpent,
    @JsonKey(fromJson: _toNullableDouble) double? budgetLimit,
    @JsonKey(fromJson: _toNullableDouble) double? remaining,
    @JsonKey(defaultValue: false) bool budgetExceeded,
    @JsonKey(fromJson: _toDoubleOrZero) double percentUsed,
    @JsonKey(defaultValue: <CategorySummary>[])
    List<CategorySummary> byCategory,
  });
}

/// @nodoc
class _$ExpenseSummaryCopyWithImpl<$Res, $Val extends ExpenseSummary>
    implements $ExpenseSummaryCopyWith<$Res> {
  _$ExpenseSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? totalSpent = null,
    Object? budgetLimit = freezed,
    Object? remaining = freezed,
    Object? budgetExceeded = null,
    Object? percentUsed = null,
    Object? byCategory = null,
  }) {
    return _then(
      _value.copyWith(
            monthKey: null == monthKey
                ? _value.monthKey
                : monthKey // ignore: cast_nullable_to_non_nullable
                      as String,
            totalSpent: null == totalSpent
                ? _value.totalSpent
                : totalSpent // ignore: cast_nullable_to_non_nullable
                      as double,
            budgetLimit: freezed == budgetLimit
                ? _value.budgetLimit
                : budgetLimit // ignore: cast_nullable_to_non_nullable
                      as double?,
            remaining: freezed == remaining
                ? _value.remaining
                : remaining // ignore: cast_nullable_to_non_nullable
                      as double?,
            budgetExceeded: null == budgetExceeded
                ? _value.budgetExceeded
                : budgetExceeded // ignore: cast_nullable_to_non_nullable
                      as bool,
            percentUsed: null == percentUsed
                ? _value.percentUsed
                : percentUsed // ignore: cast_nullable_to_non_nullable
                      as double,
            byCategory: null == byCategory
                ? _value.byCategory
                : byCategory // ignore: cast_nullable_to_non_nullable
                      as List<CategorySummary>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseSummaryImplCopyWith<$Res>
    implements $ExpenseSummaryCopyWith<$Res> {
  factory _$$ExpenseSummaryImplCopyWith(
    _$ExpenseSummaryImpl value,
    $Res Function(_$ExpenseSummaryImpl) then,
  ) = __$$ExpenseSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String monthKey,
    @JsonKey(fromJson: _toDoubleOrZero) double totalSpent,
    @JsonKey(fromJson: _toNullableDouble) double? budgetLimit,
    @JsonKey(fromJson: _toNullableDouble) double? remaining,
    @JsonKey(defaultValue: false) bool budgetExceeded,
    @JsonKey(fromJson: _toDoubleOrZero) double percentUsed,
    @JsonKey(defaultValue: <CategorySummary>[])
    List<CategorySummary> byCategory,
  });
}

/// @nodoc
class __$$ExpenseSummaryImplCopyWithImpl<$Res>
    extends _$ExpenseSummaryCopyWithImpl<$Res, _$ExpenseSummaryImpl>
    implements _$$ExpenseSummaryImplCopyWith<$Res> {
  __$$ExpenseSummaryImplCopyWithImpl(
    _$ExpenseSummaryImpl _value,
    $Res Function(_$ExpenseSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthKey = null,
    Object? totalSpent = null,
    Object? budgetLimit = freezed,
    Object? remaining = freezed,
    Object? budgetExceeded = null,
    Object? percentUsed = null,
    Object? byCategory = null,
  }) {
    return _then(
      _$ExpenseSummaryImpl(
        monthKey: null == monthKey
            ? _value.monthKey
            : monthKey // ignore: cast_nullable_to_non_nullable
                  as String,
        totalSpent: null == totalSpent
            ? _value.totalSpent
            : totalSpent // ignore: cast_nullable_to_non_nullable
                  as double,
        budgetLimit: freezed == budgetLimit
            ? _value.budgetLimit
            : budgetLimit // ignore: cast_nullable_to_non_nullable
                  as double?,
        remaining: freezed == remaining
            ? _value.remaining
            : remaining // ignore: cast_nullable_to_non_nullable
                  as double?,
        budgetExceeded: null == budgetExceeded
            ? _value.budgetExceeded
            : budgetExceeded // ignore: cast_nullable_to_non_nullable
                  as bool,
        percentUsed: null == percentUsed
            ? _value.percentUsed
            : percentUsed // ignore: cast_nullable_to_non_nullable
                  as double,
        byCategory: null == byCategory
            ? _value._byCategory
            : byCategory // ignore: cast_nullable_to_non_nullable
                  as List<CategorySummary>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseSummaryImpl implements _ExpenseSummary {
  const _$ExpenseSummaryImpl({
    @JsonKey(defaultValue: '') required this.monthKey,
    @JsonKey(fromJson: _toDoubleOrZero) required this.totalSpent,
    @JsonKey(fromJson: _toNullableDouble) this.budgetLimit,
    @JsonKey(fromJson: _toNullableDouble) this.remaining,
    @JsonKey(defaultValue: false) required this.budgetExceeded,
    @JsonKey(fromJson: _toDoubleOrZero) required this.percentUsed,
    @JsonKey(defaultValue: <CategorySummary>[])
    required final List<CategorySummary> byCategory,
  }) : _byCategory = byCategory;

  factory _$ExpenseSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseSummaryImplFromJson(json);

  @override
  @JsonKey(defaultValue: '')
  final String monthKey;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  final double totalSpent;
  @override
  @JsonKey(fromJson: _toNullableDouble)
  final double? budgetLimit;
  @override
  @JsonKey(fromJson: _toNullableDouble)
  final double? remaining;
  @override
  @JsonKey(defaultValue: false)
  final bool budgetExceeded;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  final double percentUsed;
  final List<CategorySummary> _byCategory;
  @override
  @JsonKey(defaultValue: <CategorySummary>[])
  List<CategorySummary> get byCategory {
    if (_byCategory is EqualUnmodifiableListView) return _byCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byCategory);
  }

  @override
  String toString() {
    return 'ExpenseSummary(monthKey: $monthKey, totalSpent: $totalSpent, budgetLimit: $budgetLimit, remaining: $remaining, budgetExceeded: $budgetExceeded, percentUsed: $percentUsed, byCategory: $byCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseSummaryImpl &&
            (identical(other.monthKey, monthKey) ||
                other.monthKey == monthKey) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.budgetLimit, budgetLimit) ||
                other.budgetLimit == budgetLimit) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.budgetExceeded, budgetExceeded) ||
                other.budgetExceeded == budgetExceeded) &&
            (identical(other.percentUsed, percentUsed) ||
                other.percentUsed == percentUsed) &&
            const DeepCollectionEquality().equals(
              other._byCategory,
              _byCategory,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    monthKey,
    totalSpent,
    budgetLimit,
    remaining,
    budgetExceeded,
    percentUsed,
    const DeepCollectionEquality().hash(_byCategory),
  );

  /// Create a copy of ExpenseSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseSummaryImplCopyWith<_$ExpenseSummaryImpl> get copyWith =>
      __$$ExpenseSummaryImplCopyWithImpl<_$ExpenseSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseSummaryImplToJson(this);
  }
}

abstract class _ExpenseSummary implements ExpenseSummary {
  const factory _ExpenseSummary({
    @JsonKey(defaultValue: '') required final String monthKey,
    @JsonKey(fromJson: _toDoubleOrZero) required final double totalSpent,
    @JsonKey(fromJson: _toNullableDouble) final double? budgetLimit,
    @JsonKey(fromJson: _toNullableDouble) final double? remaining,
    @JsonKey(defaultValue: false) required final bool budgetExceeded,
    @JsonKey(fromJson: _toDoubleOrZero) required final double percentUsed,
    @JsonKey(defaultValue: <CategorySummary>[])
    required final List<CategorySummary> byCategory,
  }) = _$ExpenseSummaryImpl;

  factory _ExpenseSummary.fromJson(Map<String, dynamic> json) =
      _$ExpenseSummaryImpl.fromJson;

  @override
  @JsonKey(defaultValue: '')
  String get monthKey;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  double get totalSpent;
  @override
  @JsonKey(fromJson: _toNullableDouble)
  double? get budgetLimit;
  @override
  @JsonKey(fromJson: _toNullableDouble)
  double? get remaining;
  @override
  @JsonKey(defaultValue: false)
  bool get budgetExceeded;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  double get percentUsed;
  @override
  @JsonKey(defaultValue: <CategorySummary>[])
  List<CategorySummary> get byCategory;

  /// Create a copy of ExpenseSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseSummaryImplCopyWith<_$ExpenseSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategorySummary _$CategorySummaryFromJson(Map<String, dynamic> json) {
  return _CategorySummary.fromJson(json);
}

/// @nodoc
mixin _$CategorySummary {
  @JsonKey(defaultValue: '')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'Chưa rõ')
  String get categoryName => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDoubleOrZero)
  double get totalAmount => throw _privateConstructorUsedError;

  /// Serializes this CategorySummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategorySummaryCopyWith<CategorySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySummaryCopyWith<$Res> {
  factory $CategorySummaryCopyWith(
    CategorySummary value,
    $Res Function(CategorySummary) then,
  ) = _$CategorySummaryCopyWithImpl<$Res, CategorySummary>;
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String categoryId,
    @JsonKey(defaultValue: 'Chưa rõ') String categoryName,
    @JsonKey(fromJson: _toDoubleOrZero) double totalAmount,
  });
}

/// @nodoc
class _$CategorySummaryCopyWithImpl<$Res, $Val extends CategorySummary>
    implements $CategorySummaryCopyWith<$Res> {
  _$CategorySummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? totalAmount = null,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategorySummaryImplCopyWith<$Res>
    implements $CategorySummaryCopyWith<$Res> {
  factory _$$CategorySummaryImplCopyWith(
    _$CategorySummaryImpl value,
    $Res Function(_$CategorySummaryImpl) then,
  ) = __$$CategorySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String categoryId,
    @JsonKey(defaultValue: 'Chưa rõ') String categoryName,
    @JsonKey(fromJson: _toDoubleOrZero) double totalAmount,
  });
}

/// @nodoc
class __$$CategorySummaryImplCopyWithImpl<$Res>
    extends _$CategorySummaryCopyWithImpl<$Res, _$CategorySummaryImpl>
    implements _$$CategorySummaryImplCopyWith<$Res> {
  __$$CategorySummaryImplCopyWithImpl(
    _$CategorySummaryImpl _value,
    $Res Function(_$CategorySummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? totalAmount = null,
  }) {
    return _then(
      _$CategorySummaryImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategorySummaryImpl implements _CategorySummary {
  const _$CategorySummaryImpl({
    @JsonKey(defaultValue: '') required this.categoryId,
    @JsonKey(defaultValue: 'Chưa rõ') required this.categoryName,
    @JsonKey(fromJson: _toDoubleOrZero) required this.totalAmount,
  });

  factory _$CategorySummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategorySummaryImplFromJson(json);

  @override
  @JsonKey(defaultValue: '')
  final String categoryId;
  @override
  @JsonKey(defaultValue: 'Chưa rõ')
  final String categoryName;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  final double totalAmount;

  @override
  String toString() {
    return 'CategorySummary(categoryId: $categoryId, categoryName: $categoryName, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySummaryImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, categoryId, categoryName, totalAmount);

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorySummaryImplCopyWith<_$CategorySummaryImpl> get copyWith =>
      __$$CategorySummaryImplCopyWithImpl<_$CategorySummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CategorySummaryImplToJson(this);
  }
}

abstract class _CategorySummary implements CategorySummary {
  const factory _CategorySummary({
    @JsonKey(defaultValue: '') required final String categoryId,
    @JsonKey(defaultValue: 'Chưa rõ') required final String categoryName,
    @JsonKey(fromJson: _toDoubleOrZero) required final double totalAmount,
  }) = _$CategorySummaryImpl;

  factory _CategorySummary.fromJson(Map<String, dynamic> json) =
      _$CategorySummaryImpl.fromJson;

  @override
  @JsonKey(defaultValue: '')
  String get categoryId;
  @override
  @JsonKey(defaultValue: 'Chưa rõ')
  String get categoryName;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  double get totalAmount;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategorySummaryImplCopyWith<_$CategorySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpenseEntry _$ExpenseEntryFromJson(Map<String, dynamic> json) {
  return _ExpenseEntry.fromJson(json);
}

/// @nodoc
mixin _$ExpenseEntry {
  @JsonKey(defaultValue: '')
  String get photoId => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get thumbnailUrl => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDoubleOrZero)
  double get amount => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeOrNowFromJson)
  DateTime get takenAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeOrNowFromJson)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ExpenseEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseEntryCopyWith<ExpenseEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseEntryCopyWith<$Res> {
  factory $ExpenseEntryCopyWith(
    ExpenseEntry value,
    $Res Function(ExpenseEntry) then,
  ) = _$ExpenseEntryCopyWithImpl<$Res, ExpenseEntry>;
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String photoId,
    @JsonKey(defaultValue: '') String imageUrl,
    @JsonKey(defaultValue: '') String thumbnailUrl,
    @JsonKey(fromJson: _toDoubleOrZero) double amount,
    String? note,
    String? categoryId,
    String? categoryName,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) DateTime takenAt,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) DateTime createdAt,
  });
}

/// @nodoc
class _$ExpenseEntryCopyWithImpl<$Res, $Val extends ExpenseEntry>
    implements $ExpenseEntryCopyWith<$Res> {
  _$ExpenseEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photoId = null,
    Object? imageUrl = null,
    Object? thumbnailUrl = null,
    Object? amount = null,
    Object? note = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? takenAt = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            photoId: null == photoId
                ? _value.photoId
                : photoId // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: null == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            takenAt: null == takenAt
                ? _value.takenAt
                : takenAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseEntryImplCopyWith<$Res>
    implements $ExpenseEntryCopyWith<$Res> {
  factory _$$ExpenseEntryImplCopyWith(
    _$ExpenseEntryImpl value,
    $Res Function(_$ExpenseEntryImpl) then,
  ) = __$$ExpenseEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(defaultValue: '') String photoId,
    @JsonKey(defaultValue: '') String imageUrl,
    @JsonKey(defaultValue: '') String thumbnailUrl,
    @JsonKey(fromJson: _toDoubleOrZero) double amount,
    String? note,
    String? categoryId,
    String? categoryName,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) DateTime takenAt,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) DateTime createdAt,
  });
}

/// @nodoc
class __$$ExpenseEntryImplCopyWithImpl<$Res>
    extends _$ExpenseEntryCopyWithImpl<$Res, _$ExpenseEntryImpl>
    implements _$$ExpenseEntryImplCopyWith<$Res> {
  __$$ExpenseEntryImplCopyWithImpl(
    _$ExpenseEntryImpl _value,
    $Res Function(_$ExpenseEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photoId = null,
    Object? imageUrl = null,
    Object? thumbnailUrl = null,
    Object? amount = null,
    Object? note = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? takenAt = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ExpenseEntryImpl(
        photoId: null == photoId
            ? _value.photoId
            : photoId // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: null == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        takenAt: null == takenAt
            ? _value.takenAt
            : takenAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseEntryImpl implements _ExpenseEntry {
  const _$ExpenseEntryImpl({
    @JsonKey(defaultValue: '') required this.photoId,
    @JsonKey(defaultValue: '') required this.imageUrl,
    @JsonKey(defaultValue: '') required this.thumbnailUrl,
    @JsonKey(fromJson: _toDoubleOrZero) required this.amount,
    this.note,
    this.categoryId,
    this.categoryName,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) required this.takenAt,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) required this.createdAt,
  });

  factory _$ExpenseEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseEntryImplFromJson(json);

  @override
  @JsonKey(defaultValue: '')
  final String photoId;
  @override
  @JsonKey(defaultValue: '')
  final String imageUrl;
  @override
  @JsonKey(defaultValue: '')
  final String thumbnailUrl;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  final double amount;
  @override
  final String? note;
  @override
  final String? categoryId;
  @override
  final String? categoryName;
  @override
  @JsonKey(fromJson: _dateTimeOrNowFromJson)
  final DateTime takenAt;
  @override
  @JsonKey(fromJson: _dateTimeOrNowFromJson)
  final DateTime createdAt;

  @override
  String toString() {
    return 'ExpenseEntry(photoId: $photoId, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, amount: $amount, note: $note, categoryId: $categoryId, categoryName: $categoryName, takenAt: $takenAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseEntryImpl &&
            (identical(other.photoId, photoId) || other.photoId == photoId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.takenAt, takenAt) || other.takenAt == takenAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    photoId,
    imageUrl,
    thumbnailUrl,
    amount,
    note,
    categoryId,
    categoryName,
    takenAt,
    createdAt,
  );

  /// Create a copy of ExpenseEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseEntryImplCopyWith<_$ExpenseEntryImpl> get copyWith =>
      __$$ExpenseEntryImplCopyWithImpl<_$ExpenseEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseEntryImplToJson(this);
  }
}

abstract class _ExpenseEntry implements ExpenseEntry {
  const factory _ExpenseEntry({
    @JsonKey(defaultValue: '') required final String photoId,
    @JsonKey(defaultValue: '') required final String imageUrl,
    @JsonKey(defaultValue: '') required final String thumbnailUrl,
    @JsonKey(fromJson: _toDoubleOrZero) required final double amount,
    final String? note,
    final String? categoryId,
    final String? categoryName,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) required final DateTime takenAt,
    @JsonKey(fromJson: _dateTimeOrNowFromJson)
    required final DateTime createdAt,
  }) = _$ExpenseEntryImpl;

  factory _ExpenseEntry.fromJson(Map<String, dynamic> json) =
      _$ExpenseEntryImpl.fromJson;

  @override
  @JsonKey(defaultValue: '')
  String get photoId;
  @override
  @JsonKey(defaultValue: '')
  String get imageUrl;
  @override
  @JsonKey(defaultValue: '')
  String get thumbnailUrl;
  @override
  @JsonKey(fromJson: _toDoubleOrZero)
  double get amount;
  @override
  String? get note;
  @override
  String? get categoryId;
  @override
  String? get categoryName;
  @override
  @JsonKey(fromJson: _dateTimeOrNowFromJson)
  DateTime get takenAt;
  @override
  @JsonKey(fromJson: _dateTimeOrNowFromJson)
  DateTime get createdAt;

  /// Create a copy of ExpenseEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseEntryImplCopyWith<_$ExpenseEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
