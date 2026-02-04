// lib/cubit/channel_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/services/cloudinary_service.dart';
import 'package:lovequest/services/websocket_service.dart';
import 'package:lovequest/src/data/models/post.dart';
import 'package:lovequest/src/data/models/channel.dart';
import 'package:image_picker/image_picker.dart';
import '../services/logger_service.dart';
import '../src/data/models/comment.dart';
import 'channel_state.dart';

class ChannelCubit extends Cubit<ChannelState> {
  final ApiRepository _apiRepository;
  final CloudinaryService _cloudinaryService;
  final String _channelId;
  StreamSubscription? _webSocketSubscription;
  Timer? _typingTimer;

  ChannelCubit({
    required ApiRepository apiRepository,
    required CloudinaryService cloudinaryService,
    required String channelId,
  })  : _apiRepository = apiRepository,
        _cloudinaryService = cloudinaryService,
        _channelId = channelId,
        super(const ChannelState());

  // --- ЖИЗНЕННЫЙ ЦИКЛ ---
  Future<void> loadInitialData() async {
    if (state.activeChannelStatus == ChannelStatus.loading) return;
    emit(state.copyWith(activeChannelStatus: ChannelStatus.loading, allPostsLoaded: false));
    await _loadData();
    _listenToWebSocket();
  }

  Future<void> refreshChannelData() async => await _loadData();
  void onChannelScreenClosed() {
    _webSocketSubscription?.cancel();
    emit(const ChannelState());
  }

  Future<void> loadCommentsForPost(String postId) async {
    // Устанавливаем ID активного поста в state!
    emit(state.copyWith(
        commentsStatus: ChannelStatus.loading,
        activePostComments: [],
        activePostIdForComments: postId // <-- ВОТ ГЛАВНОЕ ИЗМЕНЕНИЕ
    ));
    try {
      final comments = await _apiRepository.getComments(postId);
      emit(state.copyWith(
        activePostComments: comments,
        commentsStatus: ChannelStatus.success,
      ));
    } catch (e) {
      logger.d("Ошибка загрузки комментариев: $e");
      emit(state.copyWith(commentsStatus: ChannelStatus.error));
    }
  }

  void onCommentsScreenClosed() {
    emit(state.copyWith(
        activePostComments: [],
        activePostIdForComments: null // <-- Сбрасываем ID при выходе
    ));
  }


  Future<void> postComment(String postId, String text) async {
    try {
      // Вызываем метод репозитория, который мы уже создавали
      final newComment = await _apiRepository.postComment(postId: postId, text: text);
      // Оптимистичное обновление здесь не нужно, так как сервер пришлет WebSocket.
      // Но если WebSocket для комментов еще не реализован, можно добавить:
      // emit(state.copyWith(activePostComments: [...state.activePostComments, newComment]));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Не удалось отправить комментарий"));
    }
  }

  Future<void> replyToComment({
    required String postId,
    required Comment parentComment,
    required String text,
  }) async {
    try {
      await _apiRepository.postComment(postId: postId, text: text, replyTo: parentComment);
    } catch (e) {
      emit(state.copyWith(errorMessage: "Не удалось отправить ответ"));
    }
  }


  void onCommentTextChanged(String text) {
    // Отменяем предыдущий таймер
    _typingTimer?.cancel();

    // Если текст не пустой, отправляем "isTyping: true"
    if (text.isNotEmpty) {
      WebSocketService.instance.send({
        'type': 'typing_status_channel',
        'payload': {'channelId': _channelId, 'isTyping': true},
      });
      // И запускаем таймер, который через 3 секунды отправит "isTyping: false"
      _typingTimer = Timer(const Duration(seconds: 3), () {
        WebSocketService.instance.send({
          'type': 'typing_status_channel',
          'payload': {'channelId': _channelId, 'isTyping': false},
        });
      });
    } else {
      // Если текст стерли, сразу отправляем "isTyping: false"
      WebSocketService.instance.send({
        'type': 'typing_status_channel',
        'payload': {'channelId': _channelId, 'isTyping': false},
      });
    }
  }


