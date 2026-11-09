# Indonesian City Roleplay Serverpack

Modular FiveM serverpack project using **ESX Legacy** and **oxmysql**, with Indonesian setup documentation and optional user-provided MLOs, vehicles, EUP, maps, and props.

> **Status: staged development.** Implemented: ESX profile integration, job duty state, and basic bank commands. This is not a complete or production-tested serverpack. Police/EMS gameplay, character UI, inventory UI, vehicles, admin panel, housing/business, phone, and many requested systems remain unimplemented. No paid assets are bundled.

## Implemented systems
- `esx_core`: reads the live ESX player profile and exposes callback/export.
- `job_manager`: server-authoritative, session-only `/duty` state for configured ESX jobs.
- `icrp_economy`: `/saldo`, `/deposit jumlah`, `/withdraw jumlah`, `/transfer ID jumlah`, and `/mutasi`, with server-side validation, limits, cooldown, ESX account updates, and transaction history table.

## Requirements
Install upstream, separately: FiveM server artifacts, MySQL/MariaDB, oxmysql, and ESX Legacy `es_extended`. Character resources such as `esx_identity`/`esx_multicharacter` are also external and must match the installed ESX version. See [`docs/INSTALL.md`](docs/INSTALL.md).

## Setup
1. Install upstream ESX and oxmysql in your server resources.
2. Import ESX's own SQL, then import `database/04_economy.sql`. The old `01_schema.sql`/`02_seed_jobs.sql` are legacy planning schema and do not replace ESX's SQL.
3. Set private DB credentials and license key in txAdmin/server.cfg; never commit secrets.
4. Ensure in order: `oxmysql`, `es_extended`, `esx_core`, `job_manager`, `icrp_economy`.
5. Test in staging using `docs/TESTING.md`; use GitHub **Code → Download ZIP** for current source snapshot.
