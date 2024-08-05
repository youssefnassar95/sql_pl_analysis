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
