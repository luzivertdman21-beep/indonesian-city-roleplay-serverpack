# Checklist Pengujian Server

## ESX integration
- [ ] oxmysql connects and ESX starts successfully.
- [ ] `esx_core` starts after ESX and `/icrpinfo` shows current player/job.
- [ ] Profile export refreshes on job change and clears on logout.

## Job duty
- [ ] A configured ESX job can toggle `/duty`; non-configured jobs cannot.
- [ ] Duty resets after job change/disconnect.
- [ ] Salary remains configured only once in ESX.

## Bank commands
- [ ] `icrp_economy` starts after ESX/oxmysql and the `icrp_transactions` table exists.
- [ ] `/saldo` shows the ESX cash and bank balances.
- [ ] Valid deposit and withdrawal change balances by the exact amount.
- [ ] Invalid, fractional, negative, zero, too-large, and unaffordable amounts are rejected.
- [ ] `/transfer` rejects self, offline/invalid target, invalid amount, and insufficient balance.
- [ ] Valid transfer debits/credits the correct online players; `/mutasi` shows only the caller's own outbound history.
- [ ] Cooldown is applied; client-supplied values cannot select another sender.

## Identity card
- [ ] Import `database/05_identity_cards.sql` and start `icrp_identity` after ESX/oxmysql.
- [ ] `/ktp` shows the connected character's identity without exposing the ESX identifier.
- [ ] `/ktp ID` works for a nearby player in the same routing bucket.
- [ ] Request for a distant player, invalid ID, or offline ID is rejected.
- [ ] Test with missing identity fields and confirm the fallback text is displayed.
- [ ] Reconnect/multicharacter switch and verify each ESX identifier has its own saved RP KTP number.

## Not implemented or not verified
Character creation/multicharacter UI, inventory, police/EMS gameplay, admin panel, housing/business, phone, and production load/security testing remain incomplete. This editing environment does not run FiveM; execute all checks in a staging server before production.
