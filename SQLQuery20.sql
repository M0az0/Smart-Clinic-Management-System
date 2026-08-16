-- =====================================================================
-- Smart Clinic Management System with Intelligent Healthcare Assistant
-- Database: ClinicDB
-- Target DBMS: Microsoft SQL Server (run in SSMS)
-- Source: Clinic_ERD_and_Schema.pdf (Section 2 - Relational Schema)
--
-- NOTE ON FOREIGN KEYS:
-- SQL Server does not allow "multiple cascade paths" (a table reachable
-- by more than one CASCADE route to the same ancestor). In this schema,
-- Patient reaches Prescription both directly (Prescription.PatientID)
-- and via MedicalRecord (Patient -> MedicalRecord -> Prescription).
-- SQL Server would refuse to create the FKs if CASCADE were used here.
-- To keep the script simple and guaranteed to run without errors, every
-- FK below uses ON DELETE NO ACTION ON UPDATE NO ACTION (SQL Server's
-- equivalent to "RESTRICT" - blocks the delete/update instead of
-- cascading it).
-- =====================================================================

-- =====================================================================
-- SECTION 1: DATABASE CREATION
-- =====================================================================
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ClinicDB')
BEGIN
    CREATE DATABASE ClinicDB;
END
GO

USE ClinicDB;
GO

-- =====================================================================
-- DROP TABLES (reverse dependency order, safe for re-running script)
-- =====================================================================
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS DrugInteraction;
DROP TABLE IF EXISTS PrescriptionDetail;
DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS MedicalRecord;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Drug;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Department;
GO

-- =====================================================================
-- SECTION 2: TABLE CREATION (dependency order)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Table: Department
-- ---------------------------------------------------------------------
CREATE TABLE Department (
    DepartmentID    INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName  VARCHAR(100) NOT NULL,
    Location        VARCHAR(150) NULL,
    Phone           VARCHAR(20)  NULL,
    CONSTRAINT UQ_Department_Name UNIQUE (DepartmentName)
);
GO

-- ---------------------------------------------------------------------
-- Table: Doctor
-- ---------------------------------------------------------------------
CREATE TABLE Doctor (
    DoctorID            INT IDENTITY(1,1) PRIMARY KEY,
    Name                VARCHAR(100) NOT NULL,
    Specialization      VARCHAR(100) NOT NULL,
    Phone               VARCHAR(20)  NULL,
    Email               VARCHAR(100) NULL,
    AvailabilityStatus  VARCHAR(20) DEFAULT 'Available',
    DepartmentID        INT NOT NULL,
    CONSTRAINT UQ_Doctor_Email UNIQUE (Email),
    CONSTRAINT FK_Doctor_Department
        FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- ---------------------------------------------------------------------
-- Table: Patient
-- ---------------------------------------------------------------------
CREATE TABLE Patient (
    PatientID     INT IDENTITY(1,1) PRIMARY KEY,
    Name          VARCHAR(100) NOT NULL,
    DateOfBirth   DATE NOT NULL,
    Gender        VARCHAR(10)  NULL,
    Phone         VARCHAR(20)  NOT NULL,
    Address       VARCHAR(200) NULL,
    BloodType     VARCHAR(5)   NULL
);
GO

-- ---------------------------------------------------------------------
-- Table: Drug
-- ---------------------------------------------------------------------
CREATE TABLE Drug (
    DrugID       INT IDENTITY(1,1) PRIMARY KEY,
    DrugName     VARCHAR(100) NOT NULL,
    Description  VARCHAR(255) NULL,
    CONSTRAINT UQ_Drug_Name UNIQUE (DrugName)
);
GO

-- ---------------------------------------------------------------------
-- Table: Appointment
-- ---------------------------------------------------------------------
CREATE TABLE Appointment (
    AppointmentID    INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentDate  DATE NOT NULL,
    AppointmentTime  TIME NOT NULL,
    Status           VARCHAR(20) DEFAULT 'Scheduled',
    UrgencyLevel     VARCHAR(20) DEFAULT 'Normal',
    PriorityScore    INT DEFAULT 0,
    PatientID        INT NOT NULL,
    DoctorID         INT NOT NULL,
    CONSTRAINT FK_Appointment_Patient
        FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT FK_Appointment_Doctor
        FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- ---------------------------------------------------------------------
-- Table: MedicalRecord
-- ---------------------------------------------------------------------
CREATE TABLE MedicalRecord (
    RecordID    INT IDENTITY(1,1) PRIMARY KEY,
    VisitDate   DATE NOT NULL,
    Diagnosis   VARCHAR(255) NULL,
    Notes       VARCHAR(MAX) NULL,
    PatientID   INT NOT NULL,
    DoctorID    INT NOT NULL,
    CONSTRAINT FK_MedicalRecord_Patient
        FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT FK_MedicalRecord_Doctor
        FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- ---------------------------------------------------------------------
-- Table: Prescription
-- ---------------------------------------------------------------------
CREATE TABLE Prescription (
    PrescriptionID    INT IDENTITY(1,1) PRIMARY KEY,
    PrescriptionDate  DATE NOT NULL,
    PatientID         INT NOT NULL,
    DoctorID          INT NOT NULL,
    RecordID          INT NOT NULL,
    CONSTRAINT FK_Prescription_Patient
        FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT FK_Prescription_Doctor
        FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT FK_Prescription_MedicalRecord
        FOREIGN KEY (RecordID) REFERENCES MedicalRecord(RecordID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- ---------------------------------------------------------------------
-- Table: PrescriptionDetail
-- Junction table resolving Prescription M:N Drug
-- ---------------------------------------------------------------------
CREATE TABLE PrescriptionDetail (
    PrescriptionDetailID  INT IDENTITY(1,1) PRIMARY KEY,
    PrescriptionID        INT NOT NULL,
    DrugID                INT NOT NULL,
    Dosage                VARCHAR(50) NOT NULL,
    Frequency             VARCHAR(50) NOT NULL,
    Duration              VARCHAR(50) NOT NULL,
    CONSTRAINT FK_PrescriptionDetail_Prescription
        FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT FK_PrescriptionDetail_Drug
        FOREIGN KEY (DrugID) REFERENCES Drug(DrugID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- ---------------------------------------------------------------------
-- Table: DrugInteraction
-- Self-referencing junction table resolving Drug M:N Drug
-- ---------------------------------------------------------------------
CREATE TABLE DrugInteraction (
    InteractionID  INT IDENTITY(1,1) PRIMARY KEY,
    Drug1ID        INT NOT NULL,
    Drug2ID        INT NOT NULL,
    SeverityLevel  VARCHAR(20) NOT NULL,
    Description    VARCHAR(255) NULL,
    CONSTRAINT FK_DrugInteraction_Drug1
        FOREIGN KEY (Drug1ID) REFERENCES Drug(DrugID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT FK_DrugInteraction_Drug2
        FOREIGN KEY (Drug2ID) REFERENCES Drug(DrugID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- ---------------------------------------------------------------------
-- Table: Payment
-- ---------------------------------------------------------------------
CREATE TABLE Payment (
    PaymentID      INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID  INT NOT NULL,
    Amount         DECIMAL(10,2) NOT NULL,
    PaymentDate    DATE NOT NULL,
    PaymentMethod  VARCHAR(30) NULL,
    PaymentStatus  VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT FK_Payment_Appointment
        FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO

-- =====================================================================
-- END OF SCRIPT
-- =====================================================================