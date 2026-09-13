:if ($leaseBound = "1") do={
    :local hostname [/ip dhcp-server lease get [find where active-mac-address=$leaseActMAC && active-address=$leaseActIP] host-name]
    :if ([:len $hostname] = 0) do={ :set hostname$leaseActMAC }
    :local queueName ("Client-" . $hostname)
    
    :if ([:len [/queue simple find name=$queueName]] = 0) do={
        /queue simple add name=$queueName target=($leaseActIP . "/32") limit-at=5M/5M max-limit=10M/10M parent="Nusantara"
    }
} else={
    :local queueName ("Client-" . $leaseActMAC)
    /queue simple remove [find name=$queueName]
}
