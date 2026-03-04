import 'package:flutter/widgets.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../data/repositories/user/user_history_repo.dart';
import '../../../model/songs/song.dart';
import '../../states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final UserHistoryRepository _userHistoryRepository;
  final PlayerState _playerState;

  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  HomeViewModel({
    required SongRepository songRepository,
    required UserHistoryRepository userHistoryRepository,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _userHistoryRepository = userHistoryRepository,
        _playerState = playerState {
          
    _playerState.addListener(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged() {
    notifyListeners();
  }
  void init() {

    List<String> recentIds = _userHistoryRepository.fetchRecentSongIds();


    _recentSongs = recentIds
        .map((id) => _songRepository.fetchSongById(id)) 
        .whereType<Song>() 
        .toList();

    List<Song> allSongs = _songRepository.fetchSongs();
    _recommendedSongs = allSongs
        .where((song) => !_recentSongs.contains(song))
        .toList();

    notifyListeners();
  }

  List<Song> get recentSongs => _recentSongs;
  List<Song> get recommendedSongs => _recommendedSongs;
  Song? get currentSong => _playerState.currentSong;
  bool isPlaying(Song song) => _playerState.currentSong == song;

  void play(Song song) {
    _playerState.start(song);
  }

  void stop() {
    _playerState.stop();
  }

  @override
  void dispose() {
    _playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }
}