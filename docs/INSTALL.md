# Panduan Instalasi (Bahasa Indonesia)

Panduan ini untuk milestone fondasi ESX dan duty pekerjaan. Serverpack belum mencakup semua sistem Roleplay yang direncanakan.

## Dependency

Wajib:
- FiveM server artifacts dan license key server.
- MariaDB/MySQL.
- `oxmysql`.
- ESX Legacy `es_extended`.

Untuk pembuatan identitas/karakter, pasang rangkaian ESX yang kompatibel seperti `esx_identity` dan `esx_multicharacter` beserta dependency UI/skin yang tercantum pada dokumentasi upstream versi pilihan Anda. Resource upstream tidak disalin ke project ini.

## Database
1. Buat database, misalnya `icrp`, dengan charset `utf8mb4`.
2. Buat user database khusus server (hindari MySQL root) dan atur connection string di txAdmin/server.cfg.
3. Import SQL yang disertakan dalam rilis ESX Legacy yang Anda pasang.
4. `database/01_schema.sql` dan `02_seed_jobs.sql` adalah skema/seed legacy perencanaan; keduanya bukan pengganti tabel dan seed yang dibutuhkan ESX. `03_icrp_extensions.sql` bersifat tambahan opsional. Duty module saat ini tidak memerlukan tabel SQL tersendiri.

## Pekerjaan dan duty
- Assign job dan grade lewat sistem ESX yang dipasang; modul ini tidak memberi job/grade.
- Atur daftar job yang boleh duty di `resources/[jobs]/job_manager/config.lua`.
- Pemain dengan job terdaftar menggunakan `/duty` untuk mengubah status duty.
- Duty disimpan sementara di memori dan kembali non-duty saat pemain disconnect atau ganti job.
- Job salary tetap mengikuti pengaturan ESX; modul ini tidak membayar gaji tambahan.

## Asset sendiri
- **MLO/maps/props:** resource terpisah di `resources/[mlo]/` atau `resources/[maps]/`; ikuti manifest dan urutan dependency pembuat asset.
- **Kendaraan addon:** resource milik Anda di `resources/[vehicles]/`; ikuti dokumentasi asset untuk meta files dan `ensure` nama resource sebenarnya.
- **EUP:** letakkan resource yang Anda miliki di `resources/[eup]/` dan ikuti setup appearance/clothing resource yang digunakan. Jangan gunakan asset berbayar tanpa lisensi.

## Menjalankan
1. Atur `sv_licenseKey`, `mysql_connection_string`, hostname, dan password secara privat di txAdmin.
2. Pastikan dependency tersedia; startup order minimum: `oxmysql`, `es_extended`, `esx_core`, `job_manager`.
3. Jalankan server staging melalui txAdmin dan periksa log startup.
4. Jalankan checklist di `docs/TESTING.md` sebelum membuka server ke publik.

Jangan menganggap server siap produksi sebelum seluruh sistem yang dibutuhkan telah diimplementasikan dan diuji di lingkungan staging.
