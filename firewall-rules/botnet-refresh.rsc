# Script Name: update_ip_meris_botnet
# Description: Refresh address-list entries for threat mitigation

:local listName "blocked-meris-botnet"

:foreach entry in=[/ip firewall address-list find list=$listName] do={
    /ip firewall address-list disable $entry
    /ip firewall address-list enable $entry
}

:log info "Address-list '$listName' entries have been refreshed."
