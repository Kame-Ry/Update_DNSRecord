# Script Name: Update-DNSRecord.ps1
# Description: This script updates or adds an A record in DNS and logs the IP address in a file.

# Hostname and DNS Server Configuration
$hostname = "insert domain here" # Example domain
$dnsServer = "8.8.8.8" # Google's public DNS server for example purposes

# Get the IP Address of the Hostname
$records = Resolve-DnsName -Name $hostname -Server $dnsServer -Type A -ErrorAction SilentlyContinue

if ($records) {
    # Filter to ensure we only process records with an IPAddress property
    $aRecords = $records | Where-Object { $_.QueryType -eq 'A' }

    if ($aRecords) {
        $ipAddress = $aRecords | Select-Object -First 1 -ExpandProperty IPAddress
        Write-Host "The IP address of $hostname is: $ipAddress"

        # DNS Zone Configuration
        $zoneName = "insert zone domain here" # Example DNS zone
        $recordName = "www"

        # Update or Add the IP and TTL in an A Record
        $existingRecord = Get-DnsServerResourceRecord -Name $recordName -ZoneName $zoneName -RRType "A" -ErrorAction SilentlyContinue
        if ($existingRecord) {
            # Record exists, so update it
            $newRecord = [ciminstance]::new($existingRecord)
            $newRecord.TimeToLive = [System.TimeSpan]::FromHours(2)
            $newRecord.RecordData.IPv4Address = $ipAddress
            Set-DnsServerResourceRecord -NewInputObject $newRecord -OldInputObject $existingRecord -ZoneName $zoneName -PassThru -ErrorAction Stop
            Write-Host "Updated DNS A record for $recordName.$zoneName with IP $ipAddress and TTL 2 hours"
        } else {
            # Record does not exist, so create it
            Add-DnsServerResourceRecordA -Name $recordName -ZoneName $zoneName -IPv4Address $ipAddress -TimeToLive 02:00:00 -ErrorAction Stop
            Write-Host "Created DNS A record for $recordName.$zoneName with IP $ipAddress and TTL 2 hours"
        }

        # Log the IP address
        $logFilePath = [System.IO.Path]::Combine([Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments), "DNSUpdateLog.txt")
        Add-Content -Path $logFilePath -Value "Updated/Added IP: $ipAddress - $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))"
    } else {
        Write-Host "A records exist but could not extract an IP address."
    }
} else {
    Write-Host "No A records found for $hostname."
}
