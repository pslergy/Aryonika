// lib/cubit/channel_state.dart
import 'package:equatable/equatable.dart';
import '../src/data/models/channel.dart';
import '../src/data/models/comment.dart';
import '../src/data/models/post.dart';

enum ChannelStatus { initial, loading, success, error }

class ChannelState extends Equatable {
  final Channel? activeChannel;
  final ChannelStatus activeChannelStatus;
  final List<Post> activeChannelPosts;
  final bool isPaginatingPosts;
  final bool allPostsLoaded;
  final bool isCreatingPost; // <-- Добавили флаг для индикатора создания поста
  final List<Post> proposedPosts;
  final ChannelStatus proposedPostsStatus;
  final String? successMessage;
  final String? errorMessage;
  final int messageEventId;
  final Map<String, String> typingUsers;
  final List<Comment> activePostComments;
  final ChannelStatus commentsStatus;
  final String? activePostIdForComments;

  const ChannelState({
    this.activeChannel,
    this.activeChannelStatus = ChannelStatus.initial,
    this.activeChannelPosts = const [],
    this.isPaginatingPosts = false,
    this.allPostsLoaded = false,
    this.isCreatingPost = false,
    this.proposedPosts = const [],
    this.proposedPostsStatus = ChannelStatus.initial,
    this.successMessage,
    this.errorMessage,
    this.messageEventId = 0,
    this.typingUsers = const {},
    this.activePostComments = const [],
    this.commentsStatus = ChannelStatus.initial,
    this.activePostIdForComments,
  });

  ChannelState copyWith({
    Channel? activeChannel,
    ChannelStatus? activeChannelStatus,
    List<Post>? activeChannelPosts,
    bool? isPaginatingPosts,
    bool? allPostsLoaded,
    bool? isCreatingPost,
    List<Post>? proposedPosts,
    ChannelStatus? proposedPostsStatus,
    String? successMessage,
    String? errorMessage,
    bool? clearMessages,
    Map<String, String>? typingUsers,
    List<Comment>? activePostComments,
    ChannelStatus? commentsStatus,
    String? activePostIdForComments,
  }) {
    final bool shouldClear = clearMessages == true;
    return ChannelState(
      activeChannel: activeChannel ?? this.activeChannel,
      activeChannelStatus: activeChannelStatus ?? this.activeChannelStatus,
      activeChannelPosts: activeChannelPosts ?? this.activeChannelPosts,
      isPaginatingPosts: isPaginatingPosts ?? this.isPaginatingPosts,
      allPostsLoaded: allPostsLoaded ?? this.allPostsLoaded,
      isCreatingPost: isCreatingPost ?? this.isCreatingPost,
      proposedPosts: proposedPosts ?? this.proposedPosts,
      proposedPostsStatus: proposedPostsStatus ?? this.proposedPostsStatus,
      successMessage: shouldClear ? null : successMessage,
      errorMessage: shouldClear ? null : errorMessage,
      messageEventId: (successMessage != null || errorMessage != null) ? this.messageEventId + 1 : this.messageEventId,
      typingUsers: typingUsers ?? this.typingUsers,
      activePostComments: activePostComments ?? this.activePostComments,
      commentsStatus: commentsStatus ?? this.commentsStatus,
      activePostIdForComments: activePostIdForComments ?? this.activePostIdForComments,
    );
  }

  @override
  List<Object?> get props => [activeChannel, activeChannelStatus, activePostIdForComments, activeChannelPosts, isPaginatingPosts, allPostsLoaded, typingUsers, isCreatingPost, proposedPosts, proposedPostsStatus, successMessage, errorMessage, messageEventId, activePostComments, commentsStatus];
}