#!/usr/bin/python
#Batman v Superman: Dawn of Justice (2016)		Sci-Fi
#nodeID:894353
#Mission: Impossible - Rogue Nation (2015)		Thriller
#nodeID:779750
#Minions (2015)		Family
#nodeID:763762
import string
f=open("graph_movie.txt",'r')
q=open("node3_sel.txt",'w')
nodeId='763762'
for line in f.readlines():
	tokens=	line.split('\t')
	if tokens[0]==nodeId or tokens[1]==nodeId:
		q.write(line)
q.close()
f.close()
