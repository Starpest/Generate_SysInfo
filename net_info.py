import socket
import uuid
import subprocess

def get_network_info():
    network_info = {}
    host_name = socket.gethostname()
    network_info["Host Name"] = host_name
    network_info["IP Address"] = socket.gethostbyname(host_name)
    network_info["Local IP"] = socket.gethostbyname("localhost")
    network_info["Public IP"] = get_public_ip()

    dhcp_info = get_dhcp_info()
    network_info.update(dhcp_info)

    dns_info = get_dns_info()
    network_info.update(dns_info)

    mac_address = get_mac_address()
    network_info["MAC Address"] = mac_address

    vpn_info = get_vpn_info()
    network_info.update(vpn_info)

    return network_info

def get_public_ip():
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
            s.connect(("8.8.8.8", 80))
            public_ip = s.getsockname()[0]
        return public_ip
    except:
        return "N/A"

def get_dhcp_info():
    dhcp_info = {}
    try:
        output = subprocess.check_output(["ipconfig", "/all"]).decode("utf-8")
        index = output.find("DHCP Enabled")
        dhcp_enabled = output[index:index+26].split(":")[-1].strip()
        dhcp_info["DHCP Enabled"] = dhcp_enabled
    except:
        dhcp_info["DHCP Enabled"] = "N/A"
    return dhcp_info

def get_dns_info():
    dns_info = {}
    try:
        output = subprocess.check_output(["ipconfig", "/all"]).decode("utf-8")
        index = output.find("DNS Servers")
        dns_servers = output[index:index+100].split(":")[-1].strip()
        dns_info["DNS Servers"] = dns_servers
    except:
        dns_info["DNS Servers"] = "N/A"
    return dns_info

def get_mac_address():
    return ':'.join(['{:02x}'.format((uuid.getnode() >> ele) & 0xff) for ele in range(0,8*6,8)][::-1])

def get_vpn_info():
    vpn_info = {}
    try:
        output = subprocess.check_output(["ipconfig"]).decode("utf-8")
        vpn_enabled = "Yes" if "TAP" in output else "No"
        vpn_info["VPN Enabled"] = vpn_enabled
    except:
        vpn_info["VPN Enabled"] = "N/A"
    return vpn_info

def generate_report(network_info):
    report = "Network Information Report:\n\n"
    for key, value in network_info.items():
        report += f"{key}: {value}\n"
    return report

if __name__ == "__main__":
    network_info = get_network_info()
    report = generate_report(network_info)
    print(report)
