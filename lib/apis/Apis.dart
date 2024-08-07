// import 'dart:io';

class Apis {
  static String? apiUrl = "http://45.10.160.145:3000/";
  // players routes
  static String fetchPlayers = "${apiUrl}player/players/";
  static String createPlayer = "${apiUrl}player/addplayer";
  static String fetchSinglePlayer = "${apiUrl}player/players/";
  static String updatePlayer = "${apiUrl}player/update/";
  static String deletePlayer = "${apiUrl}player/delete/";
  static String transferPlayer = "${apiUrl}player/";
  // player options
  // ignore: slash_for_doc_comments
  static String assistRoute = "${apiUrl}player/updateAssist/";
  static String cleanSheetRoute = "${apiUrl}player/updateClean";
  static String goalRoute = "${apiUrl}player/updateGoal/";
  static String yellowCardRoute = "${apiUrl}player/updateYellow/";
  static String redCardRoute = "${apiUrl}player/updateRed/";
  // league routes
  static String fetchLeagues = "${apiUrl}league/leagues";
  static String fetchSingleLeague = "${apiUrl}league/leagues/";
  static String createLeague = "${apiUrl}league/addleague";
  static String updateLeague = "${apiUrl}update/league/";
  // teams
  static String fetchTeams = "${apiUrl}team/teams/";
  static String createTeam = "${apiUrl}team/addteam";
  static String fetchSingleTeam = "${apiUrl}team/singleteam/";
  static String updateTeam = "${apiUrl}team/update/";
  static String deleteTeam = "${apiUrl}team/delete/";
  // fixtures
  static String fetchFixtures = "${apiUrl}fixture/";
  static String createFixture = "${apiUrl}fixture/addfixture";
  static String fetchSingleFixture = "${apiUrl}fixture/";
  static String updateFixture = "${apiUrl}fixture/update/";
  static String deleteFixture = "${apiUrl}fixture/delete/";
  static String runningFixture = "${apiUrl}fixture/";
  // reports
  static String addResult = "${apiUrl}result/addresult";
  static String fetchResults = "${apiUrl}result/results";
  static String fetchSingleResult = "${apiUrl}result/results/";

  // match dates
  static String addMatchDates = "${apiUrl}match/add";
  static String getMatchDates = "${apiUrl}match/get/";
  static String deleteMatchDates = "${apiUrl}match/delete/";
  static String updateMatchDates = "${apiUrl}match/update/";

  // table routes
  static String getTableData = "${apiUrl}table/";
  static String updateTableData = "${apiUrl}table/update/";
  static String deleteTableData = "${apiUrl}table/delete/";
  static String addTableData = "${apiUrl}table/add";
  static String resetTableData = "${apiUrl}table/reset/";

  static String castMessage = "${apiUrl}notify/castMessage";
  // api route for running a fixture
  static String runFixture = "${apiUrl}fixture/runFixture/";
  static String endRunningFixture = "${apiUrl}fixture/endRunningFixture/";
  static String fixtureGoals = "${apiUrl}fixture/updateGoals/";

  // blogs
  static String blogs = "${apiUrl}blogs";
  static String addBlog = "${apiUrl}blogs/add";
  static String updateBlog = "${apiUrl}blogs/edit";
  static String deleteBlog = "${apiUrl}blogs/delete";

//  hand ball stats
  static String addHandBallStats = "${apiUrl}handBall/add";
  static String getHandBallStats = "${apiUrl}handBall/get/";
  static String updateHandBallStats = "${apiUrl}handBall/update/";
  static String deleteHandBallStats = "${apiUrl}handBall/delete/";
  static String fetchHandBallPlayer = "${apiUrl}handBall/player/";
// transfers
  static String transferredPlayers = "${apiUrl}player/";
  static String deleteTransfer = "${apiUrl}player/deleteTransfer/";
}
