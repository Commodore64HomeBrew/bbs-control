import sys
import operator

date2 = int(sys.argv[1])
date1 = date2 - 6

#with open("1.seq") as s1:
#    sub1 = s1.read()

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

f = open('(val-user)', 'w')

f.write("7 DAY REPORT (uPDATED 04:00 pst):\u000d\u000d")

#f.write("uSERS -> tOTAL: {}  nEW: {}\u000d".format(totalUsers, newUsers))
#f.write("cALLS -> tOTAL: ??? nEW: {}\u000d".format(newCalls))
f.write("pOSTS -> tOTAL: {} nEW: {}\u000d\u000d".format(totalPosts, newPosts))
#f.write("pOST RATIO (POSTS/CALLS): {0:.2f}\u000d\u000d".format( newPosts/newCalls ))

#f.write("{}".format(sub1))
f.write("tHE lOUNGE         -> nEW: {}\u000d".format(diff[0]))
f.write("sCIENCE AND tECH   -> nEW: {}\u000d".format(diff[1]))
f.write("lA mUSIQUE         -> nEW: {}\u000d".format(diff[2]))
f.write("hARDWARE cORNER    -> nEW: {}\u000d".format(diff[3]))
f.write("sOFTWARE AND gAMES -> nEW: {}\u000d".format(diff[4]))
f.write("vIC64 nEWS/eVENTS  -> nEW: {}\u000d".format(diff[5]))
f.write("tHE gREAT oUTDOORS -> nEW: {}\u000d".format(diff[6]))
f.write("pACIFIC c= eXPO'17 -> nEW: {}\u000d".format(diff[7]))
