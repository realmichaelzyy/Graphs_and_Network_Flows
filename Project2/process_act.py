#!/usr/bin/python

f = open('combine_act.txt', 'r')
g = open('processed_act.txt', 'w')
num = 0
for line in f.readlines():
    if(line.count('\t\t') >= 15):
        g.write(str(line))
        num += 1

f.close()
g.close()
