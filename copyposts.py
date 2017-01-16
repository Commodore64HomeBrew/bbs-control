import os
import operator

date2 = 17057
date1 = date2 - 1

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

#for num in range(376, totals2[0]):
for num in range(376, 377):
    os.system('cbmcopy -t original -d 1541 -r 8 "(\u2190 1 ' + str(num) + '" -o "' + str(num) + '.seq"' )

