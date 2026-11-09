# Panduan Instalasi Bahasa Indonesia

Project ini masih dalam pengembangan bertahap dan belum merupakan serverpack lengkap/production-ready.

## Dependency
- FiveM server artifacts dan license key.
- MySQL/MariaDB dan `oxmysql`.
- ESX Legacy `es_extended`.
- Untuk karakter: resource identitas/multicharacter ESX serta dependency UI/skin yang disebut dokumentasi upstream versi pilihan.

Semua dependency upstream dipasang terpisah; repository ini tidak menyalin resource framework eksternal.

## Database
1. Buat database dan user MySQL khusus server.
2. Import SQL yang disertakan dengan versi ESX yang Anda install.
3. Import `database/04_economy.sql` untuk tabel riwayat transaksi project.
4. `01_schema.sql` dan `02_seed_jobs.sql` adalah skema legacy perencanaan, bukan schema ESX dan jangan dianggap sebagai pengganti SQL upstream.

## Konfigurasi dan uji
- Simpan `sv_licenseKey`, password RCON, dan kredensial database secara privat di txAdmin/server.cfg.
- Pastikan startup order: `oxmysql` → `es_extended` → `esx_core` → `job_manager` → `icrp_economy`.
- Perintah bank: `/saldo`, `/deposit JUMLAH`, `/withdraw JUMLAH`, `/transfer ID JUMLAH`; riwayat: `/mutasi`.
- Job/grade tetap diatur oleh ESX. Duty hanya sesi sementara, bukan izin untuk melakukan tindakan polisi/EMS.
- Masukkan MLO, kendaraan, dan EUP yang Anda miliki sebagai resource tersendiri, ikuti manifest/petunjuk pembuat asset, dan `ensure` resource sebenarnya setelah dependency-nya.
- Uji pada server staging. Lihat `docs/TESTING.md`; belum semua sistem yang diminta tersedia.
