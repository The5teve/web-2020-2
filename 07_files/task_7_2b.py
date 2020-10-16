# -*- coding: utf-8 -*-
"""
Задание 7.2b

Дополнить скрипт из задания 7.2a:
* вместо вывода на стандартный поток вывода,
  скрипт должен записать полученные строки в файл config_sw1_cleared.txt

При этом, должны быть отфильтрованы строки, которые содержатся в списке ignore.
Строки, которые начинаются на '!' отфильтровывать не нужно.

Ограничение: Все задания надо выполнять используя только пройденные темы.

"""

ignore = ["duplex", "alias", "Current configuration"]

with open("config_sw1_cleared.txt", 'w') as file:
	file.write("")

with open("config_sw1.txt", 'r') as file, open('config_sw1_cleared.txt', 'a') as file1:
	for line in file:
		for word in line.split():
			if word in ignore:
				break
		else:
			file1.write(line)