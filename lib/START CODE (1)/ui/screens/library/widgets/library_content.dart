import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/songs/song.dart';
import '../../../theme/theme.dart';
import '../view_model/library_view_model.dart';
import '../../../states/settings_state.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {

    LibraryViewModel viewModel  = context.watch<LibraryViewModel>();

    AppSettingsState settingsState = context.watch<AppSettingsState>();
  

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          const SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) => SongTile(
                song:  viewModel.songs[index],
                isPlaying: viewModel.isPlaying(viewModel.songs[index]) ,
                onTap: () => viewModel.play(viewModel.songs[index]),
                onStop: () => viewModel.stop(),
                
              ),
            ),
          ),
        ],
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
                OutlinedButton(onPressed: onStop,
                 child: Text(
                       "STOP", 
                        style: TextStyle(
                          color: Colors.black, 
                          fontWeight: FontWeight.normal,
                          fontSize: 10,    
                 ),      
             ), 
          ),
          const SizedBox(width: 8),
              ],
            )
          : null,
    );
  }

}