import 'package:samba_stats/services/player_service.dart';

import '../models/handball_player_model.dart';
import '/exports/exports.dart';

class PlayerController with ChangeNotifier {
  // fetching single hand ball data
  HandBallPlayerModel _handBallData = HandBallPlayerModel(
    id: '',
    league: '',
    player: '',
    shirtNo: '',
    to: 0,
    gls: 0,
    ast: 0,
    mx: 0,
    blk: 0,
    ste: 0,
    ks: 0,
    twoMin: 0,
    rc: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
  );
  HandBallPlayerModel get handBallData => _handBallData;
  Future<void> fetchSingleHandBallPlayer(
      String playerId, String leagueId) async {
    PlayerService.getHandBallPlayers(playerId: playerId, leagueId: leagueId)
        .then((result) {
      _handBallData = result;
      notifyListeners();
    });
  }

  // handle loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
