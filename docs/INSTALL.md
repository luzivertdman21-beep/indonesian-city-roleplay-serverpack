# Panduan Instalasi (Bahasa Indonesia)

Dokumen ini mencakup milestone fondasi ESX. Serverpack belum mencakup seluruh fitur Roleplay yang direncanakan.

## Dependency

Wajib:
- FiveM server artifacts dan license key server.
- MariaDB/MySQL.
- `oxmysql` (gunakan rilis resmi yang sesuai dengan dokumentasinya).
- ESX Legacy `es_extended`.

Untuk pembuatan identitas dan karakter, pasang rangkaian ESX yang kompatibel, biasanya meliputi `esx_identity`, `esx_multicharacter`, serta dependency UI/skin yang disebutkan oleh versi upstream yang dipilih. Resource upstream tidak disalin ke repository ini. Ikuti dokumentasi dari versi yang benar-benar dipasang.

## Database
1. Buat database, misalnya `icrp`, dengan charset `utf8mb4`.
2. Atur kredensial database di txAdmin/server.cfg; jangan gunakan akun MySQL root untuk server publik.
3. Import SQL ESX dari rilis ESX Legacy yang dipasang terlebih dahulu.
4. Import `database/01_schema.sql`, `database/02_seed_jobs.sql`, dan `database/03_icrp_extensions.sql` sesuai urutan. Catatan: tabel legacy pada schema awal belum menjadi pengganti tabel ESX. Hindari menggunakannya sebagai sumber data karakter ESX.

## Memasukkan asset sendiri
- **MLO/maps/props:** tempatkan tiap asset dalam resource terpisah di `resources/[mlo]/` atau `resources/[maps]/`; ikuti manifest dan urutan dependency pembuat asset.
- **Kendaraan addon:** tempatkan resource kendaraan di `resources/[vehicles]/`, pastikan meta files dan `fxmanifest.lua` sesuai petunjuk asset, lalu `ensure` nama resource sebenarnya.
- **EUP:** letakkan resource yang Anda miliki di `resources/[eup]/`, dan ikuti setup component/appearance resource yang digunakan. Jangan memasukkan asset berbayar yang lisensinya tidak Anda miliki.

## Konfigurasi job dan admin
Job dan admin gameplay belum selesai di milestone ini. Jangan memberikan ACE/admin permission luas sebelum menginstal dan mengonfigurasi modul admin yang sudah diaudit. Konfigurasikan job/grade di sistem ESX yang Anda gunakan, lalu uji akses dan gaji pada server lokal.

## Menjalankan
1. Atur `sv_licenseKey`, `mysql_connection_string`, hostname dan password di server.cfg/txAdmin.
2. Pastikan `oxmysql` berjalan sebelum `es_extended`; pastikan `es_extended` berjalan sebelum `esx_core`.
3. Pasang dan pastikan resource identitas/multicharacter yang diperlukan tersedia sebelum server dibuka ke publik.
4. Jalankan server lewat txAdmin dan periksa console untuk error resource atau database.

Jangan menganggap server siap produksi sebelum seluruh checklist `docs/TESTING.md` berhasil di lingkungan staging.
