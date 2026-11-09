# Checklist Pengujian Server

Milestone 1 checks (jalankan di server staging, bukan server publik):

- [ ] `oxmysql` starts successfully and connects to the configured database.
- [ ] ESX Legacy starts before `esx_core` with no missing exports.
- [ ] `esx_core` starts without Lua errors.
- [ ] Connect as a player; ESX loads the player and `/icrpinfo` displays the expected server/job information.
- [ ] Verify `exports.esx_core:GetProfile()` from a dependent client resource after player load.
- [ ] Change job through the configured ESX job system and verify `icrp_core:profileUpdated` refreshes.
- [ ] Logout and verify the profile is cleared.
- [ ] Restart the resource and confirm the database check logs a successful result.
- [ ] Confirm server.cfg contains no real credentials and the actual server license key is configured privately.

Not yet implemented/tested by this milestone: character creation, multicharacter persistence, inventory UI, economy transactions, police/EMS gameplay, admin panel, housing/business, phone, and production load/security testing. Do not mark the serverpack production-ready based on the foundation checks alone.
