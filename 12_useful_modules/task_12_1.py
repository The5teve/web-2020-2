import os
#ip='ya.ru'
#result = subprocess.run(['ping','-c','2',ip],stdout=subprocess.DEVNULL)
#print(result.returncode)
# -*- coding: utf-8 -*-
"""
Задание 12.1

Создать функцию ping_ip_addresses, которая проверяет пингуются ли IP-адреса.

Функция ожидает как аргумент список IP-адресов.

Функция должна возвращать кортеж с двумя списками:
* список доступных IP-адресов
* список недоступных IP-адресов

Для проверки доступности IP-адреса, используйте команду ping.

Ограничение: Все задания надо выполнять используя только пройденные темы.
"""

def ping_ip_addresses(ip_list):
	ip_available=[]
	ip_not_available=[]
	for ip in ip_list:
		result = os.system('ping -n 1 '+ ip)
		if result==1:
			ip_available.append(ip)
		else:
			ip_not_available.append(ip)
	return ip_available, ip_not_available

if __name__ == '__main__':
	test = [
	'192.168.0.1',
	'google.com',
	'ya.ru',
	'notexist11.rt',
	'vk.com',
	'ubuntu.com',
	]
	print(ping_ip_addresses(test))