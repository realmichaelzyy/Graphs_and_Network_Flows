##############################
#      problem 3            #
##############################
library("igraph")
edgelistFile<-read.table("/Users/Ke/Desktop/Eclipse/232/graph_act.txt")
g=graph.data.frame(edgelistFile, directed=T)
pg=page.rank(g)
ans=pg[[1]]
write.table(ans, file='page_rank.txt', col.names=FALSE) 