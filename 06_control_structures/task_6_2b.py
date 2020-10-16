# -*- coding: utf-8 -*-
"""
Задание 6.2b

Сделать копию скрипта задания 6.2a.

Дополнить скрипт:
Если адрес был введен неправильно, запросить адрес снова.

Ограничение: Все задания надо выполнять используя только пройденные темы.
"""

while True:
	ip = input('\nВведите IP-адрес: ')
	if ip.count('.')==3 and len(ip.split('.'))==4 and-1<int(ip.split('.')[0])<256 and -1<int(ip.split('.')[1])<256 and -1<int(ip.split('.')[2])<256 and -1<int(ip.split('.')[3])<256:
		if 1<int(ip.split('.')[0])<223:
			print("unicast")
		elif 224<int(ip.split('.')[0])<239:
			print("multicast")
		elif '255.255.255.255'==ip:
			print("local broadcast")
		elif '0.0.0.0'==ip:
			print("unassigned")
		else:
			print("unused")
		break
	else:
		print('Неверный формат адреса.')