# Script Name: dynamic-simple-queue
# Description: Dynamic Simple Queue creation and removal based on DHCP lease status

:if ($leaseBound = "1") do={
    :local hoste [/ip dhcp-server lease get [find where active-mac-address=$leaseActMAC && active-address=$leaseActIP] host-name]
    :local queueName "$hoste ($leaseActMAC)"
    
    :local existingQueue [/queue simple find target=($leaseActIP . "/32")]
    :if ([:len $existingQueue] > 0) do={
    } else={
        :if ([:len $hoste] > 0) do={
            /queue simple add name=$queueName target=($leaseActIP . "/32") _limit-at=5M/5M max-limit=10M/10M burst-limit=25M/25M burst-threshold=15M/15M burst-time=4/4 parent="Lokal-Nusantara" queue=default-small/default-small
        } else={
            /queue simple add name=$queueName target=($leaseActIP . "/32") _limit-at=1M/1M max-limit=3M/3M parent="Lokal-Nusantara" queue=default-small/default-small
        }
    }
} else={
    /queue simple remove [find target="$leaseActIP/32"]
}