  // --- ЗАГРУЗКА ДАННЫХ ---
  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _apiRepository.getChannelDetails(_channelId),
        _apiRepository.getPosts(_channelId, offset: 0),
      ]);
      final channel = results[0] as Channel?;
      final posts = results[1] as List<Post>;
      if (channel == null) throw Exception("Channel not found");
      emit(state.copyWith(
        activeChannel: channel,
        activeChannelPosts: posts,
        activeChannelStatus: ChannelStatus.success,
        allPostsLoaded: posts.length < 20,
      ));
    } catch (e) {
      emit(state.copyWith(activeChannelStatus: ChannelStatus.error));
    }
  }

  Future<void> loadMorePosts() async {
    if (state.isPaginatingPosts || state.allPostsLoaded) return;
    emit(state.copyWith(isPaginatingPosts: true));
    try {
      final newPosts = await _apiRepository.getPosts(_channelId, offset: state.activeChannelPosts.length);
      emit(state.copyWith(
        activeChannelPosts: [...state.activeChannelPosts, ...newPosts],
        isPaginatingPosts: false,
        allPostsLoaded: newPosts.isEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(isPaginatingPosts: false));
    }
  }

  // --- УПРАВЛЕНИЕ ПОСТАМИ ---
  Future<void> createPost({required String text, required String anonymousAuthorName, XFile? imageFile}) async {
    emit(state.copyWith(isCreatingPost: true));
    try {
      String? imageUrl;
      if (imageFile != null) imageUrl = await _cloudinaryService.uploadImage(imageFile: imageFile);
      await _apiRepository.createPost(channelId: _channelId, text: text, imageUrl: imageUrl, anonymousAuthorName: anonymousAuthorName);
    } catch (e) {
      emit(state.copyWith(errorMessage: "Не удалось создать пост"));
    } finally {
      emit(state.copyWith(isCreatingPost: false));
    }
  }

  Future<void> proposePost(String text, {XFile? imageFile}) async {
    emit(state.copyWith(isCreatingPost: true));
    try {
      String? imageUrl;
      if (imageFile != null) imageUrl = await _cloudinaryService.uploadImage(imageFile: imageFile);
      await _apiRepository.proposePost(_channelId, text, imageUrl: imageUrl);
      emit(state.copyWith(successMessage: "Пост отправлен на модерацию!"));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Не удалось предложить пост."));
    } finally {
      emit(state.copyWith(isCreatingPost: false));
    }
  }

  Future<void> deletePost(String postId) async {
    await _apiRepository.deletePost(postId);
  }

  void onPostVisible(String postId) => _apiRepository.incrementPostViewCount(postId).catchError((_){});
  Future<void> togglePostReaction(String postId, String emoji, String currentUserId) async {
    // --- НАЧАЛО ОПТИМИСТИЧНОГО ОБНОВЛЕНИЯ ---

    // 1. Находим пост и его индекс в текущем списке
    final originalPosts = List<Post>.from(state.activeChannelPosts);
    final postIndex = originalPosts.indexWhere((p) => p.id == postId);
    if (postIndex == -1) return; // Если пост не найден, выходим

    final postToUpdate = originalPosts[postIndex];

    // 2. Создаем изменяемую копию карты реакций
    final newReactions = Map<String, List<String>>.from(
        postToUpdate.reactions.map((key, value) => MapEntry(key, List<String>.from(value)))
    );

    // 3. Применяем логику "включения/выключения"
    bool userHadThisReaction = newReactions[emoji]?.contains(currentUserId) ?? false;

    // Сначала удаляем пользователя из ВСЕХ реакций (если он ставил другую)
    String? oldReaction;
    newReactions.forEach((key, userIds) {
      if (userIds.remove(currentUserId)) {
        oldReaction = key;
      }
    });

    // Если новая реакция не совпадает со старой (или старой не было), добавляем новую
    if (oldReaction != emoji) {
      final reactionUsers = newReactions[emoji] ?? [];
      reactionUsers.add(currentUserId);
      newReactions[emoji] = reactionUsers;
    }

    // Удаляем ключи с пустыми списками
    newReactions.removeWhere((key, value) => value.isEmpty);

    // 4. Создаем обновленный пост и обновляем список
    final updatedPost = postToUpdate.copyWith(reactions: newReactions);
    final updatedPosts = List<Post>.from(originalPosts)..[postIndex] = updatedPost;

    // 5. МГНОВЕННО обновляем UI
    emit(state.copyWith(activeChannelPosts: updatedPosts));

    // --- КОНЕЦ ОПТИМИСТИЧНОГО ОБНОВЛЕНИЯ ---

    // 6. В фоне отправляем запрос на сервер
    try {
      await _apiRepository.toggleReaction(entityType: 'post', entityId: postId, emoji: emoji);
    } catch (e) {
      // 7. Если сервер вернул ошибку, откатываем UI к исходному состоянию
      logger.d("!!! Ошибка при отправке реакции, откатываю UI: $e");
      emit(state.copyWith(activeChannelPosts: originalPosts));
    }
  }

  Future<void> editPost(String postId, String newText) async {
    // Оптимистичное обновление
    final originalPosts = state.activeChannelPosts;
    final postIndex = originalPosts.indexWhere((p) => p.id == postId);
    if (postIndex == -1) return;

    final updatedPost = originalPosts[postIndex].copyWith(text: newText, isEdited: true);
    final updatedPosts = List<Post>.from(originalPosts)..[postIndex] = updatedPost;
    emit(state.copyWith(activeChannelPosts: updatedPosts));

    try {
      await _apiRepository.editPost(postId, newText);
    } catch (e) {
      emit(state.copyWith(activeChannelPosts: originalPosts, errorMessage: "Ошибка редактирования"));
    }
  }
  Future<void> togglePinPost(String postId) async {
    try {
      // Здесь не нужно оптимистичное обновление,
      // так как WebSocket сделает все за нас.
      // Просто отправляем команду на сервер.
      await _apiRepository.togglePinPost(postId);
    } catch (e) {
      emit(state.copyWith(errorMessage: "Не удалось закрепить пост"));
    }
  }


  // --- НАСТРОЙКИ КАНАЛА ---
  Future<void> _updateSettings(Map<String, dynamic> settings) async {
    try {
      final updatedChannel = await _apiRepository.updateChannelSettings(_channelId, settings);
      emit(state.copyWith(activeChannel: updatedChannel, successMessage: "Настройки сохранены!"));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Не удалось сохранить настройки."));
      await loadInitialData();
    }
  }
  void updateAuthorship(String auth) => _updateSettings({'post_authorship': auth});
  void toggleChannelPrivacy() => _updateSettings({'is_private': !(state.activeChannel?.isPrivate ?? false)});
  Future<void> updateChannelDescription(Map<String, String> descMap) async {
    await _updateSettings({'description': descMap});
  }
  Future<void> updateChannelAvatar(String base64) async {
    try {
      final imageUrl = await _cloudinaryService.uploadBase64Image(base64String: base64);
      if (imageUrl != null) await _updateSettings({'avatar_url': imageUrl});
    } catch (e) {
      emit(state.copyWith(errorMessage: "Ошибка загрузки аватара"));
    }
  }
  Future<void> deleteChannel() async => await _apiRepository.deleteChannel(_channelId);

  // --- МОДЕРАЦИЯ ---
  Future<void> onModerationScreenOpened() async {
    emit(state.copyWith(proposedPostsStatus: ChannelStatus.loading));
    try {
      final posts = await _apiRepository.getProposedPosts(_channelId);
      emit(state.copyWith(proposedPosts: posts, proposedPostsStatus: ChannelStatus.success));
    } catch (e) {
      emit(state.copyWith(proposedPostsStatus: ChannelStatus.error));
    }
  }
  void onModerationScreenClosed() => emit(state.copyWith(proposedPosts: []));
  Future<void> approvePost(Post post) async {
    _removePostFromModerationList(post.id);
    await _apiRepository.approvePost(post.id);
  }
  Future<void> rejectPost(String postId) async {
    _removePostFromModerationList(postId);
    await _apiRepository.rejectPost(postId);
  }
  void _removePostFromModerationList(String postId) => emit(state.copyWith(proposedPosts: state.proposedPosts.where((p) => p.id != postId).toList()));

  // --- ПРОЧЕЕ ---
  void clearMessages() => emit(state.copyWith(clearMessages: true));

  void _listenToWebSocket() {
    _webSocketSubscription?.cancel();
    _webSocketSubscription = WebSocketService.instance.events.listen((event) {
      // Выходим, если мы не на экране канала или данные еще не загружены
      if (state.activeChannel == null) return;

      final currentChannelId = state.activeChannel!.id.toString();
      logger.d("[WS CUBIT] Получено событие '${event.type}' для канала $currentChannelId");

      switch (event.type) {
      // --- СОБЫТИЕ: НОВЫЙ ПОСТ В КАНАЛЕ ---
        case 'new_post':
          try {
            final newPost = Post.fromJson(event.payload);
            // Проверяем, что пост принадлежит текущему открытому каналу
            if (newPost.channelId.toString() == currentChannelId) {
              logger.d("[WS CUBIT] ✅ Новый пост '${newPost.id}' добавлен в UI.");
              // Добавляем новый пост в начало списка
              emit(state.copyWith(
                activeChannelPosts: [newPost, ...state.activeChannelPosts],
              ));
            }
          } catch (e) {
            logger.d("[WS CUBIT] ❌ Ошибка парсинга 'new_post': $e");
          }
          break;

        case 'new_comment':
          try {
            final newComment = Comment.fromJson(event.payload);

            // Проверяем, что коммент относится к ПОСТУ, который сейчас открыт на экране
            if (newComment.postId == state.activePostIdForComments) {
              logger.d("[WS CUBIT] ✅ Получен новый коммент для активного поста. Добавляю в UI.");
              emit(state.copyWith(
                activePostComments: [...state.activePostComments, newComment],
              ));
            }

            // Бонус: обновляем счетчик комментов у поста в основном списке
            final postIndex = state.activeChannelPosts.indexWhere((p) => p.id == newComment.postId);
            if (postIndex != -1) {
              final postToUpdate = state.activeChannelPosts[postIndex];
              final updatedPost = postToUpdate.copyWith(commentCount: (postToUpdate.commentCount ?? 0) + 1);
              final updatedPosts = List<Post>.from(state.activeChannelPosts)..[postIndex] = updatedPost;
              emit(state.copyWith(activeChannelPosts: updatedPosts));
            }

          } catch (e) {
            logger.d("[WS CUBIT] ❌ Ошибка парсинга 'new_comment': $e");
          }
          break;

        case 'user_is_typing_in_channel':
          try {
            final payload = event.payload as Map<String, dynamic>;
            if (payload['channelId'] == _channelId) {
              final userId = payload['userId'] as String;
              final userName = payload['userName'] as String;
              final isTyping = payload['isTyping'] as bool;

              // Создаем новую карту печатающих на основе старой
              final newTypingUsers = Map<String, String>.from(state.typingUsers);
              if (isTyping) {
                newTypingUsers[userId] = userName; // Добавляем или обновляем
              } else {
                newTypingUsers.remove(userId); // Удаляем
              }
              emit(state.copyWith(typingUsers: newTypingUsers));
            }
          } catch (e) {
            logger.d("[WS CUBIT] ❌ Ошибка обработки 'user_is_typing_in_channel': $e");
          }
          break;

      // --- СОБЫТИЕ: ПОСТ БЫЛ ОБНОВЛЕН (например, добавлена реакция) ---
        case 'post_updated':
          try {
            // Сервер присылает только ID и обновленные поля
            final data = event.payload as Map<String, dynamic>;
            final postId = data['id'];

            final updatedPosts = state.activeChannelPosts.map((post) {
              if (post.id == postId) {
                logger.d("[WS CUBIT] ✅ Пост '$postId' обновлен в UI.");
                // Используем copyWith, чтобы обновить только нужные поля
                return post.copyWith(
                  reactions: data['reactions'] != null ? Map<String, List<String>>.from(data['reactions']) : post.reactions,
                  viewCount: data['viewCount'] as int? ?? post.viewCount,
                  commentCount: data['commentCount'] as int? ?? post.commentCount,
                );
              }
              return post;
            }).toList();

            emit(state.copyWith(activeChannelPosts: updatedPosts));
          } catch (e) {
            logger.d("[WS CUBIT] ❌ Ошибка обработки 'post_updated': $e");
          }
          break;

      // --- СОБЫТИЕ: ПОСТ БЫЛ УДАЛЕН ---
        case 'post_deleted':
          try {
            final data = event.payload as Map<String, dynamic>;
            final postId = data['id'] as String?;
            if (postId != null) {
              logger.d("[WS CUBIT] ✅ Пост '$postId' удален из UI.");
              // Фильтруем список, убирая удаленный пост
              emit(state.copyWith(
                activeChannelPosts: state.activeChannelPosts.where((p) => p.id != postId).toList(),
              ));
            }
          } catch (e) {
            logger.d("[WS CUBIT] ❌ Ошибка обработки 'post_deleted': $e");
          }
          break;

      // --- СОБЫТИЕ: ИНФОРМАЦИЯ О КАНАЛЕ ОБНОВИЛАСЬ ---
      // (Например, изменилось количество подписчиков или название)
        case 'channel_updated':
          try {
            final data = event.payload as Map<String, dynamic>;
            if (data['id']?.toString() == currentChannelId) {
              logger.d("[WS CUBIT] ✅ Данные канала '$currentChannelId' обновлены.");

              // --- 👇 ВОТ ИСПРАВЛЕНИЕ 👇 ---

              // Получаем текущие Map'ы с переводами
              final newNameMap = Map<String, String>.from(state.activeChannel!.name);
              final newDescriptionMap = Map<String, String>.from(state.activeChannel!.description);

              // Если сервер прислал локализованное имя, обновляем его для текущего языка.
              // Нам нужен доступ к текущему языку. Проще всего просто перезагрузить данные.
              // Но для real-time можно сделать "костыль", если предположить, что язык 'ru'.
              // Давай сделаем правильно: просто перезапросим данные о канале.
              // Это самый надежный способ.

              // Просто вызываем метод, который перезагрузит все данные о канале.
              // WebSocket в данном случае служит просто сигналом к обновлению.
              refreshChannelData();

              // Старый код с copyWith удаляем, так как он был некорректным.
            }
          } catch (e) {
            logger.d("[WS CUBIT] ❌ Ошибка обработки 'channel_updated': $e");
          }
          break;
      // --- 👆 КОНЕЦ ЗАМЕНЫ 👆 ---

        default:
          break;
      }
    });
  }

  @override
  Future<void> close() {
    _webSocketSubscription?.cancel();
    _typingTimer?.cancel();
    return super.close();
  }
}