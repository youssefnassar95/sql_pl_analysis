-- Author: Youssef Nassar
-- 

-- Checking if the season data is complete 
--each team should have played twice against their opponents (a home match and an away match)
select 
	"Season_End_Year", 
    count("Season_End_Year") as Matches_Played
from premier-league-matches
group by "Season_End_Year"
Order by "Season_End_Year";

/* The Premier League was reduced to 20 teams starting from the 1995/1996 season. 
However, the first three seasons of the Premier League were played with 22 teams in the league.*/

-- Selecting seasons stats - results: home wins, draws, away wins and as well as percentage for each result type
select 
	"Season_End_Year", 
    count("Season_End_Year") as matches_count,

    count(CASE WHEN "FTR" = 'H' THEN "FTR" END) as Home_Wins, 
    (cast(count(CASE WHEN "FTR" = 'H' THEN "FTR" END) as decimal(10,2))/cast(count("Season_End_Year") as decimal(10,2)))*100 as Home_Wins_Percentage,
    
    count(CASE WHEN "FTR" = 'D' THEN "FTR" END) as Draws, 
    (cast(count(CASE WHEN "FTR" = 'D' THEN "FTR" END) as decimal(10,2))/cast(count("Season_End_Year") as decimal(10,2)))*100 as Draws_Percentage,
    
    count(CASE WHEN "FTR" = 'A' THEN "FTR" END) as Away_Wins, 
    (cast(count(CASE WHEN "FTR" = 'A' THEN "FTR" END) as decimal(10,2))/cast(count("Season_End_Year") as decimal(10,2)))*100 as Away_Wins_Percentage

from premier_league_stats
group by "Season_End_Year"
order by  Home_Wins_Percentage DESC;
/*The most home wins (percentage) were in season 2009/2010, second most in 2005/2006 - both above 50%.
Another interesting thing - in season 2018/2019 there were less than 20% of draws -> 18.68%
There were above 40% away wins in season 2020/2021, which is much more than average (second most away wins 33.95% in 2021/2022).*/


-- Selecting seasons stats - goals scored and goals per game for each season
select 
	"Season_End_Year", sum("HomeGoals" + "AwayGoals") as Goals_Scored, cast(sum("HomeGoals" + "AwayGoals")/count("Season_End_Year") as decimal (10,2)) as Goals_Per_Game
from premier_league_stats
group by "Season_End_Year"
order by Goals_Per_Game DESC;
/*During the 2018/2019 and 2021/2022 seasons, the highest average number of goals scored per game was 2.82. 
On the other hand, the lowest average number of goals scored per game occurred during the 2006/2007 season, with an average of 2.45 goals per game.*/

-- Teams total number of goals scored

SELECT Team, SUM(Goals) AS TotalGoals
FROM (
    SELECT "Home" AS Team, "HomeGoals" AS Goals
    FROM premier_league_stats
    UNION ALL
    SELECT "Away" AS Team, "AwayGoals" AS Goals
    FROM premier_league_stats
) AS Combined
GROUP BY Team
ORDER BY TotalGoals DESC;

/* Creating new table with home match stats for each team
SORTED! To get the same order for both tables
*/
CREATE table home_wins As
select 
	"Season_End_Year",
    "Home",
    count(CASE WHEN "FTR" = 'H' THEN "FTR" END) as HomeWins,
    count(CASE WHEN "FTR" = 'D' THEN "FTR" END) as HomeDraws,
    count(CASE WHEN "FTR" = 'A' THEN "FTR" END) as HomeLoses,
    sum("HomeGoals") as HomeGoalsScored,
    sum("AwayGoals") as HomeGoalsConceded
from premier_league_stats
group by "Season_End_Year", "Home"
order by "Home", "Season_End_Year";

select * from home_wins
order by HomeWins DESC;
/* Only a few teams in Premier League history have achieved 18 out of 19 home wins in a single season. 
These teams include Man City (twice), Man United, Liverpool and Chelsea.*/


/* Creating new table with away match stats for each team
SORTED! To get the same order for both tables
*/
create table away_wins As
select 
	"Season_End_Year",
    "Away",
    count(CASE WHEN "FTR" = 'A' THEN "FTR" END) as AwayWins,
    count(CASE WHEN "FTR" = 'D' THEN "FTR" END) as AwayDraws,
    count(CASE WHEN "FTR" = 'H' THEN "FTR" END) as AwayLoses,
    sum("AwayGoals") as AwayGoalsScored,
    sum("HomeGoals") as AwayGoalsConceded
from premier_league_stats
group by "Season_End_Year", "Away"
order by "Away", "Season_End_Year";

select * from away_wins
order by AwayWins DESC;
/* Only one team in Premier League history has achieved 16 out of 19 away wins in a single season. 
This team is Man City in 2017/2018 season.*/