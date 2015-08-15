#!/usr/bin/python
f = open("ten_person_movie.txt", 'r')
q = open("ten_person_movieNum.txt", 'w')
for line in f.readlines():
    tokens = line.split('\t\t')
    count = len(tokens) - 1
    q.write(str(count) + '\n')
q.close()
f.close()
