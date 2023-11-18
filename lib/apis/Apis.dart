class Apis {
  static String apiUrl = "http://15.237.71.190:3000/";
  static String image = "${apiUrl}images/";
  // players routes
  static String fetchPlayers = "${apiUrl}player/players/";
  static String createPlayer = "${apiUrl}player/addplayer";
  static String fetchSinglePlayer = "${apiUrl}player/players/";
  static String updatePlayer = "${apiUrl}player/update/";
  // league routes
  static String fetchLeagues = "${apiUrl}league/leagues";
  static String fetchSingleLeague = "${apiUrl}league/leagues/";
  static String createLeague = "${apiUrl}league/addleague";
  static String updateLeague = "${apiUrl}update/league/";
  // teams
  static String fetchTeams = "${apiUrl}team/teams/";
  static String createTeam = "${apiUrl}team/addteam";
  static String fetchSingleTeam = "${apiUrl}team/singleteam/";
  static String updateTeam = "${apiUrl}update/team/";

  // fixtures
  static String fetchFixtures = "${apiUrl}fixture/";
  static String createFixture = "${apiUrl}fixture/addfixture";
  static String fetchSingleFixture = "${apiUrl}fixture/";
  static String updateFixture = "${apiUrl}update/fixture/";
}
