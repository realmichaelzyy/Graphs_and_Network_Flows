library("igraph")
target<-c("Batman v Superman: Dawn of Justice (2016)",
                  "Mission: Impossible - Rogue Nation (2015)",
                  "Minions (2015)")
filename="/Users/Ke/Desktop/Eclipse/232/fastgreedy/mem_name.txt"
f=file(filename,open='r')
name_list=readLines(f)
close(f)
V(g)$movieName<-name_list
nb<-list()
community_id<-rep(0,3)
for(i in 1:3){
  nodeID<-(1:vcount(g))[V(g)$movieName==target[i]]
  temp<-neighborhood(g,1,V(g)[nodeID])
  nb[[i]]<-temp[[1]][2:length(temp[[1]])]
  print(target[i])
  community_id[i]<-ans$membership[nodeID]
  print("It belongs to the community")
  print(community_id[i])
}
write.table(nb[[1]],file='nb1.txt',row.names=FALSE,col.names=FALSE)