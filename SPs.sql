DELIMITER //
CREATE PROCEDURE spMenuByRole(IN in_roles_array TEXT)
BEGIN
	DECLARE id INT;
	DECLARE sub_father INT DEFAULT -1;
	DECLARE father INT;
	DECLARE ids_list TEXT DEFAULT "";
	DECLARE done INT DEFAULT FALSE;
	
	DECLARE menu_cursor CURSOR FOR
		SELECT m.id, m.father_id FROM menu m
		WHERE m.id IN (
			SELECT mf.menu_id FROM menu_functionality mf WHERE mf.functionality_id IN (
				SELECT f.id FROM functionality f WHERE f.id IN (
					SELECT rf.functionality_id FROM role_functionality rf WHERE rf.role_id IN (
						SELECT r.id FROM role r WHERE r.id IN (in_roles_array)
					)
				)
			)
		);
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN menu_cursor;
		menu_loop:LOOP
			IF done THEN 
				LEAVE menu_loop;
			END IF;
			FETCH menu_cursor INTO id, father;
			IF father IS NOT NULL THEN
				SET ids_list = CONCAT(father,",",ids_list);
				SET sub_father = father;
				WHILE sub_father IS NOT NULL DO
					SELECT m.father_id INTO sub_father FROM menu m where m.id = sub_father;
					IF sub_father IS NOT NULL THEN
						SET ids_list = CONCAT(sub_father,",",ids_list);
					END IF;
			    END WHILE;
			END IF;
			SET ids_list = CONCAT(id,",",ids_list);
		END LOOP menu_loop;
	CLOSE menu_cursor;
	SELECT DISTINCT m.* FROM menu m where FIND_IN_SET(m.id, ids_list);
END //
DELIMITER ;

CALL spMenuByRole('1');
