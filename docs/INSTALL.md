# Panduan Instalasi Bahasa Indonesia

Project ini masih dalam pengembangan bertahap dan belum merupakan serverpack lengkap/production-ready.

## Dependency
- FiveM server artifacts dan license key.
- MySQL/MariaDB dan `oxmysql`.
- ESX Legacy `es_extended`.
- Untuk identitas/karakter: resource ESX identity/multicharacter beserta dependency UI/skin yang disebut dokumentasi upstream versi pilihan.

Semua dependency upstream dipasang terpisah; repository ini tidak menyalin resource framework eksternal.

## Database
1. Buat database dan user MySQL khusus server.
2. Import SQL yang disertakan dengan versi ESX yang Anda install.
3. Import `database/04_economy.sql` dan `database/05_identity_cards.sql` untuk fitur project saat ini.
4. `01_schema.sql` dan `02_seed_jobs.sql` adalah skema legacy perencanaan, bukan schema ESX dan jangan dianggap sebagai pengganti SQL upstream.

## KTP dan pekerjaan
- `/ktp` menampilkan KTP karakter sendiri.
- `/ktp ID` menampilkan KTP pemain lain jika dalam jarak konfigurasi dan routing bucket yang sama.
- Data identitas dibaca dari field ESX identity (`firstName`, `lastName`, `dateofbirth`, `sex`, `phoneNumber`). Field yang tidak tersedia ditampilkan sebagai “Belum diisi”. Nomor `ICRP...` adalah nomor RP internal, bukan NIK resmi.
- Job/grade tetap diatur oleh ESX. Duty hanya sesi sementara, bukan izin untuk melakukan tindakan polisi/EMS.

## Konfigurasi dan uji
- Simpan `sv_licenseKey`, password RCON, dan kredensial database secara privat di txAdmin/server.cfg.
- Startup order: `oxmysql` → `es_extended` → `esx_core` → `job_manager` → `icrp_economy` → `icrp_identity`.
- Masukkan MLO, kendaraan, dan EUP yang Anda miliki sebagai resource tersendiri, ikuti manifest/petunjuk pembuat asset, dan `ensure` resource sebenarnya setelah dependency-nya.
- Uji pada server staging. Lihat `docs/TESTING.md`; belum semua sistem yang diminta tersedia.
