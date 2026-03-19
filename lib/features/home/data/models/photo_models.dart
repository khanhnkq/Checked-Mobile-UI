class PhotoResponse {
  final String id;
  final String senderId;
  final String senderDisplayName;
  final String? senderAvatarUrl;
  final String imageUrl;
  final String thumbnailUrl;
  final String? caption;
  final double? amount;
  final String recipientScope;
  final int recipientCount;
  final String status;
  final String mimeType;
  final int fileSize;
  final int width;
  final int height;
  final DateTime takenAt;
  final DateTime createdAt;

  PhotoResponse({
    required this.id,
    required this.senderId,
    required this.senderDisplayName,
    this.senderAvatarUrl,
    required this.imageUrl,
    required this.thumbnailUrl,
    this.caption,
    this.amount,
    required this.recipientScope,
    required this.recipientCount,
    required this.status,
    required this.mimeType,
    required this.fileSize,
    required this.width,
    required this.height,
    required this.takenAt,
    required this.createdAt,
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) => PhotoResponse(
        id: json['id'] as String,
        senderId: json['senderId'] as String,
        senderDisplayName: json['senderDisplayName'] as String,
        senderAvatarUrl: json['senderAvatarUrl'] as String?,
        imageUrl: json['imageUrl'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        caption: json['caption'] as String?,
        amount: (json['amount'] as num?)?.toDouble(),
        recipientScope: json['recipientScope'] as String,
        recipientCount: json['recipientCount'] as int,
        status: json['status'] as String,
        mimeType: json['mimeType'] as String,
        fileSize: json['fileSize'] as int,
        width: json['width'] as int,
        height: json['height'] as int,
        takenAt: DateTime.parse(json['takenAt'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}

class SliceResponse<T> {
  final List<T> content;
  final int number;
  final int size;
  final bool first;
  final bool last;
  final int numberOfElements;
  final bool empty;

  SliceResponse({
    required this.content,
    required this.number,
    required this.size,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.empty,
  });

  factory SliceResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return SliceResponse<T>(
      content: (json['content'] as List).map((i) => fromJsonT(i as Map<String, dynamic>)).toList(),
      number: json['number'] as int,
      size: json['size'] as int,
      first: json['first'] as bool,
      last: json['last'] as bool,
      numberOfElements: json['numberOfElements'] as int,
      empty: json['empty'] as bool,
    );
  }
}

class PageResponse<T> extends SliceResponse<T> {
  final int totalElements;
  final int totalPages;

  PageResponse({
    required super.content,
    required super.number,
    required super.size,
    required super.first,
    required super.last,
    required super.numberOfElements,
    required super.empty,
    required this.totalElements,
    required this.totalPages,
  });

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PageResponse<T>(
      content: (json['content'] as List).map((i) => fromJsonT(i as Map<String, dynamic>)).toList(),
      number: json['number'] as int,
      size: json['size'] as int,
      first: json['first'] as bool,
      last: json['last'] as bool,
      numberOfElements: json['numberOfElements'] as int,
      empty: json['empty'] as bool,
      totalElements: json['totalElements'] as int,
      totalPages: json['totalPages'] as int,
    );
  }
}
