#!/usr/bin/python
f = open("movie_genre.txt", 'r')
g = open("comm7.txt", 'r')
q = open("comm7_genre.txt", 'w')
node = []
dic = {}
for i in g.readlines():
    node.append(int(i))
count = 0
for line in f.readlines():
    token = line.split('\t\t')
    if count in node:
        if token[1] in dic:
            dic[token[1]] += 1
        else:
            dic[token[1]] = 1
    count += 1
q.write("the total movie number of community 7 is %d.\n\n" % (len(node)))
for i in dic:
    line = "%s%d\n" % (i, dic[i])
    q.write(line)
    if dic[i] > 0.2 * len(node):
        q.write("This is the TAG.\n\n")
g.close()
q.close()
f.close()
