# -*- coding: utf-8 -*-
"""
Задание 7.2c

Переделать скрипт из задания 7.2b:
* передавать как аргументы скрипту:
 * имя исходного файла конфигурации
 * имя итогового файла конфигурации

Внутри, скрипт должен отфильтровать те строки, в исходном файле конфигурации,
в которых содержатся слова из списка ignore.
И записать остальные строки в итоговый файл.

Проверить работу скрипта на примере файла config_sw1.txt.

Ограничение: Все задания надо выполнять используя только пройденные темы.
"""
from sys import argv
ignore = ["duplex", "alias", "Current configuration"]

original=argv[1]
filtred=argv[2]

with open(filtred, 'w') as file:
	file.write("")

with open(original, 'r') as file, open(filtred, 'a') as file1:
	for line in file:
		for word in line.split():
			if word in ignore:
				break
			file1.write(line)