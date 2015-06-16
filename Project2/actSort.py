#!/usr/bin/python
import string
f=open("page_rank.txt",'r')
q=open("actSort.txt",'w')
dic={}
s=[]
for line in f.readlines():
	pos=0
	for i in line:
		if i==' ':
			break
		pos+=1
	a=line[0:pos]
	b=string.atof(line[pos+1:len(line)])
	if b not in s:
		dic[b]=[a]
	else:
		dic[b].append(a)
	s.append(b)	
	
# Refer to the Internet
def qsort(L):  
     if len(L) <= 1: return L  
     return qsort([lt for lt in L[1:] if lt < L[0]]) + L[0:1] + qsort([ge for ge in L[1:] if ge >= L[0]])
ss=qsort(s)[::-1]
ans=[]
for i in ss:
	for j in dic[i]:
		line="%s %s\n" %(j,str(i))
		if line not in ans:
				ans.append(line)	
for k in ans:
	q.write(k)
q.close()
f.close()