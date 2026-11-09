# Indonesian City Roleplay Serverpack

Serverpack starter ini merupakan fondasi FiveM Roleplay Indonesia yang dibuat dengan struktur modular, siap dikembangkan menjadi kota Roleplay realistis. Project ini mengadopsi arsitektur ESX Legacy, MySQL/oxmysql, dan pola resource yang bisa ditambahkan modul lain tanpa merusak integrasi.

## Fitur inti yang sudah ada
- Struktur resource modular
- Konfigurasi server dasar
- SQL schema lengkap untuk data utama
- Core resource siap terhubung dengan ESX
- Job manager dasar
- Police, EMS, dan Mechanic starter resources
- Inventory dan admin base module
- HUD UI placeholder yang siap dikembangkan
- Dokumen instalasi dan setup database

## Struktur proyek
```text
resources/
├── [core]/
│   └── esx_core/
├── [inventory]/
│   └── inventory/
├── [jobs]/
│   └── job_manager/
├── [police]/
│   └── police/
├── [ems]/
│   └── ems/
├── [mechanic]/
│   └── mechanic/
├── [admin]/
│   └── admin/
├── [ui]/
│   └── hud/
├── [vehicles]/
│   └── vehicle_manager/
├── [business]/
│   └── business/
├── [housing]/
│   └── housing/
├── [phone]/
│   └── phone/
└── [standalone]/
    └── logger/

database/
├── 01_schema.sql
└── 02_seed_jobs.sql

server.cfg
README.md
```

## Persyaratan sistem
- FiveM server build terbaru
- MariaDB / MySQL
- oxmysql
- ESX Legacy (es_extended, esx_identity, esx_phone, esx_menu_default, esx_status, esx_society)
- txAdmin (disarankan)

## Langkah setup cepat
1. Salin folder `resources` ke folder server FiveM Anda.
2. Import SQL dari `database/01_schema.sql` dan `database/02_seed_jobs.sql`.
3. Konfigurasi MySQL di `server.cfg`.
4. Pastikan dependency ESX dan oxmysql sudah diinstall.
5. Jalankan server via txAdmin atau `run.cmd`.

## Catatan penting
Project ini adalah foundation yang siap dikembangkan. Fitur-fitur besar seperti MDT, inventory modern, housing, business, voice, dan custom UI memerlukan iterasi lanjutan sesuai kebutuhan kota Roleplay Anda. Bagian core, database, dan struktur modular sudah dibangun agar pengembangan berikutnya lebih cepat dan teratur.

## Lisensi
MIT
