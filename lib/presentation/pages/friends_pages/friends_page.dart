import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/friends_cubit.dart';
import 'package:my_kv/logic/cubit/friends_state.dart';
import 'package:my_kv/presentation/pages/friends_pages/widgets/friend_card.dart';
import 'package:my_kv/routes/platform_routes.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => FriendsCubit()..loadFriends(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () => context.push(PlatformRoutes.qrPage.route),
              child: Text(
                l10n.addFriend,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<FriendsCubit, FriendsState>(
          builder: (context, state) {
            if (state is FriendsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }

            if (state is FriendsLoaded) {
              if (state.friends.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.group_add_rounded,
                            size: 100,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          l10n.noFriendsYet,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.inviteFriendsDesc,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () =>
                              context.push(PlatformRoutes.qrPage.route),
                          icon: const Icon(Icons.share_rounded),
                          label: Text(l10n.sendInvitation),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.friends.length,
                itemBuilder: (context, index) {
                  final friend = state.friends[index];
                  return FriendCard(
                    name: friend['name'] ?? l10n.unknown,
                    balance: 0.0,
                  );
                },
              );
            }

            return Center(child: Text(l10n.loadingError));
          },
        ),
      ),
    );
  }
}
