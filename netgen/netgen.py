#!/usr/bin/python

#  'Hey {name}, there is a 0x{errno:x} error!'.format(name=name, errno=errno)

ips = "win-ips.txt"
NETDIR="/etc/systemd/network"
TEMPLATEF="20-wired.network.template"
TEMPLATE=open(TEMPLATEF).read()
OFILE=NETDIR+"/20-wired-{mac}-{num}.network"
i=open(ips)
SPLIT="#------- SPLIT -------\n"
hosts = open('/etc/hosts').read().split(SPLIT)[0]+SPLIT
ho=open('/etc/hosts',"w")
ho.write(hosts)
ho.flush()
print(hosts)

def wr(fn, s):
    f=open(fn,"w")
    f.write(s)
    f.close()

# print(TEMPLATE)

PREF4="172.27.24.{num}"
REF6='470:72db:3000:172:27:24:{num}'

for l in i:
    l=l.strip()
    mac,rest=l.split(' ')
    mac=mac.upper()
    _,num=rest.split('172.27.24.')
    # print (mac,num)
    num=int(num)
    conf = TEMPLATE.format(mac=mac,num=num)
    o = open(OFILE.format(num=num,mac=mac),"w")
    o.write(conf)
    o.close()
    hostname="pc{num}-v208.isclan.ru".format(num=num,mac=mac)
    wr('/etc/hostname', hostname+"\n")
    ho.write(PREF4.format(num=num)+' '+hostname+' pc'+str(num)+' pc'+str(num)+'-v208'+'\n')
    ho.write('fda7:'+REF6.format(num=num)+' '+hostname+' pc'+str(num)+' pc'+str(num)+'-v208'+'\n')
    ho.write('2001:'+REF6.format(num=num)+' pc'+str(num)+'.iscnet.ru pc'+str(num)+'-v208-6'+' pc'+str(num)+'-6\n')

ho.close()
i.close()
