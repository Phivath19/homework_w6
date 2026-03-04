import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/songs/song.dart';
import '../../states/settings_state.dart';
import '../../theme/theme.dart';
import 'home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = context.watch<HomeViewModel>();
    AppSettingsState settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(child: Text("Home", style: AppTextStyles.heading)),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Your recent songs",
                style: TextStyle(
                  color: Colors.pink[300],
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.recentSongs.length,
              itemBuilder: (context, index) => SongTile(
                song: viewModel.recentSongs[index],
                isPlaying: viewModel.isPlaying(viewModel.recentSongs[index]),
                onTap: () => viewModel.play(viewModel.recentSongs[index]),
                onStop: () => viewModel.stop(),
              ),
            ),

            const SizedBox(height: 30),

           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "You might also like",
                style: TextStyle(
                  color: Colors.pink[300],
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.recommendedSongs.length,
              itemBuilder: (context, index) => SongTile(
                song: viewModel.recommendedSongs[index],
                isPlaying: viewModel.isPlaying(viewModel.recommendedSongs[index]),
                onTap: () => viewModel.play(viewModel.recommendedSongs[index]),
                onStop: () => viewModel.stop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: isPlaying
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("playing", style: const TextStyle(color: Colors.amber)),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onStop,
                  child: Text(
                    "STOP",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}