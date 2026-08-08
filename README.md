# 🏥 Smart Clinic Management System

### Intelligent Healthcare Assistant — Database Systems Project

> A centralized relational database designed to modernize clinic operations, streamline appointment scheduling, organize medical records, and support safer prescription decisions — powered entirely by SQL.

**Innovation University — Faculty of Computers and Information Technology**

---

## 📌 Overview

Traditional clinics often rely on manual or disconnected systems to manage patient records, doctor schedules, and appointments — leading to duplicate records, scheduling conflicts, slow retrieval of medical history, and prescription errors such as prescribing conflicting medications.

The **Smart Clinic Management System** solves this with a single normalized MySQL database (3NF) covering the clinic's core operations, plus a set of lightweight *intelligent features* built entirely with SQL logic — no external AI/ML frameworks.

## 🎯 Objectives

- Organize patient, doctor, and appointment data in a centralized, normalized database
- Reduce redundancy and prevent scheduling conflicts
- Store and retrieve complete medical histories, prescriptions, and billing records efficiently
- Automatically prioritize urgent cases in the appointment queue
- Detect and warn against potentially conflicting drug prescriptions
- Recommend suitable doctors based on specialization and current availability

## ✨ Core Features

| Module | What it does |
|---|---|
| 👤 **Patient Management** | Registers patient personal and medical details, keeps a continuous medical history per patient |
| 👨‍⚕️ **Doctor & Department Management** | Tracks doctors, their specialization, department, and availability status |
| 📅 **Appointment Management** | Schedules visits with a status (`Scheduled` / `Completed` / `Cancelled`) and an urgency level |
| 🩺 **Medical Records** | Documents diagnoses and clinical notes per visit |
| 💊 **Prescriptions** | Supports multiple drugs per prescription, each with its own dosage, frequency, and duration |
| 💰 **Payments** | Tracks billing per appointment, payment method, and status |

## 🧠 Intelligent Features (SQL-only, no external AI/ML)

| Feature | How it works |
|---|---|
| **Appointment Prioritization** | A trigger sets `PriorityScore` automatically from `UrgencyLevel` (`Normal` / `Urgent` / `Emergency`) whenever a new appointment is inserted |
| **Drug Interaction Check** | A trigger checks the `DrugInteraction` reference table before a new `PrescriptionDetail` row is inserted, blocking known conflicting drug pairs by severity |
| **Doctor Recommendation** | A view/stored procedure filters doctors by specialization and current availability |

> ⚠️ The three features above are implemented via **Triggers, Views, and Stored Procedures** — see [Project Status](#-project-status) for what's already built vs. still in progress.

## 🗂️ Database Entities (10 tables, 3NF)

`Department` · `Doctor` · `Patient` · `Appointment` · `MedicalRecord` · `Prescription` · `Drug` · `PrescriptionDetail` · `DrugInteraction` · `Payment`

## 🛠️ Tech Stack

- **DBMS:** MySQL
- **Modeling:** ERD in both Crow's Foot (implementation-ready) and Chen (conceptual) notation, designed with [dbdiagram.io](https://dbdiagram.io)
- **Schema:** Relational schema normalized to 3NF

## 📂 Repository Contents

| File | Description |
|---|---|
| `Clinic_Project_Report.docx` | Full project report — introduction, objectives, ERD, schema |
| `ClinicDB_Schema.sql` | Executable MySQL DDL script (`CREATE DATABASE` + all 10 tables with PK/FK constraints) |
| `schema.dbml` | DBML source — paste into dbdiagram.io to regenerate or edit the ERD |
| `ERD_CrowsFoot.png` | ERD in Crow's Foot notation (implementation-ready view) |
| `ERD_Chen.png` | ERD in Chen notation (conceptual view: entities, attributes, relationships as diamonds) |

## 🚀 Getting Started

1. **Clone or download** this repository
2. Open **MySQL Workbench** (or any MySQL client) and connect to your server
3. Open `ClinicDB_Schema.sql` and run it (⚡ Execute) — this creates the `ClinicDB` database and all 10 tables in the correct order
4. Open `schema.dbml` on [dbdiagram.io](https://dbdiagram.io) if you want to view or edit the ERD interactively

## ✅ Project Status

- [x] ERD — Crow's Foot notation
- [x] ERD — Chen notation
- [x] Relational schema (3NF) + DDL scripts
- [ ] Triggers (appointment priority, drug-interaction check)


---


