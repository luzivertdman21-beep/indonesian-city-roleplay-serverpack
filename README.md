# Indonesian City Roleplay Serverpack

Modular FiveM serverpack project using **ESX Legacy** and **oxmysql**, with Indonesian-language setup documentation and support for user-provided MLOs, vehicles, EUP, maps, and props.

> **Status: staged development.** This repository is not yet a complete production serverpack. The current implemented milestone is the ESX integration foundation. Other resource directories are work in progress and must not be treated as finished gameplay systems. No paid or third-party assets are bundled.

## Milestone 1: ESX integration foundation
- Resource `esx_core` obtains the live ESX player object; it does not create fake/demo player identities or duplicate ESX users.
- Server callback `icrp_core:getProfile` returns the connected player's ID, name, job, cash, and bank balance from ESX.
- Client export `exports.esx_core:GetProfile()` and local event `icrp_core:profileUpdated` expose the current profile to other client resources.
- `/icrpinfo` reports server/job information.
- Database connection is checked through oxmysql on startup.
- The server config and install notes explain external ESX dependencies and startup order.

## Requirements
Install and configure these separately; upstream framework resources are not vendored in this repository:
- FiveM server artifacts and a valid server license key
- MariaDB/MySQL database
- `oxmysql`
- ESX Legacy `es_extended`
- ESX identity/character resources if using character creation and multicharacter (for example `esx_identity`, `esx_multicharacter`, and their documented dependencies)

Use the dependency list and compatibility notes in [`docs/INSTALL.md`](docs/INSTALL.md). Confirm the exact dependencies for the versions you install; do not copy paid assets or resources without permission.

## Setup
1. Clone/download the repository into your server data directory.
2. Install upstream ESX Legacy resources in `resources/[esx]/` and oxmysql in a resource folder.
3. Create a database and import [`database/01_schema.sql`](database/01_schema.sql), then [`database/02_seed_jobs.sql`](database/02_seed_jobs.sql), then [`database/03_icrp_extensions.sql`](database/03_icrp_extensions.sql). The schema contains legacy planning tables; it does not replace the schema required by your installed ESX resources.
4. Set `mysql_connection_string`, `sv_licenseKey`, and RCON settings privately in `server.cfg` or txAdmin. Never commit real credentials.
5. Ensure the dependencies before `esx_core`, then start the server through txAdmin.
6. Review [`docs/INSTALL.md`](docs/INSTALL.md) and [`docs/TESTING.md`](docs/TESTING.md).

## Resource layout
```text
resources/
├── [core]/       # ESX integration foundation
├── [esx]/        # Install upstream ESX resources here
├── [jobs]/       # Work in progress
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

## Compatibility
- OneSync is enabled in the sample configuration.
- Custom assets are optional and are not included.
- Configure the character limit in both this resource and the chosen multicharacter resource.
- This project does not ship a generated ZIP artifact. GitHub's **Code → Download ZIP** downloads the current repository snapshot.

## Roadmap
Character/multicharacter integration and profile persistence are the next milestone; then job modules, inventory/UI, police/EMS, economy/vehicles, housing/business, and admin. Each milestone should be tested against the chosen upstream ESX versions before being called production-ready.
