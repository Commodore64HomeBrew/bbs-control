import sys
import operator

date2 = int(sys.argv[1])
date1 = date2 - 6

with open("1.seq", mode='rb') as s1:
    sub1 = s1.read()

with open("2.seq", mode='rb') as s2:
    sub2 = s2.read()

with open("3.seq", mode='rb') as s3:
    sub3 = s3.read()

with open("4.seq", mode='rb') as s4:
    sub4 = s4.read()

with open("5.seq", mode='rb') as s5:
    sub5 = s5.read()

with open("6.seq", mode='rb') as s6:
    sub6 = s6.read()

with open("7.seq", mode='rb') as s7:
    sub7 = s7.read()

with open("8.seq", mode='rb') as s8:
    sub8 = s8.read()

path = "backups/"

fname1 = path + "no-" + str(date1) + ".seq"
fname2 = path + "no-" + str(date2) + ".seq"

with open(fname1) as f1:
    totals1 = f1.read().split("\n")

with open(fname2) as f2:
    totals2 = f2.read().split("\n")

totals1 = [int(i) for i in totals1[:-1]]
totals2 = [int(i) for i in totals2[:-1]]

diff = list(map(operator.sub, totals2, totals1))

totalPosts = sum(totals2)
newPosts = totalPosts - sum(totals1) 

totalCalls = 1000
newCalls = 0

#for date in range(date1, date2):
#    fname3 = path + "bbs-log-" + str(date) + ".seq"
#    file  = open(fname3, 'r',encoding='utf-8', errors='ignore').read()
#    newCalls += file.count("CAME AT")

#for date in range(date1, date2):
#    fname3 = path + "sys-log-" + str(date) + ".seq"
#    file  = open(fname3, 'r',encoding='utf-8', errors='ignore').read()
#    newCalls += file.count("OGON")

f = open('(val-user)', 'wb')

title="7 DAY REPORT (uPDATED 04:00 pst):\u000d\u000d"

stat1="tHE lOUNGE         -> nEW: {}\u000d\u000d".format(diff[0])
stat2="sCIENCE AND tECH   -> nEW: {}\u000d\u000d".format(diff[1])
stat3="lA mUSIQUE         -> nEW: {}\u000d\u000d".format(diff[2])
stat4="hARDWARE cORNER    -> nEW: {}\u000d\u000d".format(diff[3])
stat5="sOFTWARE AND gAMES -> nEW: {}\u000d\u000d".format(diff[4])
stat6="vIC64 nEWS/eVENTS  -> nEW: {}\u000d\u000d".format(diff[5])
stat7="tHE gREAT oUTDOORS -> nEW: {}\u000d\u000d".format(diff[6])
stat8="pACIFIC c= eXPO'17 -> nEW: {}\u000d\u000d".format(diff[7])


#f.write("uSERS -> tOTAL: {}  nEW: {}\u000d".format(totalUsers, newUsers))
#f.write("cALLS -> tOTAL: ??? nEW: {}\u000d".format(newCalls))
#f.write("pOSTS -> tOTAL: {} nEW: {}\u000d\u000d".format(totalPosts, newPosts))
#f.write("pOST RATIO (POSTS/CALLS): {0:.2f}\u000d\u000d".format( newPosts/newCalls ))




f.write(title.encode('ascii'))
f.write(sub1)
f.write(stat1.encode('ascii'))
f.write(sub2)
f.write(stat2.encode('ascii'))
f.write(sub3)
f.write(stat3.encode('ascii'))
f.write(sub4)
f.write(stat4.encode('ascii'))
f.write(sub5)
f.write(stat5.encode('ascii'))
f.write(sub6)
f.write(stat6.encode('ascii'))
f.write(sub7)
f.write(stat7.encode('ascii'))
f.write(sub8)
f.write(stat8.encode('ascii'))
