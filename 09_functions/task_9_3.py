# -*- coding: utf-8 -*-
"""
Задание 9.3

Создать функцию get_int_vlan_map, которая обрабатывает конфигурационный файл коммутатора
и возвращает кортеж из двух словарей:
* словарь портов в режиме access, где ключи номера портов, а значения access VLAN (числа):
{'FastEthernet0/12': 10,
 'FastEthernet0/14': 11,
 'FastEthernet0/16': 17}

* словарь портов в режиме trunk, где ключи номера портов, а значения список разрешенных VLAN (список чисел):
{'FastEthernet0/1': [10, 20],
 'FastEthernet0/2': [11, 30],
 'FastEthernet0/4': [17]}
У функции должен быть один параметр config_filename, который ожидает как аргумент имя конфигурационного файла.
Проверить работу функции на примере файла config_sw1.txt
Ограничение: Все задания надо выполнять используя только пройденные темы.
"""
def get_int_vlan_map(config_filename):
	trunk_dict=dict()
	access_dict=dict()
	with open(config_filename,'r') as file:
		for  line in file:
			if line.find('interface FastEthernet')>=0:
				temp = line.split('\n')[0] 
			if line.find('switchport access vlan')>=0:
				access_dict[temp]=line.split()[3].split('\\')[0]
			elif line.find('switchport trunk allowed vlan')>=0:
				trunk_dict[temp]=line.split()[4].split('\\')[0].split(',')
	return trunk_dict, access_dict

print(get_int_vlan_map('config_sw1.txt'))