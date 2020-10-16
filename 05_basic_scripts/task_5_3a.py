# -*- coding: utf-8 -*-
"""
Задание 5.3a

Дополнить скрипт из задания 5.3 таким образом, чтобы, в зависимости от выбранного режима,
задавались разные вопросы в запросе о номере VLANа или списка VLANов:
* для access: 'Введите номер VLAN:'
* для trunk: 'Введите разрешенные VLANы:'

Ограничение: Все задания надо выполнять используя только пройденные темы.
То есть эту задачу можно решить без использования условия if и циклов for/while.
"""

access_template = [
    "switchport mode access",
    "switchport access vlan {}",
    "switchport nonegotiate",
    "spanning-tree portfast",
    "spanning-tree bpduguard enable",
]

trunk_template = [
    "switchport trunk encapsulation dot1q",
    "switchport mode trunk",
    "switchport trunk allowed vlan {}",
]

template=input('Введите режим работы интерфейса(access/trunk): ')
interface='interface '+input('Введите тип и номер интерфейса: ')

if template == "access":
	vlans = input('Введите номер VLAN: ')
	print(interface)
	print(str(access_template).format(vlans).replace("'","").replace(', ','\n')[1:-1])
elif template == "trunk":
	vlans = input('Введите разрешенные VLANы: ')
	print(interface)
	print(str(trunk_template).format(vlans).replace("'","").replace(', ','\n')[1:-1])
else:
	print('Неправильный режим работы')