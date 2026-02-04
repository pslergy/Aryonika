// lib/screens/onboarding/onboarding_manual_location_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
 // <-- ИМПОРТ


import '../../cubit/onboarding_cubit.dart';
import '../../cubit/onboarding_state.dart';

import 'onboarding_scaffold.dart';

class OnboardingManualLocationScreen extends StatefulWidget {
  final bool isStandalone;
  const OnboardingManualLocationScreen({super.key, this.isStandalone = false});

  @override
  State<OnboardingManualLocationScreen> createState() => _OnboardingManualLocationScreenState();
}

class _OnboardingManualLocationScreenState extends State<OnboardingManualLocationScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // <-- Получаем l10n

    return OnboardingScaffold(
      title: l10n.onboardingLocationTitle, // <-- ЗАМЕНА
      child: WillPopScope(
        onWillPop: () async {
          context.read<OnboardingCubit>().clearLocation();
          return true;
        },
        child: Column(
          children: [
            Text(
              l10n.onboardingLocationSubtitle, // <-- ЗАМЕНА
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
            ).animate().fade(delay: 300.ms).slideY(begin: 0.5),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: l10n.onboardingLocationSearchHint, // <-- ЗАМЕНА
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white30)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.pinkAccent)),
                ),
                onChanged: (query) => context.read<OnboardingCubit>().searchLocations(query),
              ).animate().fade(delay: 500.ms).slideY(begin: 0.5),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                buildWhen: (prev, current) => prev.isLoadingLocations != current.isLoadingLocations || prev.locationSuggestions != current.locationSuggestions,
                builder: (context, state) {
                  if (state.isLoadingLocations) {
                    return const Center(child: CircularProgressIndicator(color: Colors.pinkAccent));
                  }
                  if (state.locationSuggestions.isEmpty && _searchController.text.length >= 3) {
                    return Center(
                      child: Text(
                        l10n.onboardingLocationNotFound, // <-- ЗАМЕНА
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
                      ),
                    );
                  }
                  if (state.locationSuggestions.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.onboardingLocationStartSearch, // <-- ЗАМЕНА
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
                      ),
                    ).animate().fade();
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.locationSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = state.locationSuggestions[index];
                      return Card(
                        color: Colors.white.withOpacity(0.05),
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.location_city, color: Colors.white70),
                          title: Text(suggestion.displayName, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(suggestion.address?.country ?? '', style: const TextStyle(color: Colors.white54)),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            context.read<OnboardingCubit>().onManualLocationSelected(suggestion);
                          },
                        ),
                      ).animate().fade(delay: (100 * index).ms).slideX(begin: -0.2);
                    },
                  );
                },
              ),
            ),
            _buildBottomPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    final l10n = AppLocalizations.of(context)!; // <-- Получаем l10n

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (p, c) => p.location != c.location || p.isLocationSelectedFromList != c.isLocationSelectedFromList,
      builder: (context, state) {
        if (state.location == null) {
          return Container(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              l10n.onboardingLocationSelectFromList, // <-- ЗАМЕНА
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border(top: BorderSide(color: Colors.white.withOpacity(0.2))),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.greenAccent),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  state.location!.displayName,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: state.isLocationSelectedFromList
                    ? () {
                  if (widget.isStandalone) {
                    context.pop(state.location);
                  } else {
                    context.push('/onboarding/finish');
                  }
                }
                    : null,
                child: Text(l10n.onboardingButtonNext), // <-- ЗАМЕНА
              )
            ],
          ),
        ).animate().slideY(begin: 1.0);
      },
    );
  }
}