#!/usr/bin/python
import string
f = open("rating_num.txt", 'r')
g = open("node3_sort.txt", 'r')
dic = {}
for line in f.readlines():
    pos = 0
    for i in line:
        if i == ' ':
            break
        pos += 1
    a = line[0:pos]
    b = line[pos + 1:len(line) - 1]
    b = string.atof(b)
    dic[a] = b
count = 0
total = 0
for line in g.readlines():
    pos = 0
    for i in line:
        if i == ' ':
            break
        pos += 1
    a = line[0:pos]
    if a in dic:
        total += dic[a]
        count += 1
ans = total / count
line = "The approximate rating of node3 is %.3f by using its %d neighbors.\n" % (
    ans, count)
print(line)
g.close()
f.close()
