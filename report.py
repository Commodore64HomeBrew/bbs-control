import sys
import operator
import time


up=b'\x91'
dn=b'\x11'
lt=b'\x9d'
rt=b'\x1d'
cr=b'\x0d'
pt=b'\xbb'

xaxis=34
yaxis=8

dayColour=b"\x1f\x9a\x9f\x99\x9e\x81\x1c"

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

for date in range(date1, date2):
    fname3 = path + "bbs-log-" + str(date) + ".seq"
    file  = open(fname3, 'r',encoding='utf-8', errors='ignore').read()
    newCalls += file.count("OGON")

f = open('(val-user)', 'wb')

title=b"\x05 7 DAY REPORT (UPDATED 06:00 pst):\x0d\x0d"

#total=b"\x97  ALL POSTS: \x05 %d\x0d\x0d" % totalPosts

#posts=b"\x9b  NEW POSTS: \x05 %d\x0d" % newPosts
#calls=b"\x98  NEW CALLS: \x05 %d\x0d" % newCalls
#ratio=b"\x97 POST RATIO: \x05 %.2f\x0d\x0d" % (newPosts/newCalls)

postsline=b"\x9b NEW POSTS: \x05 %d\x97  ALL POSTS: \x05 %d\x0d" % (newPosts, totalPosts)
callsline=b"\x9b NEW CALLS: \x05 %d\x97 POST RATIO: \x05 %.2f\x0d\x0d" % (newCalls, (newPosts/newCalls))

stat1=b"\x1f tHE lOUNGE \x1e[\x05\x12"+ (b"\xa5" * diff[0]) +b"\x0d"
stat2=b"\x9a sCI & tECH \x1e[\x9b\x12"+ (b"\xa5" * diff[1]) +b"\x0d"
stat3=b"\x9f lA mUSIQUE \x1e[\x05\x12"+ (b"\xa5" * diff[2]) +b"\x0d"
stat4=b"\x99   hARDWARE \x1e[\x9b\x12"+ (b"\xa5" * diff[3]) +b"\x0d"
stat5=b"\x9e   sOFTWARE \x1e[\x05\x12"+ (b"\xa5" * diff[4]) +b"\x0d"
stat6=b"\x81 vIC64 nEWS \x1e[\x9b\x12"+ (b"\xa5" * diff[5]) +b"\x0d"
stat7=b"\x1c   oUTDOORS \x1e[\x05\x12"+ (b"\xa5" * diff[6]) +b"\x0d"
stat8=b"\x95     iNTROS \x1e[\x9b\x12"+ (b"\xa5" * diff[7]) +b"\x0d"

pause=b"\x90"
pause+= (lt+rt)*40

f.write(title)

#f.write(total)
#f.write(posts)
#f.write(calls)
#f.write(ratio)

f.write(postsline)
f.write(callsline)

f.write(stat1)
f.write(stat2)
f.write(stat3)
f.write(stat4)
f.write(stat5)
f.write(stat6)
f.write(stat7)
f.write(stat8)
#f.write(pause)

date1 = date2 - 30
dailyCalls = []
lastPoint=0
callsLine=b'\x1c'
maxCalls=0

for date in range(date1, date2):
    fname3 = path + "bbs-log-" + str(date) + ".seq"
    file  = open(fname3, 'r',encoding='utf-8', errors='ignore').read()
    calls=file.count("OGON")
    dailyCalls.append(calls)
    pointDiff = calls-lastPoint

    if pointDiff>0:
        callsPoint = up*abs(pointDiff) + pt
    elif pointDiff<0:
        callsPoint = dn*abs(pointDiff) + pt
    else:
        callsPoint = pt

    callsLine += callsPoint
    lastPoint=calls

    if(calls > maxCalls):
        maxCalls=calls

postsLine=b"\x12"
xlable=b"  "
maxPosts=0
lastPoint=0
date1=date2-xaxis
dayCount=0

for date in range(date1, date2):

    fname1 = path + "no-" + str(date-1) + ".seq"
    fname2 = path + "no-" + str(date) + ".seq"

    day=time.strftime("%A", time.gmtime(date*86400))[:1].lower()

    with open(fname1) as f1:
        totals1 = f1.read().split("\n")

    with open(fname2) as f2:
        totals2 = f2.read().split("\n")

    totals1 = [int(i) for i in totals1[:-1]]
    totals2 = [int(i) for i in totals2[:-1]]

    diff = list(map(operator.sub, totals2, totals1))

    totalPosts = sum(totals2)
    newPosts = totalPosts - sum(totals1) 

    postsPoint= bytes({dayColour[dayCount]}) + b"\x91\x9d\xb4"*newPosts + b"\x90" + dn*newPosts + rt

    xlable += bytes({dayColour[dayCount]}) + day.encode()

    dayCount=dayCount+1
    if(dayCount>6):
        dayCount=0

    postsLine += postsPoint
    lastPoint=newPosts

    if(newPosts > maxPosts):
        maxPosts=newPosts

endPos= dn*2 + cr

title=b"\x0d\x9b            pOSTS PER DAY\x0d"

axis=b"\x0d\x05"
for x in range(0, yaxis):
    index=yaxis-x
    axis += b"%d\xab\x0d" % index

 
axis += b" \xad" + b"\xb1"*xaxis + cr
#+ b"\x9d\x91\x7d"*10


startPos=cr + up*2 + rt*3

f.write(title)
f.write(axis)
f.write(xlable)
f.write(startPos)
#f.write(callsLine)
f.write(postsLine)
f.write(pause)
