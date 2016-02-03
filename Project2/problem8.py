#!/usr/bin/python

import string
f = open("name_rank.txt", 'r')
g = open("director_100.txt", 'r')
h = open("movie_actor.txt", 'r')
w = open("rating_num.txt", 'r')
q = open("prob8.txt", 'w')

dic_rank = {}
for line in f.readlines():
    tokens = line.split('\t')
    dic_rank[tokens[0]] = string.atof(tokens[1])

dic_topDirMovie = []
for line in g.readlines():
    tokens = line.split('\t\t')
    for i in xrange(1, len(tokens)):
        if i == (len(tokens) - 1):
            temp = tokens[i]
            dic_topDirMovie.append(temp[0:len(temp) - 1])
        else:
            dic_topDirMovie.append(tokens[i])

dic_rating = {}
for line in w.readlines():
    pos = 0
    for i in line:
        if i == ' ':
            break
        pos += 1
    a = int(line[0:pos])
    b = float(line[pos + 1:])
    dic_rating[a] = b


def qsort(L):
    if len(L) <= 1:
        return L
    return qsort([lt for lt in L[1:] if lt < L[0]]) + L[0:1] + qsort([ge for ge in L[1:] if ge >= L[0]])

count = 0
tag_dir = []
tag_actRank1 = []
tag_actRank2 = []
tag_actRank3 = []
tag_actRank4 = []
tag_actRank5 = []
tag_rating = []
for line in h.readlines():
    tokens = line.split('\t')
    node = int(tokens[1])
    if node in dic_rating:
        if tokens[0] in dic_topDirMovie:
            tag_dir.append(1)
        else:
            tag_dir.append(-1)
        tag_rating.append(dic_rating[node])
        s = []
        avg = 0
        for i in xrange(2, len(tokens)):
            temp = tokens[i]
            if i == len(tokens) - 1:
                temp = temp[0:len(temp) - 1]
            if temp in dic_rank:
                s.append(dic_rank[temp])
        ss = qsort(s)[::-1]
        # if len(ss)>=5:
        # avg=sum(ss[0:5])//5
        # else:
        # avg=sum(ss)//len(ss)
        # tag_actRank.append(avg)
        tag_actRank1.append(ss[0])
        tag_actRank2.append(ss[1])
        tag_actRank3.append(ss[2])
        tag_actRank4.append(ss[3])
        tag_actRank5.append(ss[4])
        count += 1
    if count == 10000:
        break

for i in xrange(len(tag_rating)):
    # line="%.1f %d %d\n"%(tag_rating[i],tag_actRank1[i],tag_dir[i])
    line = "%.1f %.10f %.10f %.10f %.10f %.10f %d\n" %
    (tag_rating[i], tag_actRank1[i], tag_actRank2[i],
     tag_actRank3[i], tag_actRank4[i], tag_actRank5[i], tag_dir[i])
    q.write(line)

f.close()
g.close()
q.close()
w.close()
h.close()
