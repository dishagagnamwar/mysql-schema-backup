# MySQL Schema Backup

Automated version control for MySQL database schemas. This repository stores
periodic snapshots of your database structure (tables, views, procedures,
triggers, and events) and pushes them to Git automatically, so every schema
change made in MySQL Workbench is tracked with full history — who changed
what, and when.

## Why this exists

MySQL Workbench has no built-in Git integration. This project bridges that
gap with a lightweight script that:

1. Dumps the current schema (structure only, no data) using `mysqldump`.
2. Detects whether anything actually changed since the last snapshot.
3. Commits and pushes the change to this repository automatically.

Data is intentionally excluded — this repo tracks **structure**, not
records, to keep the history readable and avoid committing sensitive data.

## Repository structure

```
mysql-schema-backup/
├── schema/          # Full schema dumps (one .sql file per database)
├── migrations/       # Optional: dated, incremental change scripts
├── scripts/          # Automation scripts (sync.sh / sync.bat)
├── .gitignore         # Excludes credentials, logs, and local config
└── README.md
```

## Prerequisites

- MySQL Server + MySQL Workbench installed locally
- `mysqldump` available on your system PATH
- Git installed and configured
- An SSH key (recommended) or Personal Access Token added to your Git host,
  so pushes can run unattended

## Setup

1. **Clone this repository:**
   ```bash
   git clone git@github.com:<your-username>/mysql-schema-backup.git
   cd mysql-schema-backup
   ```

2. **Create a MySQL credentials file** (kept out of Git via `.gitignore`):
   - Linux/Mac: `~/.mysql_backup.cnf`
   - Windows: `C:\Users\<you>\mysql_backup.cnf`
   ```ini
   [client]
   user=your_user
   password=your_password
   host=127.0.0.1
   ```
   Restrict permissions on Linux/Mac: `chmod 600 ~/.mysql_backup.cnf`

3. **Update the database name** in `scripts/sync.sh` (or `sync.bat` on
   Windows) to match your database.

4. **Test it manually:**
   ```bash
   ./scripts/sync.sh
   ```
   Confirm a new commit appears with your schema changes.

## Automating it

Schedule the script to run on a recurring basis so every change you make in
MySQL Workbench is captured automatically:

- **Linux/Mac:** via `cron` (see `scripts/sync.sh` header comment for a
  sample crontab entry)
- **Windows:** via Task Scheduler, pointing to `scripts\sync.bat`

Once scheduled, no manual step is required — edit your schema in Workbench
as usual, and the next scheduled run will detect and push the change.

## What gets committed

Each commit message is auto-generated with a timestamp, e.g.:

```
Auto schema sync: 2026-08-30 19:00:03
```

If nothing changed since the last run, the script exits without creating an
empty commit.

## Notes

- This tracks schema (DDL), not table data — do not rely on it as a data
  backup solution.
- For proper incremental migration tracking (versioned `ALTER` scripts
  instead of full re-dumps), consider adopting a migration tool such as
  Flyway or Liquibase alongside this repo.
