##############################
#      problem 5            #
##############################
library("igraph")
edgelistFile<-read.table("/Users/Ke/Desktop/Eclipse/232/graph_movie.txt")
g<-graph.data.frame(edgelistFile, directed = F)
ans=fastgreedy.community(g, merges=TRUE, modularity = TRUE,membership = TRUE, weights=E(g)$weight)
write.table(membership(ans),file='mem.txt',col.names=FALSE)
