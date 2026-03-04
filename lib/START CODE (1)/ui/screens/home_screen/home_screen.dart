import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../data/repositories/user/user_history_repo.dart';
import '../../states/player_state.dart';
import 'home_view_model.dart';
import 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        songRepository: context.read<SongRepository>(),
        userHistoryRepository: context.read<UserHistoryRepository>(),
        playerState: context.read<PlayerState>(),
      )..init(),
      child: const HomeContent(),
    );
  }
}