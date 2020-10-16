# -*- coding: utf-8 -*-
"""
Задание 7.2a

Сделать копию скрипта задания 7.2.

Дополнить скрипт:
  Скрипт не должен выводить команды, в которых содержатся слова,
  которые указаны в списке ignore.

Ограничение: Все задания надо выполнять используя только пройденные темы.

"""

ignore = ["duplex", "alias", "Current configuration"]

with open("config_sw1.txt", 'r') as file:
	for line in file:
		if not line.startswith("!") :
			for word in line.split():
				if word in ignore:
					break
			else:
				print(line, end='')