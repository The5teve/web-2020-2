# -*- coding: utf-8 -*-
"""
Задание 7.3b

Сделать копию скрипта задания 7.3a.

Переделать скрипт:
- Запросить у пользователя ввод номера VLAN.
- Выводить информацию только по указанному VLAN.

Ограничение: Все задания надо выполнять используя только пройденные темы.

"""

mydict= dict()
m=0
with open("CAM_table.txt", 'r') as file:

	for line in file:
		if line.find('.')>=1:
			m+=1
			mydict[m] = int(line.split()[0]), line.split()[1],  line.split()[3]
vlan=input('Введите номер vlan: ')

for m in sorted(mydict.values()):
	if m[0]==int(vlan):
		print('{:<8} {:<18} {:<10}'.format(m[0],m[1],m[2]))

