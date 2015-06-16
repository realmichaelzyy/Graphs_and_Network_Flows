###################################
#              1                  #
###################################
library(igraph)
#library(netrw)
mydata = as.matrix(read.table("/Users/Ke/Desktop/HWK3/sorted_directed_net.txt"))
a = mydata[,1]
b = mydata[,2]
c = mydata[,3]
g = graph.edgelist(t(rbind(a+1,b+1)),direct=TRUE)
E(g)$weight = c
is.connected(g)
#false
cl = clusters(g)
gccIndex = which.max(cl$csize)
nonGccNodes <- (1:vcount(g))[cl$membership != gccIndex]
gcc <- delete.vertices(g, nonGccNodes)

###################################
#              2                  #
###################################

inDegree = degree(gcc,mode="in")
getwd()
jpeg("hw3p2a.jpg",width=600,height=500)
h = hist(inDegree, breaks=seq(-0.5, by =1, length.out= max(inDegree)+2),freq=F)
dev.off()

outDegree = degree(gcc,mode="out")
getwd()
jpeg("hw3p2b.jpg",width=600,height=500)
h = hist(outDegree, breaks=seq(-0.5, by =1, length.out= max(outDegree)+2),freq=F)
dev.off()

###################################
#              3                  #
###################################

###################################
##          Option 1             ##
###################################
g1=as.undirected(gcc,mode="each")
is.simple(g1)
lp1=label.propagation.community(g1,weights=E(g1)$weight)

communitysize1=sizes(lp1)

mod1=lp1$modularity

getwd()
jpeg("hw3_option1_mod.jpg",width=600,height=500)
h1=hist(mod1)
dev.off()

getwd()
jpeg("hw3_option1_comsize.jpg",width=600,height=500)
h1=hist(communitysize1)
dev.off()
###################################
#            Option 2             #
###################################
g2=as.undirected(gcc,mode="collapse",edge.attr.comb=function(x) sqrt(prod(x)))
is.simple(g2)
lp2 = label.propagation.community(g2)

communitysize2=sizes(lp2)

mod2=lp2$modularity

getwd()
jpeg("hw3_option2_mod.jpg",width=600,height=500)
h2=hist(mod2)
dev.off()

getwd()
jpeg("hw3_option2_comsize.jpg",width=600,height=500)
h2=hist(communitysize2)
dev.off()

fg = fastgreedy.community(g2,weights=E(g2)$weight)

communitysize2_fg=sizes(fg)

mod2=fg$modularity

getwd()
jpeg("hw3_fg_mod.jpg",width=600,height=500)
h2=hist(mod2)
dev.off()

getwd()
jpeg("hw3_fg_comsize.jpg",width=600,height=500)
h2=hist(communitysize2_fg)
dev.off()

###################################
#              4                  #
###################################

maxInd = which.max(sizes(fg))
nonMaxNodes = (1:vcount(g2))[fg$membership!=maxInd]

maxSub = delete.vertices(g2,nonMaxNodes)

fgMax = fastgreedy.community(maxSub,weights=E(maxSub)$weight)

communitysize3 = sizes(fgMax)

mod3=fgMax$modularity

getwd()
jpeg("hw3_fgmax_mod.jpg",width=600,height=500)
h2=hist(mod3)
dev.off()

getwd()
jpeg("hw3_fgmax_comsize.jpg",width=600,height=500)
h2=hist(communitysize3)
dev.off()

###################################
#              5                  #
###################################

subComInd = which(sizes(fg)>100)
for(i in 1:length(subComInd))
{
  nonSubNodes = (1:vcount(g2))[fg$membership!=subComInd[i]]
  subCom = delete.vertices(g2,nonSubNodes)
  fgSub = fastgreedy.community(subCom)
  
  fgSubSize = sizes(fgSub)
  print(fgSubSize)
  
  fgSubMod = fgSub$modularity
  
  getwd()
  jpeg(paste0("hw3_fg_mod",i,".jpg"),width=600,height=500)
  h2=hist(fgSubMod)
  dev.off()
  
  getwd()
  jpeg(paste0("hw3_fg_csize",i,".jpg"),width=600,height=500)
  h2=hist(fgSubSize)
  dev.off()
}

###################################
#              6                  #
###################################
#reference:https://github.com/shivinkapur/232eGraphsProj/blob/master/hw3.R
library("netrw”)
library("hash")

rw <- netrw(graph=gcc, walker.num=length(V(gcc)), start.node=sample(1:(vcount(gcc))), damping=0.85, T=length(V(gcc)), output.walk.path=TRUE, output.visit.prob=TRUE) 

master_hash <- hash(V(gcc), rep(0,length(V(gcc))))
node_multi_comm <- c()

for(i in 1:length(V(gcc)))
{
  h <- hash(1:15, rep(0,15))
  
  c1 <- 1:length(V(gcc))
  c2 <- rw$visit.prob[,i]
  mat <- cbind(c1,c2)
  mat <- mat[order(mat[,2], decreasing=TRUE), ]
  for(j in 1:30)
  {
    m <- community_fast$membership[mat[j,][1]]
    v <- mat[j,][2]
    curr_value <- values(h, keys=m)
    curr_value <- curr_value + (m*v) 
    .set(h, keys=m, values=curr_value)
  }
  for (j in 1:15) 
  {
    val <- values(h, keys=j)
    if (val < 0.01)
    {
      .set(h, keys=j, values=0)
    }
  }
  .set(master_hash, keys=i,values=h)
  if(length(which(values(values(master_hash, keys = i)[[1]]) > 0)) > 1)
    node_multi_comm <- append(node_multi_comm,i)
}

length(node_multi_comm)
node_values = sample(node_multi_comm,5)
node_values

for (i in node_values) {
  print (values(master_hash, keys=i))
}