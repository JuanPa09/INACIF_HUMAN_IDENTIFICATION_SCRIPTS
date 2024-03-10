INSERT INTO Request_Status(name) VALUES('Ingresada'), ('Pendiente'), ('Confirmada'),('Rechazada'),('Resuelta'),("Validada");

INSERT INTO Settings(eyes, hair, skin, feet, height, complexion, image, sex, maxRequests) 
VALUES(0,0,0,0,0,0,0,0,0);

INSERT INTO Status(name) VALUES('Activo'),('Inactivo'),('Bloqueado');

DELETE FROM Request_Status;

-- Creación del menú
INSERT INTO Menu(name, short, level, father_id, user_modifies, creation_date, modification_date, icon, key_route)
VALUES
('Ingresar Caso', 1, 1, null, 'Administrador', now(), null, 'bx bxs-book-add', "/atencion/casos/nuevo"),
('Solicitudes', 2, 1, null, 'Administrador',  now(), null, 'bx bxs-hand', "/atencion/solicitudes/ver"),
('Reportes', 3, 1, null, 'Administrador',  now(), null, 'bx bxs-bar-chart-alt-2', "/atencion/reportes"),
('Configuraciones', 4, 1, null, 'Administrador',  now(), null, 'bx bx-cog', "/atencion/ajustes"),
('Roles', 5, 1, null, 'Administrador',  now(), null, 'bx bxs-shield', "/atencion/roles"),
('Usuarios', 6, 1, null, 'Administrador', now(), null, 'bx bxs-group', "/atencion/users/consult");
	
-- Creación del sub menú
INSERT INTO Menu(name, short, level, father_id, user_modifies, creation_date, modification_date, icon, key_route)
SELECT 'Ver todas', 2, 2, m1.id, 'Administrador', NOW(), NULL, NULL, '/atencion/solicitudes/ver' FROM Menu m1 WHERE m1.name = 'Solicitudes'
UNION ALL
SELECT 'Atender', 2, 3, m2.id, 'Administrador', NOW(), NULL, NULL, '/atencion/solicitudes/atender' FROM Menu m2 WHERE m2.name = 'Solicitudes'
UNION ALL
SELECT 'Reporte de solicitudes', 3, 1, m3.id, 'Administrador', NOW(), NULL, NULL, '/atencion/reportes' FROM Menu m3 WHERE m3.name = 'Reportes'
UNION ALL
SELECT 'Ver roles', 5, 2, m5.id, 'Administrador', NOW(), NULL, NULL, '/atencion/roles/consult' FROM Menu m5 WHERE m5.name = 'Roles'
UNION ALL
SELECT 'Crear roles', 5, 3, m6.id, 'Administrador', NOW(), NULL, NULL, '/atencion/roles/create' FROM Menu m6 WHERE m6.name = 'Roles'
UNION ALL
SELECT 'Editar roles', 5, 4, m7.id, 'Administrador', NOW(), NULL, NULL, '/atencion/roles/edit' FROM Menu m7 WHERE m7.name = 'Roles';

-- Creación de las funcionalidades
INSERT INTO Functionality(name, description) VALUES
("Ingresar Casos", ""),
("Ver solicitudes", ""),
("Atender solicitudes", ""),
("Generar Reportes", ""),
("Gestionar configuraciones", ""),
("Gestión de usuarios", ""),
("Ver roles", ""),
("Crear roles", ""),
("Editar roles", "");

-- Asociación de funcionalidades con el menú
INSERT INTO Menu_Functionality(menu_id, functionality_id, user_modifies, creation_date) VALUES
((SELECT id FROM Menu WHERE name = "Ingresar Caso"), (SELECT id FROM Functionality WHERE name = "Ingresar Casos"), "Administrador", now()),
((SELECT id FROM Menu WHERE name = "Ver todas"), (SELECT id FROM Functionality WHERE name = "Ver solicitudes"), "Administrador", now()),
((SELECT id FROM Menu WHERE name = "Atender"), (SELECT id FROM Functionality WHERE name = "Atender solicitudes"), "Administrador", now()),
((SELECT id FROM Menu WHERE name = "Reportes"), (SELECT id FROM Functionality WHERE name = "Generar Reportes"), "Administrador", now()),
((SELECT id FROM Menu WHERE name = "Configuraciones"), (SELECT id FROM Functionality WHERE name = "Gestionar configuraciones"), "Administrador", now()),
((SELECT id FROM Menu WHERE name = "Usuarios"), (SELECT id FROM Functionality WHERE name = "Gestión de usuarios"), "Administrador", now()),
((SELECT id FROM menu WHERE name = 'Ver roles'), (SELECT id FROM functionality WHERE name = 'Ver roles'), "Administrador", now()),
((SELECT id FROM menu WHERE name = 'Crear roles'), (SELECT id FROM functionality WHERE name = 'Crear roles'), "Administrador", now()),
((SELECT id FROM menu WHERE name = 'Editar roles'), (SELECT id FROM functionality WHERE name = 'Editar roles'), "Administrador", now());

-- Crear rol administrador
INSERT INTO Role(name, description, user_modifies, creation_date, status_id) VALUES
("Administrador", "Rol administrador", "Administrador", now(), (SELECT id FROM Status WHERE name = "Activo"));

-- Asociar funcionalidades al rol administrador
INSERT INTO Role_Functionality(role_id, functionality_id, user_modifies, creation_date) VALUES
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Ingresar Casos"), "Administrador", now()),
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Ver solicitudes"), "Administrador", now()),
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Atender solicitudes"), "Administrador", now()),
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Generar Reportes"), "Administrador", now()),
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Gestionar configuraciones"), "Administrador", now()),
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Gestión de usuarios"), "Administrador", now()),
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Ver roles"), "Administrador", now()),
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Crear roles"), "Administrador", now()),
((SELECT id FROM Role WHERE name = "ia-admin"), (SELECT id FROM Functionality WHERE name = "Editar roles"), "Administrador", now());


-- Crear usuario
INSERT INTO User(username, names, last_names, email, phone, password, creation_date, status_id, role_id) VALUES
('Admin', "Administrador", "", "juanpa.a.l10@gmail.com", 3023780, "123", now(), (SELECT id FROM Status WHERE name = "Activo") ,(SELECT id FROM Role WHERE name = 'Administrador'));
