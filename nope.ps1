$MIN_WAIT = 5
$MAX_WAIT = 10

# Ref: https://docs.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule?view=win10-ps
function set_firewall_rules() {
  # Block Skype
  # Ref: https://support.skype.com/en/faq/FA148/which-ports-need-to-be-open-to-use-skype-for-windows-desktop
  # New-NetFirewallRule -DisplayName "Block Outbound Skype 443 TCP" -Direction Outbound -RemotePort 443 -Protocol TCP -Action Block
  # 3478..3481 | foreach {
  #   New-NetFirewallRule -DisplayName "Block Outbound Skype $_ UDP" -Direction Outbound -RemotePort $_ -Protocol UDP -Action Block
  # }
  # 49152..65535 | foreach {
  #   New-NetFirewallRule -DisplayName "Block Outbound Skype $_ UDP" -Direction Outbound -RemotePort $_ -Protocol UDP -Action Block
  #   New-NetFirewallRule -DisplayName "Block Outbound Skype $_ TCP" -Direction Outbound -RemotePort $_ -Protocol TCP -Action Block
  # }

  New-NetFirewallRule -DisplayName "Block Outbound Skype UDP" -Direction Outbound -RemotePort 3478-3481,49152-65535 -Protocol UDP -Action Block
  New-NetFirewallRule -DisplayName "Block Outbound Skype TCP" -Direction Outbound -RemotePort 443,49152-65535 -Protocol TCP -Action Block


  # Block Wireless
  New-NetFirewallRule -DisplayName "Block Wireless In" -Direction Inbound -InterfaceType Wireless -Action Block
  New-NetFirewallRule -DisplayName "Block Wireless Out" -Direction Outbound -InterfaceType Wireless -Action Block

  # Block port 80
  New-NetFirewallRule -DisplayName "Block Outbound Port 80" -Direction Outbound -RemotePort 80 -Protocol TCP -Action Block

  # Block DNS
  New-NetFirewallRule -DisplayName "Block Outbound DNS" -Direction Outbound -RemotePort 53 -Protocol UDP -Action Block
}

function unset_firewall_rules() {
  # Unblock Skype
  # Remove-NetFirewallRule -DisplayName "Block Outbound Skype 443 TCP"
  # 3478..3481 | foreach {
  #   Remove-NetFirewallRule -DisplayName "Block Outbound Skype $_ UDP"
  # }
  #
  # 49152..65535 | foreach {
  #   Remove-NetFirewallRule -DisplayName "Block Outbound Skype $_ UDP"
  #   Remove-NetFirewallRule -DisplayName "Block Outbound Skype $_ TCP"
  # }
  Remove-NetFirewallRule -DisplayName "Block Outbound Skype UDP"
  Remove-NetFirewallRule -DisplayName "Block Outbound Skype TCP"

  # Unblock Wireless
  Remove-NetFirewallRule -DisplayName "Block Wireless In"
  Remove-NetFirewallRule -DisplayName "Block Wireless Out"

  # Unblock port 80
  Remove-NetFirewallRule -DisplayName "Block Outbound Port 80"

  # Unblock DNS
  Remove-NetFirewallRule -DisplayName "Block Outbound DNS"
}

function main() {
  while ($True) {
    set_firewall_rules
    Start-Sleep -Seconds $(Get-Random -Minimum $MIN_WAIT -Maximum $MAX_WAIT)
    unset_firewall_rules
    Start-Sleep -Seconds $(Get-Random -Minimum $MIN_WAIT -Maximum $MAX_WAIT)
  }
}
main
# unset_firewall_rules
