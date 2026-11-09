# Checklist Pengujian Server

## Fondasi ESX
- [ ] `oxmysql` starts and connects to the configured database.
- [ ] ESX Legacy starts before `esx_core` with no missing exports.
- [ ] `esx_core` starts without Lua errors.
- [ ] Connect as a player; ESX loads the player and `/icrpinfo` displays the expected server/job information.
- [ ] Verify `exports.esx_core:GetProfile()` after player load.
- [ ] Change job through ESX and verify the profile refreshes.
- [ ] Logout and verify the client profile is cleared.

## Job duty module
- [ ] `job_manager` starts after `es_extended` and `esx_core` without errors.
- [ ] A job listed in `Config.DutyJobs` can use `/duty` and receives the correct status notification.
- [ ] An unconfigured job receives a denial notification and no duty state change.
- [ ] Verify another resource can query `exports.job_manager:IsOnDuty(playerId)` server-side.
- [ ] Verify duty is reset on job change and disconnect.
- [ ] Confirm ESX salary remains configured only once; this module does not pay salaries.

## Not covered by these milestones
Character creation/multicharacter persistence, inventory UI, economy transactions, police/EMS gameplay, admin panel, housing/business, phone, and production load/security testing remain unimplemented or unverified. Run tests in a staging environment; no FiveM runtime is available in this repository editing workflow, so do not mark these checks complete without executing them yourself.
