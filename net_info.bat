@echo off
setlocal enabledelayedexpansion

python.exe - <<EOF
import subprocess
import re

def get_network_info():
    network_info = {}

    try:
        output = subprocess.check_output(["ipconfig", "/all"]).decode("utf-8")
        
        ipv4_pattern = re.compile(r"(IPv4 Address .+?: )([\d.]+)")
        ipv4_matches = ipv4_pattern.findall(output)
        network_info["IPv4 Address"] = ", ".join(match[1] for match in ipv4_matches)

        ipv6_pattern = re.compile(r"(IPv6 Address .+?: )([\da-fA-F:]+)")
        ipv6_matches = ipv6_pattern.findall(output)
        network_info["IPv6 Address"] = ", ".join(match[1] for match in ipv6_matches)

        dhcp_pattern = re.compile(r"DHCP Server .+?: ([\d.]+)")
        dhcp_matches = dhcp_pattern.findall(output)
        network_info["DHCP Servers"] = ", ".join(match for match in dhcp_matches)

        mac_pattern = re.compile(r"Physical Address .+?: ([\da-fA-F-]+)")
        mac_matches = mac_pattern.findall(output)
        network_info["MAC Address"] = ", ".join(match for match in mac_matches)

    except subprocess.CalledProcessError:
        print("Error: Unable to retrieve network information.")

    return network_info

def generate_report(network_info):
    report = "Network Information Report:\n\n"
    for key, value in network_info.items():
        report += f"{key}: {value}\n"
    return report

if __name__ == "__main__":
    network_info = get_network_info()
    report = generate_report(network_info)
    print(report)
EOF

pause

