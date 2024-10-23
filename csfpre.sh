#!/bin/sh
# =============================================================================
# Script: wireguard with CSF (ConfigServer Security & Firewall)
# Purpose: This script sets up firewall rules to allow wireguard VPN traffic
# When using CSF
# Maintainer:  Scott Mcintyre <me@scott.cm>

# =============================================================================
# License:
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# =============================================================================

# ============ USER CONFIGURABLE VARIABLES ============ #
MAIN_INTERFACE="eth0"         # Main interface
WIREGUARD_INTERFACE="wg0"     # Wireguard interface
WIREGUARD_RANGE="10.0.0.1/24" # Wireguard range
WIREGUARD_PORT="52811"        # Wireguard port

# Accept traffic from and to the WireGuard interface
iptables -A INPUT -i $WIREGUARD_INTERFACE -j ACCEPT
iptables -A OUTPUT -o $WIREGUARD_INTERFACE -j ACCEPT

# Allow forwarding from wiregiard to the main network interface
iptables -A FORWARD -i $WIREGUARD_INTERFACE -o $MAIN_INTERFACE -j ACCEPT
iptables -A FORWARD -i $MAIN_INTERFACE -o $WIREGUARD_INTERFACE -j ACCEPT

# NAT for outgoing WireGuard traffic
iptables -t nat -A POSTROUTING -s $WIREGUARD_RANGE -o $MAIN_INTERFACE -j MASQUERADE

iptables -I INPUT -p udp --dport $WIREGUARD_PORT -j ACCEPT

# Allow forwarding from the WireGuard subnet
iptables -I FORWARD -s $WIREGUARD_RANGE -j ACCEPT

# Allow established and related connections
iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
