# DNS A Record Updater

This PowerShell script, `Update-DNSRecord.ps1`, simplifies the management of DNS A records. It is crafted to update an existing A record or add a new one if it does not exist, utilizing a specified DNS server for resolution. Additionally, the script logs the updated or newly added IP address for future reference.

## Features

- **DNS Resolution**: Automatically resolves the IP address of a specified hostname.
- **A Record Management**: Updates an existing A record or creates a new one with the resolved IP address.
- **Logging**: Records each update or addition of an IP address with a timestamp in a log file.

## Prerequisites

To run this script, you will need:
- PowerShell 5.1 or higher
- Access rights to manage DNS records on the target DNS server

## Configuration

Before running the script, configure the following variables within the script to match your environment:

- `$hostname`: Specify the FQDN (Fully Qualified Domain Name) of the host for which you are updating the A record.
- `$dnsServer`: Specify the IP address of the DNS server used for resolving the hostname.
- `$zoneName`: Specify the DNS zone name that contains the A record.
- `$recordName`: Specify the record name (usually the same as the hostname without the domain).

## Usage

1. Open PowerShell with administrative privileges.
2. Navigate to the directory containing `Update-DNSRecord.ps1`.
3. Run the script by typing `.\Update-DNSRecord.ps1` and pressing Enter.
4. Observe the output in the PowerShell window for confirmation of the actions taken.

## Logging

The script logs each IP address update or addition along with a timestamp to a file named `DNSUpdateLog.txt` located in the user's Documents folder. This log aids in tracking changes and troubleshooting.

## Disclaimer

This script is provided "as is", without warranty of any kind. Use it at your own risk. Always test in a development environment before deploying to production.

## Contributing

Contributions to enhance `Update-DNSRecord.ps1` are welcome. Please feel free to fork the repository, make your changes, and submit a pull request.
