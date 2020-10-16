# -*- coding: utf-8 -*-
"""
Задание 5.2b

Преобразовать скрипт из задания 5.2a таким образом,
чтобы сеть/маска не запрашивались у пользователя,
а передавались как аргумент скрипту.

Ограничение: Все задания надо выполнять используя только пройденные темы.

"""

ip = '10.1.1.0/24'
ipaddress = '''
Network:
{:<9} {:<9} {:<9} {:<9}
{:<9} {:<9} {:<9} {:<9}

Mask:
{:<9}
{:<9} {:<9} {:<9} {:<9}
{:<9} {:<9} {:<9} {:<9}
'''

if ip.find('/') and ip.count('.')==3:
	ipaddr=ip.split('/')[0]
	ipmask=int(ip.split('/')[1])
	obip='{:08b}{:08b}{:08b}{:08b}'.format(int(ipaddr.split('.')[0]),int(ipaddr.split('.')[1]),int(ipaddr.split('.')[2]),int(ipaddr.split('.')[3]))[0:int(ipmask)]+'0'*(32-int(ipmask))
	obmask='1'*ipmask+'0'*(32-int(ipmask))
	print(ipaddress.format(int(obip[0:8],2),int(obip[8:16],2),int(obip[16:24],2),int(obip[24:32],2),obip[0:8],obip[8:16],obip[16:24],obip[24:32],'/'+str(ipmask),int(obmask[0:8],2),int(obmask[8:16],2),int(obmask[16:24],2),int(obmask[24:32],2),obmask[0:8],obmask[8:16],obmask[16:24],obmask[24:32]))
else:
	print('Неверный формат')