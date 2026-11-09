# Indonesian City Roleplay Serverpack

Modular FiveM serverpack project using **ESX Legacy** and **oxmysql**, with Indonesian-language setup documentation and support for user-provided MLOs, vehicles, EUP, maps, and props.

> **Status: staged development.** This is not a complete production serverpack. Implemented milestones are the ESX integration foundation and a server-authoritative job duty module. Other resource directories are work in progress and are not ensured by the sample server config. No third-party or paid assets are bundled.

## Implemented milestones

### ESX integration foundation
- `esx_core` reads the connected player from ESX (no fake/demo identities or duplicate user persistence).
- Callback `icrp_core:getProfile` and client export `exports.esx_core:GetProfile()` expose the current ESX profile.
- `/icrpinfo` reports player ID and current job.
- Checks the oxmysql connection when the resource starts.

### Job duty state
- `/duty` toggles a session-only duty state for configured ESX jobs.
- The server determines the player's job from ESX; clients cannot choose a job or another player's ID.
- Duty is cleared on disconnect and job change; optional service counts are emitted for configured public-service jobs.
- Other resources can check `exports.job_manager:IsOnDuty(playerId)` server-side and `exports.job_manager:IsOnDuty()` client-side.
- Job assignment, grade, salary, society, equipment, garage, and boss permissions are not implemented here; manage job assignment through ESX and do not treat duty state as authorization for unrelated actions.

## Requirements
Install and configure these separately; upstream framework resources are not vendored:
- FiveM server artifacts and a valid server license key
- MariaDB/MySQL
- `oxmysql`
- ESX Legacy `es_extended`
- ESX identity/character resources if using character creation and multicharacter (for example `esx_identity`, `esx_multicharacter`, plus their documented dependencies)

Check [`docs/INSTALL.md`](docs/INSTALL.md) and the documentation for the exact upstream versions you install.

## Setup
1. Clone/download this repository into your server data directory.
2. Install upstream ESX Legacy resources in `resources/[esx]/` and oxmysql in your resources directory.
3. Import the ESX SQL provided by the installed version. The legacy planning schema in this repository is not a replacement for ESX's schema.
4. Configure private credentials and `sv_licenseKey` in txAdmin/server.cfg; never commit secrets.
5. Ensure `oxmysql`, then `es_extended`, then `esx_core` and `job_manager`.
6. Review [`docs/INSTALL.md`](docs/INSTALL.md) and [`docs/TESTING.md`](docs/TESTING.md).

## Resource layout
```text
resources/
├── [core]/       # ESX integration foundation
├── [esx]/        # Install upstream ESX resources here
├── [jobs]/       # Duty module; other job gameplay is roadmap
├── [police]/     # Work in progress
├── [ems]/        # Work in progress
├── [mechanic]/   # Work in progress
├── [inventory]/  # Work in progress
├── [ui]/         # Work in progress
├── [vehicles]/   # Work in progress
├── [business]/   # Work in progress
├── [housing]/    # Work in progress
├── [phone]/      # Work in progress
├── [mlo]/        # Add your own resources here
├── [maps]/       # Add your own resources here
├── [eup]/        # Add your own resources here
└── [standalone]/ # Utilities
```

Custom assets are optional and not included. GitHub **Code → Download ZIP** downloads the current repository snapshot; no generated ZIP has been attached.
