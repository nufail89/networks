Campus Network Infrastructure Automation & Backup Toolkit
Repositori ini berisi kumpulan skrip otomatisasi konfigurasi dan manajemen jaringan inti berbasis MikroTik RouterOS yang diterapkan untuk pengelolaan infrastruktur jaringan kampus.

Ikhtisar Komponen Sistem
Otomatisasi Manajemen Bandwidth (DHCP Lease Script): Skrip terintegrasi pada DHCP server yang secara dinamis membuat, memperbarui, atau menghapus aturan Simple Queue dan alokasi rate-limit secara otomatis berdasarkan status koneksi perangkat klien (lease bound/unbound).  
PDF

Wake-on-LAN (WoL) Automation: Kumpulan skrip utilitas untuk menyalakan perangkat server, komputer unit, atau workstation administratif secara jarak jauh melalui jaringan lokal (interface bridge atau port spesifik).  
PDF

Keamanan & Pemeliharaan Jaringan: Skrip pemeliharaan otomatis untuk membersihkan orphaned queue, mengelola address-list, serta memperbarui daftar blokir ancaman secara berkala.  
PDF

Struktur Direktori Repositori
Plaintext
├── dhcp-scripts/
│   └── dynamic-simple-queue.rsc  # Logika pembuatan queue otomatis via DHCP lease
├── firewall-rules/
│   └── botnet-refresh.rsc        # Skrip manajemen dan refresh address-list
├── wol-utility/
│   └── remote-wol.rsc            # Kumpulan skrip Wake-on-LAN untuk server & unit[cite: 1]
└── README.md
Contoh Implementasi Skrip Utama
1. Dynamic Simple Queue via DHCP Lease
Logika skrip ini dijalankan secara otomatis oleh DHCP Server untuk mendeteksi perangkat yang terhubung dan langsung menerapkan bandwidth profile secara dinamis tanpa intervensi manual[cite: 1]:

Cuplikan kode
:if ($leaseBound = "1") do={
    :local hostname [/ip dhcp-server lease get [find where active-mac-address=$leaseActMAC && active-address=$leaseActIP] host-name]
    :if ([:len $hostname] = 0) do={ :set hostname $leaseActMAC }
    :local queueName ("Client-" . $hostname)
    
    :if ([:len [/queue simple find name=$queueName]] = 0) do={
        /queue simple add name=$queueName target=($leaseActIP . "/32") limit-at=5M/5M max-limit=10M/10M parent="Nusantara"
    }
} else={
    :local queueName ("Client-" . $leaseActMAC)
    /queue simple remove [find name=$queueName]
}
2. Wake-on-LAN (WoL) Otomatis
Skrip praktis untuk memicu sinyal magic packet ke perangkat server atau workstation penunjang operasional[cite: 1]:

Cuplikan kode
/tool wol interface="bridge0-Nusantara46" mac=84:A9:3E:8F:F0:27
Panduan Penggunaan & Keamanan
Sanitasi Data: Seluruh file konfigurasi di dalam repositori ini telah dibersihkan dari Serial Number, Software ID, IP Publik, serta Credential sensitif demi mematuhi standar keamanan institusi.

Penerapan: Sesuaikan nama interface bridge, nama parent queue, serta alokasi subnet IP sebelum mengimpor skrip ke dalam lingkungan RouterOS Anda.
