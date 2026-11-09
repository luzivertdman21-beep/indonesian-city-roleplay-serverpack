# Indonesian City Roleplay Serverpack

Modular FiveM serverpack project using **ESX Legacy** and **oxmysql**, with Indonesian setup documentation and optional user-provided MLOs, vehicles, EUP, maps, and props.

> **Status: staged development.** Implemented: ESX profile integration, job duty state, basic banking commands, and server-validated RP KTP display. This is not a complete or production-tested serverpack. Character UI, custom inventory, police/EMS gameplay, admin panel, housing/business, phone, and many requested systems remain unimplemented. No paid assets are bundled.

## Implemented systems
- `esx_core`: reads the live ESX player profile and exposes callback/export.
- `job_manager`: server-authoritative, session-only `/duty` state for configured ESX jobs.
- `icrp_economy`: `/saldo`, `/deposit jumlah`, `/withdraw jumlah`, `/transfer ID jumlah`, `/mutasi`, and transaction history.
- `icrp_identity`: `/ktp` shows your RP identity card; `/ktp ID` shows another player's card only when nearby and in the same routing bucket. KTP data is read from the ESX character and cached per character identifier in MySQL. The generated `ICRP...` number is a roleplay ID, not an official Indonesian NIK.

## Requirements
Install upstream, separately: FiveM server artifacts, MySQL/MariaDB, oxmysql, and ESX Legacy `es_extended`. Character resources such as `esx_identity`/`esx_multicharacter` are also external and must match the installed ESX version. See [`docs/INSTALL.md`](docs/INSTALL.md).

## Setup
1. Install upstream ESX and oxmysql in your server resources.
2. Import ESX's own SQL, then `database/04_economy.sql` and `database/05_identity_cards.sql`.
3. Set private DB credentials and license key in txAdmin/server.cfg; never commit secrets.
4. Ensure in order: `oxmysql`, `es_extended`, `esx_core`, `job_manager`, `icrp_economy`, `icrp_identity`.
5. Test in staging using `docs/TESTING.md`; use GitHub **Code → Download ZIP** for current source snapshot.
