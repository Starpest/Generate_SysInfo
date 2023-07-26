import platform
import psutil

def get_system_information():
    system_info = {}
    system_info["System"] = platform.system()
    system_info["Node Name"] = platform.node()
    system_info["Release"] = platform.release()
    system_info["Version"] = platform.version()
    system_info["Machine"] = platform.machine()
    system_info["Processor"] = platform.processor()
    system_info["CPU Cores"] = psutil.cpu_count(logical=False)
    system_info["RAM (Total)"] = f"{round(psutil.virtual_memory().total / (1024**3), 2)} GB"
    return system_info

def generate_report(system_info):
    report = "System Information Report:\n\n"
    for key, value in system_info.items():
        report += f"{key}: {value}\n"
    return report

if __name__ == "__main__":
    system_info = get_system_information()
    report = generate_report(system_info)
    print(report)
