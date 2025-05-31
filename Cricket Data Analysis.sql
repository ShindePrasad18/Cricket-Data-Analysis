use Cricket_Data_Analysis


# 1. Rename the Column '100','50','0','4s','6s'
ALTER TABLE Cricket_Data RENAME COLUMN `100` TO `Centuries`;
ALTER TABLE Cricket_Data RENAME COLUMN `50` TO `Fifties`;
ALTER TABLE Cricket_Data RENAME COLUMN `0` TO `Zeroes`;
ALTER TABLE Cricket_Data RENAME COLUMN `4s` TO `Fours`;
ALTER TABLE Cricket_Data RENAME COLUMN `6s` TO `Sixes`;

# 2. Find Top 5 Performers.
select *
from Cricket_Data
order by Runs desc
limit 5;


# 3. Players with Average over 50
select *
from Cricket_Data
where Average > 50;


# 4. Players with Highest Centuries
select Player, Centuries
from Cricket_Data
order by Centuries desc
limit 10;


# 5. What is the average career length per country?
select Country, avg(Cricket_Data.Carrier_Length)
from Cricket_Data
group by Country;


# 6. Which player has the highest batting average?
select Cricket_Data.Player, Cricket_Data.Average
from Cricket_Data
order by Average desc
limit 1;


# 7. Which players have the highest strike rates?
select Cricket_Data.Player, Cricket_Data.Strike_Rate
from Cricket_Data
order by Strike_Rate desc
limit 1;


# 8. What is the distribution of centuries per player?
SELECT Centuries, COUNT(*) AS No_Players
FROM cricket_data
GROUP BY Centuries
ORDER BY Centuries;


# 9. What is the ratio of 50s to 100s for each player?
SELECT Player,
       Fifties,
       Centuries,
       case
           when Centuries = 0 then null
           else Fifties / Centuries
           end as 50_to_100_ratio
from Cricket_Data;

# 10. Which players have the most consistent batting average over long careers.
SELECT Player,
       Carrier_Length,
       Average,
       CAST(Zeroes AS SIGNED) AS Ducks
FROM cricket_data
WHERE Carrier_Length > 10
ORDER BY Average DESC, CAST(Zeroes AS SIGNED) ASC
LIMIT 10;


# 11. Which players have scored the most boundaries.
select Cricket_Data.Player, Fours + Sixes as Boundaries
from Cricket_Data
order by Boundaries desc
limit 10;



# 12. Who has the highest percentage of not outs per innings?
select player,
       Cricket_Data.Innings,
       Cricket_Data.Not_Outs,
       (Cricket_Data.Not_Outs / Innings) * 100 as Not_Out_Percentage
from Cricket_Data_Analysis.Cricket_Data
order by Not_Out_Percentage desc
limit 10;


# 13. Which decade produced the most high-average player?
select floor((Cricket_Data.Start_Year / 10)) * 10 as Decade, count(*) as No_of_Player
from Cricket_Data
where Average > 50
group by Decade
order by No_of_Player desc
limit 10;


# 14. Is there a correlation between strike rate and batting average?
SELECT (
           (COUNT(*) * SUM(Strike_Rate * Average) - SUM(Strike_Rate) * SUM(Average)) /
           SQRT((COUNT(*) * SUM(Strike_Rate * Strike_Rate) - SUM(Strike_Rate) * SUM(Strike_Rate)) *
                (COUNT(*) * SUM(Average * Average) - SUM(Average) * SUM(Average)))
           ) AS correlation
FROM cricket_data
WHERE Strike_Rate IS NOT NULL
  AND Average IS NOT NULL;


# 15. What’s the average number of matches per year per player?
SELECT Player,
       Matches,
       Carrier_Length,
       CAST(Matches AS FLOAT) / Carrier_Length AS Matches_per_Year
FROM cricket_data
ORDER BY Matches_per_Year DESC
LIMIT 10;


# 16. Which country has the highest average player strike rate?
select country, avg(Cricket_Data.Strike_Rate) as avg_strike_rate
from Cricket_Data
group by country
order by avg_strike_rate desc
limit 10;

# 17. How many players have a highest score above 200?
select count(Cricket_Data.Player)
from Cricket_Data
where Highest_Score >= 200;
