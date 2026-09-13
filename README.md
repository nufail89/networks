# Campus Network Infrastructure Automation & Backup Toolkit

Repositori ini berisi kumpulan skrip otomatisasi konfigurasi dan manajemen jaringan inti berbasis MikroTik RouterOS yang diterapkan untuk pengelolaan infrastruktur jaringan kampus.

## Ikhtisar Komponen Sistem

* **Otomatisasi Manajemen Bandwidth (DHCP Lease Script):** Skrip terintegrasi pada DHCP server yang secara dinamis membuat, memperbarui, atau menghapus aturan **Simple Queue** dan alokasi **rate-limit** secara otomatis berdasarkan status koneksi perangkat klien (*lease bound/unbound*).
* **Wake-on-LAN (WoL) Automation:** Kumpulan skrip utilitas untuk menyalakan perangkat server, komputer unit, atau workstation administratif secara jarak jauh melalui jaringan lokal (**interface bridge** atau port spesifik).
* **Keamanan & Pemeliharaan Jaringan:** Skrip pemeliharaan otomatis untuk membersihkan **orphaned queue**, mengelola **address-list**, serta memperbarui daftar blokir ancaman secara berkala.

---

## Struktur Direktori Repositori

```text
├── dhcp-scripts/
│   └── dynamic-simple-queue.rsc  # Logika pembuatan queue otomatis via DHCP lease[cite: 1]
├── firewall-rules/
│   └── botnet-refresh.rsc        # Skrip manajemen dan refresh address-list[cite: 1]
├── wol-utility/
│   └── remote-wol.rsc            # Kumpulan skrip Wake-on-LAN untuk server & unit[cite: 1]
└── README.md
```
## 📐 Ringkasan Topologi Jaringan

Infrastruktur ini dirancang menggunakan MikroTik CCR2004 dengan skema *Dual-ISP* dan segmentasi **VLAN 802.1Q** yang terhubung ke jaringan lokal kampus (*Bridge Nusantara*)[cite: 1]:

```text
       [ ISP 1 (PPPoE) ]       [ ISP 2 (DHCP) ]
            │                         │
            └───────────┬─────────────┘
                        │
             [ CCR2004 Core Router ]
                        │
         ┌──────────────┴──────────────┐
         ▼                             ▼
  [ SFP Trunk Port ]            [ ether10-OLT ]
   ├── VLAN 950 (GMP)            ├── VLAN 1045 (BTI)
   ├── VLAN 951 (Hotspot)        ├── VLAN 1046 (UUD45)
   └── VLAN 952                  └── VLAN 1047 (NKRI)
         │
         ▼
  [ Local Bridges ]
   ├── bridge0-Nusantara46 (Subnet Utama)
   └── Dynamic Simple Queue & DHCP Lease Script[cite: 1]
