--Procedure
DROP PROCEDURE IF EXISTS proc_new_coach;
DELIMITER $$
CREATE PROCEDURE proc_new_coach
(
        T_name varchar(30),
        new_name varchar(30)
)

BEGIN
        UPDATE Teams SET coach = new_name WHERE Team_name = T_name;

END $$
DELIMITER ;

--Function
DROP FUNCTION IF EXISTS fn_avg_goals;
DELIMITER $$
CREATE FUNCTION fn_avg_goals
(
        player_id int
)
RETURNS INT
BEGIN
        DECLARE games_played int;
        DECLARE total_goals int;
        DECLARE average int;

        SELECT COUNT(player_id) INTO games_played FROM Plays p WHERE p.player_id = player_id;
        SELECT COUNT(scoredBy) INTO total_goals FROM Scored s WHERE s.scoredBy = player_id;

        SET average = total_goals / games_played;

        return average;

END $$
DELIMITER ;

--View
DROP VIEW IF EXISTS goals_view;
CREATE OR REPLACE VIEW goals_view AS
 SELECT x.player_name, count(s.scoredBy) as 'Goals' FROM Scored s JOIN Plays p ON s.scoredBy = p.player_id JOIN Players x ON s.scoredBy = x.id Group by scoredBy having count(s.scor\
edBy) > 0;
-- Examples and CASES are on the REPORT 
