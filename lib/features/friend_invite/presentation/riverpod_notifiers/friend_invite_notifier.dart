import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/friend_invite_service.dart';
import '../../domain/repositories/friend_invite_repository.dart';
import '../../domain/usecases/accept_invite_usecase.dart';
import '../../domain/usecases/create_invite_link_usecase.dart';
import '../../domain/usecases/get_current_invite_link_usecase.dart';
import '../../domain/usecases/revoke_invite_link_usecase.dart';
import 'friend_invite_state.dart';

class FriendInviteNotifier extends StateNotifier<FriendInviteState> {
  FriendInviteNotifier({required FriendInviteRepository repository})
    : _repository = repository,
      super(FriendInviteState.initial()) {
    _createInviteLinkUseCase = CreateInviteLinkUseCase(_repository);
    _getCurrentInviteLinkUseCase = GetCurrentInviteLinkUseCase(_repository);
    _revokeInviteLinkUseCase = RevokeInviteLinkUseCase(_repository);
    _acceptInviteUseCase = AcceptInviteUseCase(_repository);
  }

  final FriendInviteRepository _repository;
  late final CreateInviteLinkUseCase _createInviteLinkUseCase;
  late final GetCurrentInviteLinkUseCase _getCurrentInviteLinkUseCase;
  late final RevokeInviteLinkUseCase _revokeInviteLinkUseCase;
  late final AcceptInviteUseCase _acceptInviteUseCase;

  Future<void> loadCurrentLink() async {
    state = state.copyWith(
      currentStatus: FriendInviteCurrentStatus.loading,
      errorMessage: null,
    );

    try {
      final link = await _getCurrentInviteLinkUseCase.call();
      if (link == null) {
        state = state.copyWith(
          currentStatus: FriendInviteCurrentStatus.empty,
          currentLink: null,
        );
        return;
      }

      state = state.copyWith(
        currentStatus: FriendInviteCurrentStatus.ready,
        currentLink: link,
      );
    } on FriendInviteApiException catch (e) {
      state = state.copyWith(
        currentStatus: FriendInviteCurrentStatus.error,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        currentStatus: FriendInviteCurrentStatus.error,
        errorMessage: 'Không thể tải link mời hiện tại',
      );
    }
  }

  Future<void> createLink({int? ttlMinutes}) async {
    state = state.copyWith(
      createStatus: FriendInviteActionStatus.loading,
      errorMessage: null,
    );

    try {
      final created = await _createInviteLinkUseCase.call(
        ttlMinutes: ttlMinutes,
      );
      state = state.copyWith(
        createStatus: FriendInviteActionStatus.success,
        currentStatus: FriendInviteCurrentStatus.ready,
        currentLink: created,
      );
    } on FriendInviteApiException catch (e) {
      state = state.copyWith(
        createStatus: FriendInviteActionStatus.error,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        createStatus: FriendInviteActionStatus.error,
        errorMessage: 'Không thể tạo link mời',
      );
    }
  }

  Future<void> revokeCurrentLink() async {
    state = state.copyWith(
      revokeStatus: FriendInviteActionStatus.loading,
      errorMessage: null,
    );

    try {
      await _revokeInviteLinkUseCase.call();
      state = state.copyWith(
        revokeStatus: FriendInviteActionStatus.success,
        currentStatus: FriendInviteCurrentStatus.empty,
        currentLink: null,
      );
    } on FriendInviteApiException catch (e) {
      state = state.copyWith(
        revokeStatus: FriendInviteActionStatus.error,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        revokeStatus: FriendInviteActionStatus.error,
        errorMessage: 'Không thể thu hồi link mời',
      );
    }
  }

  Future<void> acceptInviteByToken(String token) async {
    final trimmedToken = token.trim();
    if (trimmedToken.isEmpty) {
      state = state.copyWith(
        acceptStatus: FriendInviteAcceptStatus.invalid,
        errorMessage: 'Mã mời không được để trống',
      );
      return;
    }

    state = state.copyWith(
      acceptStatus: FriendInviteAcceptStatus.loading,
      errorMessage: null,
      acceptedResult: null,
    );

    try {
      final accepted = await _acceptInviteUseCase.call(token: trimmedToken);
      state = state.copyWith(
        acceptStatus: FriendInviteAcceptStatus.success,
        acceptedResult: accepted,
      );
    } on FriendInviteApiException catch (e) {
      state = state.copyWith(
        acceptStatus: _mapAcceptStatusByCode(e.statusCode),
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        acceptStatus: FriendInviteAcceptStatus.error,
        errorMessage: 'Không thể chấp nhận lời mời',
      );
    }
  }

  void resetActionStatuses() {
    state = state.copyWith(
      createStatus: FriendInviteActionStatus.idle,
      revokeStatus: FriendInviteActionStatus.idle,
      acceptStatus: FriendInviteAcceptStatus.idle,
      errorMessage: null,
    );
  }

  FriendInviteAcceptStatus _mapAcceptStatusByCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return FriendInviteAcceptStatus.invalid;
      case 409:
        return FriendInviteAcceptStatus.maxUses;
      case 410:
        return FriendInviteAcceptStatus.expired;
      default:
        return FriendInviteAcceptStatus.error;
    }
  }
}
