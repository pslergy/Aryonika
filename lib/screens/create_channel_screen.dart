// lib/screens/create_channel_screen.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // Импорт
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/common/neon_glow_button.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen({super.key});

  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

class _CreateChannelScreenState extends State<CreateChannelScreen> {
  final _nameController = TextEditingController();
  final _handleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Uint8List? _avatarBytes;
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _avatarBytes = bytes;
      });
    }
  }

  void _createChannel() {
    if (_formKey.currentState?.validate() ?? false) {
      String? avatarBase64;
      if (_avatarBytes != null) {
        avatarBase64 = base64Encode(_avatarBytes!);
      }

      context.read<AppCubit>().createChannel(
        name: _nameController.text,
        description: _descriptionController.text,
        handle: _handleController.text,
        topicKey: 'general', // TODO: Add topic selection
        avatarBase64: avatarBase64,
      ).then((newChannelId) {
        if (newChannelId != null) {
          context.pushReplacement('/channel-details/$newChannelId');
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _handleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state.channelCreationError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.channelCreationError!), backgroundColor: Colors.redAccent)
          );
        }
      },
      child: Scaffold(
        body: AnimatedCosmicBackground(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                centerTitle: true,
                title: Text(l10n.createChannelTitle).animate().fadeIn(delay: 300.ms), // "Создание Трансляции"
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: _avatarBytes != null ? MemoryImage(_avatarBytes!) : null,
                            child: _avatarBytes == null
                                ? const Icon(Icons.add_a_photo, size: 40, color: Colors.white70)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 32),

                        _buildTextField(
                          controller: _nameController,
                          label: l10n.channelNameLabel, // "Название трансляции"
                          hint: l10n.channelNameHint,   // "Например, 'Ежедневные прогнозы...'"
                          validator: (val) => val!.isEmpty ? l10n.errorChannelNameEmpty : null, // "Название не может быть пустым"
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          controller: _handleController,
                          label: l10n.channelHandleLabel, // "Уникальный ID (@handle)"
                          hint: "taro_daily",
                          prefixText: "@",
                          validator: (val) => val!.length < 4 ? l10n.errorChannelHandleShort : null, // "ID должен быть длиннее 4 символов"
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          controller: _descriptionController,
                          label: l10n.channelDescriptionLabel, // "Описание"
                          hint: l10n.channelDescriptionHint,   // "Расскажите, о чем ваш канал..."
                          maxLines: 4,
                          validator: (val) => val!.isEmpty ? l10n.errorChannelDescriptionEmpty : null, // "Добавьте описание"
                        ),
                        const SizedBox(height: 48),

                        BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) {
                            return state.isCreatingChannel
                                ? const CircularProgressIndicator()
                                : NeonGlowButton(
                              text: l10n.createButton, // "Создать"
                              onPressed: _createChannel,
                            );
                          },
                        ),
                      ].animate(interval: 100.ms).fadeIn().slideY(begin: 0.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? prefixText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixText: prefixText,
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white30),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.pinkAccent)),
      ),
    );
  }
}