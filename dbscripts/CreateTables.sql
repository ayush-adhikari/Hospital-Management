Create database Hospital_Management;
 Use Hospital_Management;

-- Physician Table creation script.
CREATE TABLE physician
(  
    employeeID int Primary Key,
    Name text NOT NULL,  
    position text,
    ssn int Unique
    );

-- Medication Table creation script.
CREATE TABLE medication
(  
    code int Primary Key,
    name text NOT NULL,  
    brand text,
    description text
    );

-- Nurse Table creation script.
CREATE TABLE nurse
(  
    employeeID int Primary Key,
    Name text NOT NULL,  
    position text,
	registered bit,
    ssn int Unique
    );

-- Procedures Table creation script.
CREATE TABLE procedures
(  
    code int Primary Key,
    Name text NOT NULL,  
    cost real,
    );

-- block Table creation script.
CREATE TABLE block
(  
    blockfloor int,
    blockcode int,
	CONSTRAINT pk_hospital_management_Block PRIMARY KEY(blockfloor, blockcode)
    );

-- department Table creation script.
CREATE TABLE department
(  
    departmentID int Primary Key,
    Name text NOT NULL,  
    head int,
	CONSTRAINT fk_hospital_management_dept FOREIGN KEY(head) REFERENCES physician(employeeid)
    );

-- Trained-In Table creation script.
CREATE TABLE trained_in
(  
    physician int,
    procedure_id int,  
    certificationdate date,
    certificationexpires date,
	PRIMARY KEY(physician, procedure_id),
	CONSTRAINT fk_hospital_management_trainedIN_physician FOREIGN KEY(physician) REFERENCES physician(employeeid),
	CONSTRAINT fk_hospital_management_trainedIN_procedure FOREIGN KEY(procedure_id) REFERENCES procedures(code)
	);

-- Patient Table creation script.
CREATE TABLE patient
(  
    ssn int PRIMARY KEY,
    name text,  
    address text,
    phone text,
	insuranceid int,
	pcp int,
	CONSTRAINT fk_hospital_management_patient_pcp FOREIGN KEY(pcp) REFERENCES physician(employeeid)
	);

-- appointment Table creation script.
CREATE TABLE appointment
(  
    appointmentid int PRIMARY KEY,
    patient int,  
    prepnurse int,
    physician int,
	start_dt_time datetime,
	end_dt_time datetime,
	examinationroom text,
	CONSTRAINT fk_hospital_management_appointment_physician FOREIGN KEY(physician) REFERENCES physician(employeeid),
	CONSTRAINT fk_hospital_management_appointment_patient FOREIGN KEY(patient) REFERENCES patient(ssn),
	CONSTRAINT fk_hospital_management_appointment_prepnurse FOREIGN KEY(prepnurse) REFERENCES nurse(employeeid)
	);

-- Affiliated_with Table creation script.
CREATE TABLE affiliated_with
(  
    physician int,
    department int,  
    primaryaffiliation bit,
	PRIMARY KEY(physician, department),
	CONSTRAINT fk_hospital_management_affiliated_with_physician FOREIGN KEY(physician) REFERENCES physician(employeeid),
	CONSTRAINT fk_hospital_management_affiliated_with_department FOREIGN KEY(department) REFERENCES department(departmentid)
	);

-- on_call Table creation script.
CREATE TABLE on_call
(  
    nurse int,
    blockfloor int,  
    blockcode int,
    oncallstart datetime,
	oncallend datetime,
	PRIMARY KEY(nurse, blockfloor, blockcode, oncallstart, oncallend),
	CONSTRAINT fk_hospital_management_oncall_nurse FOREIGN KEY(nurse) REFERENCES nurse(employeeid),
	CONSTRAINT fk_hospital_management_oncall_block FOREIGN KEY(blockfloor,blockcode) REFERENCES block(blockfloor,blockcode)
	);

-- room Table creation script.
CREATE TABLE room
(  
    roomnumber int PRIMARY KEY,
    roomtype text,  
    blockfloor int,
    blockcode int,
	unavailable bit,
	CONSTRAINT fk_hospital_management_room_block FOREIGN KEY(blockfloor,blockcode) REFERENCES block(blockfloor,blockcode)
	);

-- Stay Table creation script.
CREATE TABLE stay
(  
    stayid int PRIMARY KEY,
    patient int,  
    room int,
    starttime time,
	endtime time
	CONSTRAINT fk_hospital_management_stay_patient FOREIGN KEY(patient) REFERENCES patient(ssn),
	CONSTRAINT fk_hospital_management_stay_room FOREIGN KEY(room) REFERENCES room(roomnumber)
	);

-- undergoes Table creation script.
CREATE TABLE undergoes
(  
    patient int,
    procedure_id int,  
    stay int,
    date date,
	physician int,
	assistingnurse int,
	PRIMARY KEY(patient, procedure_id, stay, date),
	CONSTRAINT fk_hospital_management_undergoes_physician FOREIGN KEY(physician) REFERENCES physician(employeeid),
	CONSTRAINT fk_hospital_management_undergoes_procedure FOREIGN KEY(procedure_id) REFERENCES procedures(code),
	CONSTRAINT fk_hospital_management_undergoes_stay FOREIGN KEY(stay) REFERENCES stay(stayid),
	CONSTRAINT fk_hospital_management_undergoes_patient FOREIGN KEY(patient) REFERENCES patient(ssn),
	CONSTRAINT fk_hospital_management_undergoes_nurse FOREIGN KEY(assistingnurse) REFERENCES nurse(employeeid)
	);


-- prescribes Table creation script.
CREATE TABLE prescribes
(  
    physician int,
    patient int,  
    medication int,
    date date,
	appointment int,
	dose text,
	PRIMARY KEY(physician, patient, medication, date),
	CONSTRAINT fk_hospital_management_prescribes_physician FOREIGN KEY(physician) REFERENCES physician(employeeid),
	CONSTRAINT fk_hospital_management_prescribes_patient FOREIGN KEY(patient) REFERENCES patient(ssn),
	CONSTRAINT fk_hospital_management_prescribes_medication FOREIGN KEY(medication) REFERENCES medication(code),
	CONSTRAINT fk_hospital_management_prescribes_appointment FOREIGN KEY(appointment) REFERENCES appointment(appointmentid)
	);