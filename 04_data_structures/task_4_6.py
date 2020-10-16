# -*- coding: utf-8 -*-
"""
Задание 4.6

Обработать строку ospf_route и вывести информацию на стандартный поток вывода в виде:
Prefix                10.0.24.0/24
AD/Metric             110/41
Next-Hop              10.0.13.3
Last update           3d18h
Outbound Interface    FastEthernet0/0

Ограничение: Все задания надо выполнять используя только пройденные темы.

"""

ospf_route = "      10.0.24.0/24 [110/41] via 10.0.13.3, 3d18h, FastEthernet0/0"
ip_template = '''
IP address:
{0:<8} {1:<8} 
{2:<8}{3:<8}
{4:<8} {5:<8} 
{6:<8} {7:<8}

'''
print(ip_template.format("Prefix", "10.0.24.0/24", 'AD/Metric', '[110/41]',,,))
