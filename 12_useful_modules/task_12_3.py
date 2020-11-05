# -*- coding: utf-8 -*-
"""
Задание 12.3


Создать функцию print_ip_table, которая отображает таблицу доступных и недоступных IP-адресов.

Функция ожидает как аргументы два списка:
* список доступных IP-адресов
* список недоступных IP-адресов

Результат работы функции - вывод на стандартный поток вывода таблицы вида:

Reachable    Unreachable
-----------  -------------
10.1.1.1     10.1.1.7
10.1.1.2     10.1.1.8
             10.1.1.9

Функция не должна изменять списки, которые переданы ей как аргументы.
То есть, до выполнения функции и после списки должны выглядеть одинаково.


Для этого задания нет тестов
"""
def print_ip_table(r_iplist,ur_iplist):
	aka_table="{:<16} {:<16}"
	print(aka_table.format('Reachable','Unreachable'))
	print(aka_table.format('-'*10,'-'*15))
	for i in range(0,len(r_iplist)+len(ur_iplist)):
		try:
			print(aka_table.format(r_iplist[i],ur_iplist[i]))
		except IndexError:
			if i>len(r_iplist)-1:
				try:
					print(aka_table.format('',ur_iplist[i]))
				except IndexError:
					pass 
			elif i>len(ur_iplist)-1:
				try:
					print(aka_table.format(r_iplist[i],''))
				except IndexError:
					pass 

#		print("{:<15}  {:<15}".format('Reachable','Unreachable')) if i==0 else print("{:<15}  {:<15}".format(r_iplist[i],ur_iplist[i]))
#		print("{:<15}  {:<15}".format('-'*10,'-'*15)) if i==1 else print("{:<15}  {:<15}".format(r_iplist[i],ur_iplist[i]))

sd=['10.10.10.2','30.10.20.10','255.155.155.155','12.13.23.44']
sd1=['11.0.0.1','20.20.30.40']
print_ip_table(sd,sd1)