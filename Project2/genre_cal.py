#!/usr/bin/python
f = open("movie_genre.txt", 'r')
q = open("genre_cal.txt", 'w')
dic = {}
for line in f.readlines():
    token = line.split('\t\t')
    if token[1] in dic:
        dic[token[1]] += 1
    else:
        dic[token[1]] = 1
for i in dic:
    sum += dic[i]
    line = "%s %d\n" % (i, dic[i])
    q.write(line)
q.close()
f.close()
