# -*- coding: utf-8 -*-
"""
Задание 4.5

Из строк command1 и command2 получить список VLANов,
которые есть и в команде command1 и в команде command2 (пересечение).

Результатом должен быть такой список: ['1', '3', '8']

Ограничение: Все задания надо выполнять используя только пройденные темы.

"""
def correct(srt):
	result=[]
	flag = 0
	for i in range(0,len(srt)):
		buff=''
		if flag >0:
			flag-=1
			continue
		flag = 0
		if srt[i].isdigit():
			print(srt[i])
			buff=int(srt[i])
			for b in range(i+1,len(srt)):
				if srt[b].isdigit():
					buff=buff*10+int(srt[b])
					flag+=1
				else:
					break
		if buff !='':
			result.append(buff)
	return result
res = []
command1 = "switchport trunk allowed vlan 1,2,3,5,8"
command2 = "switchport trunk allowed vlan 1,3,8,9"
for i in correct(command1):
	if i in correct(command2):
		res.append(i)
print(res)