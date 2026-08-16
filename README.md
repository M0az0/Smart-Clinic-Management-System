# 🏥 Smart Clinic Management System ⚕️💊

Relational database design and SQL-based intelligent decision support for clinic operations, built as a Database Systems course project.

`MySQL` `SQL Server` `Database Design` `ERD` `SQL Triggers` `3NF`

## 📊 Project Overview

This academic project applies relational database theory to model and manage clinic operations end-to-end, using:

- **Patient & Doctor Management** — centralized, normalized records instead of paper/spreadsheets
- **Appointment Scheduling** — conflict-free booking with urgency-based prioritization
- **Prescription Safety** — structured multi-drug prescriptions with conflict detection
- **Billing** — payment tracking tied to appointments
- **SQL-Only Intelligence** — priority scoring, drug-interaction checks, and doctor recommendations, all implemented with Triggers, Views, and Stored Procedures (no external AI/ML)

## 🎯 Key Design Metrics

| Metric | Value |
|---|---|
| Entities (Tables) | 10 |
| Relationships | 13 |
| Normal Form | 3NF |
| Intelligent SQL Features | 3 (priority scoring, drug-conflict check, doctor recommendation) |
| ERD Notations Provided | 2 (Crow's Foot + Chen) |

## 📁 Project Structure

```
├── Clinic_Project_Report.docx        # Full project report (intro, objectives, ERD, schema)
├── ClinicDB_Schema_MySQL.sql         # Executable MySQL DDL (CREATE DATABASE + 10 tables)
├── ClinicDB_Schema_SQLServer.sql     # Executable SQL Server DDL (same 10 tables, T-SQL syntax)
├── schema.dbml                       # DBML source — edit/regenerate ERD on dbdiagram.io
├── ERD_CrowsFoot.png                 # ERD — Crow's Foot notation (implementation-ready)
├── ERD_Chen.png                      # ERD — Chen notation (conceptual view)
└── README.md
```

## 🚀 Quick Start

**Option A — MySQL**
```bash
# 1. Open MySQL Workbench and connect to your server
# 2. File > Open SQL Script > ClinicDB_Schema_MySQL.sql > Execute (⚡)
```

**Option B — SQL Server**
```bash
# 1. Open SQL Server Management Studio (SSMS) and connect to your server
# 2. File > Open > File > ClinicDB_Schema_SQLServer.sql > Execute (F5)
```

Both scripts create the same 10 tables, keys, and constraints — pick whichever DBMS you have installed.

**(Optional) View/edit the ERD interactively**
```bash
# Paste schema.dbml into https://dbdiagram.io
```

## 🧠 Intelligent Features (SQL-only)

The project includes 3 lightweight intelligent features implemented entirely in SQL:

1. **Appointment Priority Trigger** — sets `PriorityScore` automatically from `UrgencyLevel` (`Normal` / `Urgent` / `Emergency`)
2. **Drug Interaction Check Trigger** — blocks a new prescription line if it conflicts with a known pair in `DrugInteraction`
3. **Doctor Recommendation View/Procedure** — filters doctors by specialization and current availability

> Status: schema and ERD are complete; the three features above are the next implementation milestone — see [Project Status](#-project-status).

## 🗄️ Database Entities

`Department` · `Doctor` · `Patient` · `Appointment` · `MedicalRecord` · `Prescription` · `Drug` · `PrescriptionDetail` · `DrugInteraction` · `Payment`

## 🔧 Technologies

- MySQL
- MySQL Workbench
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- dbdiagram.io (DBML) for ERD design and schema generation

## ✅ Project Status

- [x] ERD — Crow's Foot notation
- [x] ERD — Chen notation
- [x] Relational schema (3NF) + DDL scripts (MySQL and SQL Server versions)
- [ ] Triggers (appointment priority, drug-interaction check)
- [ ] View / Stored Procedure (doctor recommendation)
- [ ] Sample data (DML)
- [ ] Advanced queries (joins, subqueries, aggregate functions)
- [ ] Final report write-up & presentation

## 🎓 Academic Context

**Course:** Database Systems
**University:** Innovation University — Faculty of Computers and Information Technology
**Project:** Smart Clinic Management System with Intelligent Healthcare Assistant

## 📄 License

This project is available for educational purposes only.

⭐ Star this repo if you found it helpful!
