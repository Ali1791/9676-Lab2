# Simple Antivirus Daemon

A simple antivirus system built with Bash scripting that monitors a directory, detects potentially malicious files, and moves them to a quarantine directory.

## Features

* Real-time directory monitoring
* Malicious file detection by extension and content
* File quarantine
* Interactive restore and delete tool
* Cron-based scheduled scanning
* Persistent whitelist support
* Makefile for easy execution

## Project Structure

```text
simple-antivirus/
├── antivirusd.sh
├── antivirus-cron.sh
├── restore.sh
├── Makefile
├── README.md
├── whitelist
├── dir/
└── malicious_dir/
```

* **antivirusd.sh** — Main antivirus daemon
* **antivirus-cron.sh** — Scheduled antivirus scanner
* **restore.sh** — Restore or permanently delete quarantined files
* **Makefile** — Provides commands to run the project
* **whitelist** — Stores files marked as safe
* **dir/** — Monitored directory
* **malicious_dir/** — Quarantine directory

## Detection Rules

### Malicious Extensions

`.exe`, `.bat`, `.vbs`, `.scr`, `.ps1`

### Malicious Keywords

`virus`, `trojan`, `malware`, `worm`, `ransomware`

Keywords are matched case-insensitively and can appear anywhere in the file content.

## Usage

Make the scripts executable:

```bash
chmod +x antivirusd.sh antivirus-cron.sh restore.sh
```

Run the antivirus daemon:

```bash
./antivirusd.sh ./dir ./malicious_dir 5
```

Run the restore tool:

```bash
./restore.sh ./dir ./malicious_dir
```

Or use the Makefile:

```bash
make run-antivirusd
make restore
```

## Cron-Based Scanning

`antivirus-cron.sh` provides scheduled scanning using Linux cron.

The script runs once per cron execution and performs the same detection and quarantine process as the main antivirus daemon.

## Persistent Whitelist

Files restored as false positives are added to the `whitelist` file.

Whitelisted files are skipped during future scans, and the whitelist persists across antivirus restarts.
