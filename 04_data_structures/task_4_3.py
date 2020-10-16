# -*- coding: utf-8 -*-
"""
Задание 4.3

Получить из строки config такой список VLANов:
['1', '3', '10', '20', '30', '100']

Ограничение: Все задания надо выполнять используя только пройденные темы.

"""

result=[]
flag = 0
config = "switchport trunk allowed vlan 1,3,10,20,30,100"
for i in range(0,len(config)):
	buff=''
	if flag >0:
		flag-=1
		continue
	flag = 0
	if config[i].isdigit():
		print(config[i])
		buff=int(config[i])
		for b in range(i+1,len(config)):
			if config[b].isdigit():
				buff=buff*10+int(config[b])
				flag+=1
			else:
				break
	if buff !='':
		result.append(buff)
print(result)