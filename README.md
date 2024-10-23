# CSF WireGuard Integration Script

This script allows you to use a WireGuard VPN server with ConfigServer Security & Firewall (CSF) by setting up the various rules.

## Installation

1. Copy the script to `/etc/csf/csfpre.sh`:
   ```sh
   wget -O /etc/csf/csfpre.sh https://raw.githubusercontent.com/Scott-Mc/csf-wireguard/refs/heads/main/csfpre.sh
   ```
2. Ensure the script is executable:
   ```sh
   chmod +x /etc/csf/csfpre.sh
   ```
3. Edit /etc/csf/csfpre.sh and configure the script for your WireGuard setup

   Ensure you configure the following variables in the script to match your WireGuard and server setup:

   - **MAIN_INTERFACE**: The primary network interface on your server (e.g., `eth0`).
   - **WIREGUARD_INTERFACE**: The WireGuard interface (e.g., `wg0`).
   - **WIREGUARD_RANGE**: The IP range used by WireGuard clients (This is the Address = line in your /etc/wireguard/wg0.conf).
   - **WIREGUARD_PORT**: The port WireGuard is listening on (This is the ListenPort confgured in /etc/wireguard/wg0.conf).

   Example:

   ```sh
   MAIN_INTERFACE="eth0"
   WIREGUARD_INTERFACE="wg0"
   WIREGUARD_RANGE="10.0.0.1/24"
   WIREGUARD_PORT="52811"
   ```

4. Restart CSF to apply changes:
   ```sh
   csf -r
   ```

## License

This script is licensed under the MIT License. See the LICENSE file for more details.

## Author and Credits

- **Author**: Scott Mcintyre (<me@scott.cm>)

## Contributing

Feel free to open issues or submit pull requests to contribute to this project. Any improvements or suggestions are welcome.
