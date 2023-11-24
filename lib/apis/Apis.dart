class Apis {
  static String apiUrl = "http://15.237.71.190:3000/"; //15.237.71.190
  static String image = "${apiUrl}images/";
  // players routes
  static String fetchPlayers = "${apiUrl}player/players/";
  static String createPlayer = "${apiUrl}player/addplayer";
  static String fetchSinglePlayer = "${apiUrl}player/players/";
  static String updatePlayer = "${apiUrl}player/update/";
  static String deletePlayer = "${apiUrl}player/delete/";
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
  static String updateFixture = "${apiUrl}fixture/fixture/";
  static String deleteFixture = "${apiUrl}fixture/delete/";
  static String runningFixture = "${apiUrl}fixture/";
  // reports
  static String addResult = "${apiUrl}result/addresult";
  static String fetchResults = "${apiUrl}result/results";
  static String fetchSingleResult = "${apiUrl}result/results/";

  // match dates
  static String addMatchDates = "${apiUrl}match/add";
  static String getMatchDates = "${apiUrl}match/get";
  static String deleteMatchDates = "${apiUrl}match/delete/";
  static String updateMatchDates = "${apiUrl}match/update/";
}
