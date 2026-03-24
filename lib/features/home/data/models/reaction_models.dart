enum ReactionType { like, love, haha, wow, sad, angry }

extension ReactionTypeCodec on ReactionType {
  String get apiValue {
    switch (this) {
      case ReactionType.like:
        return 'LIKE';
      case ReactionType.love:
        return 'LOVE';
      case ReactionType.haha:
        return 'HAHA';
      case ReactionType.wow:
        return 'WOW';
      case ReactionType.sad:
        return 'SAD';
      case ReactionType.angry:
        return 'ANGRY';
    }
  }

  static ReactionType? fromApiValue(String? value) {
    switch (value?.toUpperCase()) {
      case 'LIKE':
        return ReactionType.like;
      case 'LOVE':
        return ReactionType.love;
      case 'HAHA':
        return ReactionType.haha;
      case 'WOW':
        return ReactionType.wow;
      case 'SAD':
        return ReactionType.sad;
      case 'ANGRY':
        return ReactionType.angry;
      default:
        return null;
    }
  }
}

class PhotoReaction {
  const PhotoReaction({
    required this.photoId,
    required this.userId,
    required this.type,
    required this.createdAt,
  });

  final String photoId;
  final String userId;
  final ReactionType type;
  final DateTime createdAt;

  factory PhotoReaction.fromJson(Map<String, dynamic> json) {
    return PhotoReaction(
      photoId: json['photoId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      type:
          ReactionTypeCodec.fromApiValue(json['type'] as String?) ??
          ReactionType.like,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

class PhotoReactionSummary {
  const PhotoReactionSummary({
    required this.photoId,
    required this.totalCount,
    required this.myReaction,
    required this.countsByType,
    required this.recentReactors,
  });

  final String photoId;
  final int totalCount;
  final ReactionType? myReaction;
  final Map<ReactionType, int> countsByType;
  final List<ReactionActor> recentReactors;

  int countOf(ReactionType type) => countsByType[type] ?? 0;

  factory PhotoReactionSummary.fromJson(Map<String, dynamic> json) {
    final rawCounts = json['countsByType'];
    final parsed = <ReactionType, int>{};

    if (rawCounts is Map<String, dynamic>) {
      rawCounts.forEach((key, value) {
        final type = ReactionTypeCodec.fromApiValue(key);
        if (type != null) {
          parsed[type] = (value as num?)?.toInt() ?? 0;
        }
      });
    }

    final reactors = _parseReactors(json);

    return PhotoReactionSummary(
      photoId: json['photoId'] as String? ?? '',
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      myReaction: ReactionTypeCodec.fromApiValue(json['myReaction'] as String?),
      countsByType: parsed,
      recentReactors: reactors,
    );
  }

  static List<ReactionActor> _parseReactors(Map<String, dynamic> json) {
    final candidates = [
      json['recentReactors'],
      json['reactors'],
      json['recentReactions'],
      json['activities'],
    ];

    for (final candidate in candidates) {
      if (candidate is List) {
        final reactors = candidate
            .whereType<Map>()
            .map((entry) => ReactionActor.fromJson(
                  entry.cast<String, dynamic>(),
                ))
            .where((actor) => actor.userId.isNotEmpty)
            .toList(growable: false);
        if (reactors.isNotEmpty) return reactors;
      }
    }
    return const [];
  }
}

class ReactionActor {
  const ReactionActor({
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    this.type,
  });

  final String userId;
  final String displayName;
  final String? avatarUrl;
  final ReactionType? type;

  factory ReactionActor.fromJson(Map<String, dynamic> json) {
    final userId =
        (json['userId'] ?? json['id'] ?? json['senderId'] ?? '').toString();
    final displayName =
        (json['displayName'] ??
                json['name'] ??
                json['fullName'] ??
                json['userDisplayName'] ??
                '')
            .toString();
    final avatarUrl =
        (json['avatarUrl'] ??
                json['userAvatarUrl'] ??
                json['senderAvatarUrl'] ??
                json['profileImageUrl'])
            ?.toString();
    final rawType = json['type'] ?? json['reactionType'];

    return ReactionActor(
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      type: ReactionTypeCodec.fromApiValue(rawType?.toString()),
    );
  }
}
