use inacif;

CREATE TABLE IF NOT EXISTS Status(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Request_Status(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Role(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    description VARCHAR(255),
    user_modifies VARCHAR(255),
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_id INT,
    CONSTRAINT FK_ROLE_STATUS_ID FOREIGN KEY (status_id) REFERENCES Status(id) ON DELETE CASCADE
);
 
CREATE TABLE IF NOT EXISTS Functionality(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(100) UNIQUE KEY,
    description VARCHAR(150) DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS Menu(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    short INT, -- Posicion en el menu (arriba o abajo)
    level INT NOT NULL,
    father_id INT,
    user_modifies VARCHAR(255) NOT NULL,
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    icon VARCHAR(100),
    key_route VARCHAR(150),
    CONSTRAINT FK_MENU_FATHER FOREIGN KEY (father_id) REFERENCES Menu(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Role_Functionality(
	role_id INT NOT NULL,
    functionality_id INT NOT NULL,
    user_modifies VARCHAR(255) NOT NULL,
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(role_id, functionality_id),
    CONSTRAINT FK_ROLE_FUNCTIONALITY_ROL_ID FOREIGN KEY (role_id) REFERENCES Role(id) ON DELETE CASCADE,
    CONSTRAINT FK_ROLE_FUNCTIONALITY_FUNCTIONALITY_ID FOREIGN KEY (functionality_id) REFERENCES Functionality(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Menu_Functionality(
	menu_id INT NOT NULL,
    functionality_id INT NOT NULL,
    user_modifies VARCHAR(255),
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(menu_id, functionality_id),
    CONSTRAINT FK_MENU_FUNCTIONALITY_MENU_ID FOREIGN KEY (menu_id) REFERENCES Menu(id) ON DELETE CASCADE,
    CONSTRAINT FK_MENU_FUNCTIONALITY_FUNCTIONALITY_ID FOREIGN KEY (functionality_id) REFERENCES Functionality(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Campus(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    department VARCHAR(255),
    municipality VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Case_Info(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    case_name VARCHAR(255),
    age INT(3),
    sex ENUM('Hombre', 'Mujer'),
    eyes VARCHAR(80),
    hair VARCHAR(80),
    skin VARCHAR(80),
    feet INT(2),
    height INT(3),
    disappearance_municipality VARCHAR(250),
    image VARCHAR(255),
    survey_date date,
    additional_description VARCHAR(250),
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Request(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    attention_date date DEFAULT NULL,
    attention_user VARCHAR(250) DEFAULT NULL,
    status_id INT,
    case_id INT DEFAULT NULL,
    applicant_nationality ENUM('Guatemalteco', 'Extranjero'),
    applicant_identification_type ENUM('DPI', 'PASAPORTE'),
    applicant_identification_number VARCHAR(13),
    applicant_birthdate date, -- YYYY-MM-DD
    applicant_names VARCHAR(250),
    applicant_last_names VARCHAR(250),
    applicant_sex ENUM('Hombre', 'Mujer'),
    applicant_phone INT,
    applicant_email VARCHAR(200),
    disappeared_first_name VARCHAR(100),
    disappeared_second_name VARCHAR(100),
    disappeared_other_names VARCHAR(100),
    disappeared_last_name VARCHAR(100),
    disappeared_second_last_name VARCHAR(100),
    disappeared_birthdate date, -- YYYY-MM-DD
    disappeared_height INT,
    disappeared_municipality VARCHAR(100),
    disappeared_complexion VARCHAR(80),
    disappeared_eyes_color VARCHAR(80),
    disappeared_hair_color VARCHAR(80),
    disappeared_feet_size INT,
    disappeared_skin VARCHAR(80),
    disappeared_sex ENUM('Hombre', 'Mujer'),
    image VARCHAR(255),
    additional_description VARCHAR(250),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    similarities INT DEFAULT 0,
    CONSTRAINT FK_REQUEST_CASE_ID FOREIGN KEY (case_id) REFERENCES CASE_INFO(id),
    CONSTRAINT FK_REQUEST_STATUS_ID FOREIGN KEY (status_id) REFERENCES Request_Status(id)
);
ALTER TABLE Request AUTO_INCREMENT=10000;

CREATE TABLE IF NOT EXISTS Confirmation_Code(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    code VARCHAR(40),
    expiration_timestamp timestamp,
    channel ENUM ('email', 'phone') DEFAULT 'email',
    request_id INT,
    CONSTRAINT FK_CONFIRMATION_CODE_REQUEST_ID FOREIGN KEY (request_id) REFERENCES Request(id)
);

CREATE TABLE IF NOT EXISTS Settings(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    eyes INT,
    hair INT,
    skin INT,
    feet INT,
    height INT,
    complexion INT,
    image INT,
    sex INT,
    max_requests INT,
    email_domain VARCHAR(100),
    confirmation_token_expiration_time INT,
    enable_scheduler BOOL,
    scheduler_time TIME
);



