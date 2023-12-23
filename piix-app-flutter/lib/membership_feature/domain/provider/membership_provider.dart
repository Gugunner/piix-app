import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/membership_feature/data/repository/membership_repository.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_provider.g.dart';

///A Riverpod Notifier class that handles
///the storage and cleaning of the [membership]
///the user has.
@Riverpod(keepAlive: true)
final class MembershipPod extends _$MembershipPod {
  @override
  MembershipModel? build() => null;

  void set(MembershipModel? membership) {
    state = membership;
  }

  MembershipModel? get membership => state;

  void clean() {
    state = null;
  }
}

///A Riverpod Async Notifier class that handles
///the request of getting the user membership and
///storing them inside the state of [MembershipPod].
@riverpod
final class UserMembershipPod extends _$UserMembershipPod {
  //The name of the class that is sent for logging purposes if
  //an exception occurs while making the request.
  String get _className => 'UserMembershipsPod';

  @override
  Future<void> build() => _getUserMembership();

  Future<void> _getUserMembership() async {
    try {
      final membership =
          await ref.read(membershipRepositoryPod).getUserMembership();
      //Store the memberships if succesfuly retrieved.
      ref.read(membershipPodProvider.notifier).set(membership);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}

@Deprecated('Will be removed in 4.0')

///A Riverpod Notifier class that exclusively works returning
///an AsyncValue result to obtain the user [memberships] by the [userId].
@riverpod
class MembershipServiceNotifierPod extends _$MembershipServiceNotifierPod
    with LogApiCall, LogAppCall, LogAnalytics {
  @override
  Future<void> build() {
    return _getMemberships();
  }

  @Deprecated('Will be removed in 4.0')
  Future<void> _getMemberships() async {
    try {
      // final userId = ref.read(userPodProvider)?.userId ?? '';
      // final repository =
      //     ref.read(userMembershipServiceRepositoryProvider.notifier);
      // // final membership = await repository.getUserMemberships(userId);
      // // ref.read(membershipPodProvider.notifier).set(membership);
      // // return;
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'MembershipServiceNotifier');
      } else {
        logDioException(error, className: 'MembershipServiceNotifier');
      }
      rethrow;
    }
  }
}

///A Riverpod Notifier class that handles the selected membership
///the user is currently using
@Riverpod(keepAlive: true)
class MembershipNotifierPod extends _$MembershipNotifierPod {
  @override
  MembershipModel? build() => null;

  MembershipModel? get membership => state;

  void setMembership(MembershipModel? membership) {
    state = membership;
  }

  int get benefitCount => state?.benefitsQuantity ?? 0;
}

///Rebuilds each time the [membership] changes and sets the status to know
///if membership exists
final isMembershipProvider = StateProvider<bool>(
    (ref) => ref.watch(membershipNotifierPodProvider) != null);

///Rebuilds each time the [membership] changes and sets the status to know
///if it has an active store
final hasActiveStoreProvider = StateProvider<bool>((ref) =>
    ref.watch(membershipNotifierPodProvider)?.package?.activeStore ?? false);

///Rebuilds each time the [membership] changes and sets the status to know
///if it is the main user
final isMainUserProvider = StateProvider<bool>((ref) => true);

///A Riverpod Notifier class that exclusively works returning
///a void AsyncValue and sets the [cacheImageMemory] of the
///[userMembershipLevel] for the selected [membership]
@riverpod
class MembershipImageNotifierPod extends _$MembershipImageNotifierPod
    with LogAppCall, LogApiCall {
  @override
  FutureOr<void> build() => _storeCacheImage();

  Future<void> _storeCacheImage() async {
    try {
      //Never call this provider if not sure there is a membership or not
      // final membership = ref.read(membershipNotifierPodProvider)!;
      //Obtain the file where the 64bit image is stored
      // final file = await ref.read(s3FileNotifierProvider.notifier).getFile(
      //       path: 'membership.usersMembershipLevel.membershipLevelImage',
      //       propertyName: '${membership.membershipId}/cardImage',
      //     );
      //Get the 64bit image from the fileContent, if there is no fileContent
      //the method will throw an Exception
      // final cacheImageMemory = base64Decode(file.fileContent!.base64Content);
      //Set the 64 bit image in the current selected membership
      // ref
      //     .read(membershipNotifierPodProvider.notifier)
      //     .setMembership(membership.setCacheImageMemory(cacheImageMemory));
    } catch (error) {
      if (error is! DioError) {
        logError(error, className: 'MembershipImageNotifier');
      } else {
        logDioException(error, className: 'MembershipImageNotifier');
      }
    }
    return;
  }
}
