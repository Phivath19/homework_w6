import 'user_history_repo.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  @override
  List<String> fetchRecentSongIds() {
  
    return ['101', '102'];
  }
}