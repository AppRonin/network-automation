import re

def get_total_onu(file):
    onu_pattern = r"interface\sgpon-onu_\d{1,2}/\d{1,2}/\d{1,2}:\d{1,2}"
    total_onu = len(re.findall(onu_pattern, file))
    return total_onu

def get_onu_list(total_onu, port):
    onu_list = [f"{port}:{onu}" for onu in range(1, total_onu) ]
    return onu_list

def format_conf(conf):
    name_pattern =  r"(name[^\n]*)\n\s+description"
    desc_pattern = r"name[^\n]*\n\s+(description .*)"
    tcount_pattern = r"tcont \d{1,2} name [^\n]*"
    tcount_gap_pattern = r"tcont \d{1,2} gap mode\d{1,2}"
    gem_pattern = r"gemport \d{1,2} name [^\n]*"

    name = re.findall(name_pattern, conf)
    desc = re.findall(desc_pattern, conf)
    tcounts = re.findall(tcount_pattern, conf)
    tcounts = [re.sub(r"allocid\s\d+\s", "", tcount) for tcount in tcounts]
    tcount_gaps = re.findall(tcount_gap_pattern, conf)
    gem_ports = re.findall(gem_pattern, conf)
    gem_ports = [gem.replace("unicast ", "").replace("dir both ", "") for gem in gem_ports]
    gem_ports = [re.sub(r"portid\s\d+\s", "", gem) for gem in gem_ports]

    new_conf = name + desc + tcounts + tcount_gaps + gem_ports

    return new_conf

def get_onu_conf(file, onu_list):
    onu_conf = {}

    for onu in onu_list:
        onu_id = onu[-1]
        conf_pattern = rf"interface\sgpon-onu_\d{{1,2}}/\d{{1,2}}/\d{{1,2}}:{onu_id}\n([^!]*!)"
        conf = "".join(re.findall(conf_pattern, file, re.MULTILINE))
        formatted_conf= format_conf(conf)

        onu_conf[onu] = formatted_conf

    return onu_conf

def build_template(onu_conf):
    templates = []
    for key, values in onu_conf.items():
        template = f"inteface gpon_onu-{key}\n"
        for value in values:
            template += f" {value}\n"
        
        template += "!\n"
        templates.append(template)

    result = "".join(templates)
    return result