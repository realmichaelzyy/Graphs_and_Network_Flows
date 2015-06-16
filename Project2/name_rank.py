#!/usr/bin/python
import string
f=open("actSort.txt",'r')
g=open("processed_act.txt",'r')
q=open("name_rank.txt",'w')
dic={}
node=[]
rank=[]
for line in f.readlines():
	pos=0
	for i in line:
		if i==' ':
			break
		pos+=1
	a=int(line[1:pos-1])
	b=string.atof(line[pos+1:len(line)-1])
	node.append(a)
	rank.append(b)
count=0
for line in g.readlines():
	tokens=line.split('\t\t')
	if count in node:
		pos=0
		for i in node:
			if i==count:
				break
			pos+=1
		node[pos]=tokens[0]
	count+=1
	if count%5000==0:
		print(count)
for i in xrange(len(node)):
	line="%s\t%s\n"%(node[i],str(rank[i]))
	q.write(line)
q.close()
f.close()
g.close()