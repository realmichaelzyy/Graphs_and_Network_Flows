#!/usr/bin/python
import string
#Batman v Superman: Dawn of Justice (2016)      Sci-Fi
#nodeID:894353
#Mission: Impossible - Rogue Nation (2015)      Thriller
#nodeID:779750
#Minions (2015)     Family
#nodeID:763762
f=open("node3_sel.txt",'r')
q=open("node3_sort.txt",'w')
s=[]
dic={}
nodeId='763762'
for line in f.readlines():
    tokens=line.split('\t')
    ne=tokens[1] if tokens[0]==nodeId else tokens[0]
    l=len(tokens[2])-1
    num=string.atof(tokens[2][0:l])
    if num not in s:
        dic[num]=[ne]
    else:
        if ne in dic[num]:
            pass
        else:
            dic[num].append(ne)
    s.append(num)
def qsort(L):  
     if len(L) <= 1: return L  
     return qsort([lt for lt in L[1:] if lt < L[0]]) + L[0:1] + qsort([ge for ge in L[1:] if ge >= L[0]])
ss=qsort(s)[::-1]
ans=[]
for i in ss:
    for j in dic[i]:
        line="%s %s" %(j,str(i))
        if line not in ans:
            ans.append(line)
for k in ans:
    q.write(k+'\n')  
q.close()
f.close()
