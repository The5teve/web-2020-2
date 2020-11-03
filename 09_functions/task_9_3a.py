# -*- coding: utf-8 -*-
"""
Задание 9.3a

Сделать копию функции get_int_vlan_map из задания 9.3.

Дополнить функцию:
    - добавить поддержку конфигурации, когда настройка access-порта выглядит так:
            interface FastEthernet0/20
                switchport mode access
                duplex auto
      То есть, порт находится в VLAN 1

В таком случае, в словарь портов должна добавляться информация, что порт в VLAN 1
      Пример словаря: {'FastEthernet0/12': 10,
                       'FastEthernet0/14': 11,
                       'FastEthernet0/20': 1 }

У функции должен быть один параметр config_filename, который ожидает как аргумент имя конфигурационного файла.

Проверить работу функции на примере файла config_sw2.txt


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
			elif line.find('duplex auto')>=0 and temp not in access_dict and temp not in trunk_dict:
				access_dict[temp]='1' 
	return trunk_dict, access_dict
print(get_int_vlan_map('config_sw2.txt'))



