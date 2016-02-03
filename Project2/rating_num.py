#!/usr/bin/python

import string
f = open("movie_genre.txt", 'r')
g = open("movie_rating.txt", 'r')
q = open("rating_num.txt", 'w')
dic = {}
count = 0
for line in f.readlines():
    tokens = line.split('\t\t')
    dic[tokens[0]] = count
    count += 1
for line in g.readlines():
    tokens = line.split('\t\t')
    if tokens[0] in dic:
        a = dic[tokens[0]]
        temp = tokens[1]
        b = string.atof(temp[0:len(temp) - 2])
        ans = "%d %.1f\n" % (a, b)
        q.write(ans)
q.close()
g.close()
f.close()
