import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'main_common.dart';
import 'data/repositories/settings/app_settings_repository.dart';
import 'data/repositories/settings/app_settings_repository_mock.dart';
import 'data/repositories/songs/song_repository.dart';
import 'data/repositories/songs/song_repository_mock.dart';
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';

/// Configure provider dependencies for dev environment
List<SingleChildWidget> get devProviders {
  final AppSettingsRepository settingsRepository = AppSettingsRepositoryMock();

  return [
    // 1 - Inject the song repository
    Provider<SongRepository>(create: (_) => SongRepositoryMock()),

    // 2 - Inject the player state
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

    // 3 - Inject the app settings repository
    Provider<AppSettingsRepository>(create: (_) => settingsRepository),

    // 4 - Inject the app setting state with repository
    ChangeNotifierProvider<AppSettingsState>(
      create: (_) {
        final state = AppSettingsState(repository: settingsRepository);
        state.init();
        return state;
      },
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
