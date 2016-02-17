##############################
#      problem 1            #
##############################
library("igraph")
edgelistFile<-"/Users/Ke/Desktop/code/facebook_combined.txt"
g <- read.graph(edgelistFile, format = "ncol",directed = FALSE)

# determine whether the network is connected.
is.connected(g)
diameter(g, unconnected = FALSE)

# degree.distribution(g)
Deg <- degree(g)


getwd()
jpeg("problem1_degree.jpg",width=600,height=500)
h <- hist(Deg, breaks=seq(-0.5, by=1 , length.out=max(Deg)+2),freq=F,
          main='Degree Distribution', xlab='Degree',col="lightgreen")
dev.off()

# Curve Fitting
x <- h$mids[1:max(Deg)+1]
y <- h$density[1:max(Deg)+1]
y_fitting <- nls(y ~ I(exp(1)^(a+b*x)), start=list(a=0 , b=0))
summary(y_fitting)
# Draw Curve
pl <- data.frame(x=h$mids, y=h$density)
getwd()
jpeg("problem1_fit.jpg",width=600,height=500)
plot (pl,type = "o")
x_axis = seq (from = 1, to = max(Deg), by=1)
lines (x_axis, predict (y_fitting,list(x=x_axis)), col="red")
dev.off();

# Compute MSE
SD <- (sum(residuals(y_fitting)^2))/max(Deg)

# Compute average degree
degree_average <- mean(Deg)

##############################
#      problem 2            #
##############################

subGraphNode_1 <- neighborhood(g , 1 , 1)
length(subGraphNode_1)
subGraphNode_1 <- subGraphNode_1[[1]]
length(subGraphNode_1)
nonSubGraphNode_1 <- which( !( (1:vcount(g)) %in% subGraphNode_1)  )
subGraph_1 <- delete.vertices(g , nonSubGraphNode_1)

# caculate the vertex and the edge
edgesNum <- ecount(subGraph_1)
nodesNum <- vcount(subGraph_1)

##############################
#      problem 3            #
##############################

coreNodes <- which(neighborhood.size(g, 1 , nodes=V(g)) > 200)
length(coreNodes)

#degree(coreNodes)
core <- coreNodes[1]
subGraphNodes <- neighborhood(g , 1 , nodes=core)
length(subGraphNodes)
subGraphNodes <- subGraphNodes[[1]]
length(subGraphNodes)
nonSubGraphNodes <- which( !( (1:vcount(g)) %in% subGraphNodes)  )


# calculate the average degree
deg_avg <- mean(Deg[coreNodes])

#eliminate the differences
V(g)$number <- 1:vcount(g)
subGraph <- delete.vertices(g, nonSubGraphNodes)
subGraphNodes <- sort(subGraphNodes)

#### plotting personal network
vertexSizeVector = rep(2,vcount(subGraph))
vertexSizeVector[V(subGraph)$number==core] = 5

getwd()
jpeg("problem3_origin.jpg",width=600,height=500)
plot(subGraph , vertex.size=vertexSizeVector , vertex.label=NA , asp=9/16)
dev.off()

#Fast-Greedy
fg = fastgreedy.community(subGraph)
fgnum = max(fg$membership)
getwd()
jpeg("problem3_fg.jpg",width=600,height=500)
plot(subGraph , vertex.size=vertexSizeVector , vertex.label=NA , vertex.color=fg$membership,
     asp=9/16)
dev.off()

#Edge-Betweenness
eb <- edge.betweenness.community(subGraph)
jpeg("problem3_eb.jpg", width = 600, height = 500)
plot(subGraph , vertex.size=vertexSizeVector , vertex.label=NA , vertex.color=eb$membership,
     asp=9/16)
dev.off();

# Infomap
im <- infomap.community(subGraph)
imnum = max(im$membership)
jpeg("problem3_info.jpg", width = 600, height = 500)
plot(subGraph , vertex.size=vertexSizeVector , vertex.label=NA , vertex.color=im$membership,
     asp=9/16)
dev.off();

##############################
#      problem 4            #
##############################

subGraph_del <- delete.vertices(subGraph, V(subGraph)$number==core)

# find the community
vertexSizeVector = rep(3,vcount(subGraph_del))

#Fast-Greedy
fg <- fastgreedy.community(subGraph_del)
fgnum = max(fg$membership)
jpeg("4_color_fg.jpg", width = 600, height = 500)
plot(subGraph_del , vertex.size=vertexSizeVector , vertex.label=NA , vertex.color=fg$membership,
     asp=9/16)
dev.off();

#Edge-Betweenness
eb <- edge.betweenness.community(subGraph_del)
ebnum = max(eb$membership)
jpeg("4_color_eb.jpg", width = 600, height = 500)
plot(subGraph_del , vertex.size=vertexSizeVector , vertex.label=NA , vertex.color=eb$membership,
     asp=9/16)
dev.off();

# Infomap
im <- infomap.community(subGraph_del)
imnum = max(im$membership)
jpeg("4_color_info.jpg", width = 600, height = 500)
plot(subGraph_del , vertex.size=vertexSizeVector , vertex.label=NA , vertex.color=im$membership,
     asp=9/16)
dev.off();

##############################
#      problem 5            #
#Reference:https://github.com/shivinkapur/232eGraphsProj/blob/master/Project.R #
##############################

library("igraph")
edgelistFile<-"/Users/Ke/Desktop/code/facebook_combined.txt"
g <- read.graph(edgelistFile, format = "ncol",directed = FALSE)
core_nodes <- which(neighborhood.size(g, 1 , nodes=V(g)) > 200)
commNeib_find <- function(u,v,g)
{
  neighborsU <- neighborhood(g,1,u)[[1]][-1]
  neighborsV <- neighborhood(g,1,v)[[1]][-1]
  intersect(neighborsU, neighborsV)
}

embd_find <- function (u,v,g)
{
  embd = length(commNeib_find(u,v,g))
  embd
}

perNet_find <- function(u, g)
{
  pnNodes <- neighborhood(g , 1 , nodes=u)[[1]]
  nonPNNodes <- which( !( (1:vcount(g)) %in% pnNodes)  )
  perNetw <- delete.vertices(g , nonPNNodes)
  perNetw$name =  sort(pnNodes)
  perNetw
}


nodeID_find <- function(g, vertex)
{
  temp <- which(g$name == vertex)
  temp
}

disp_find <- function(u,v,g)
{
  disp <- 0
  commonUV <- commNeib_find(u, v, g)
  gNoUV <- delete.vertices(g, c(u, v))

  for(s in commonUV)
  {
    for(t in commonUV)
    {
      if(s != t && s!=u && s!=v && t!=u && t!=v)
      {
        short_d<-get.shortest.paths(gNoUV,from=s,to=t)
        if(length(short_d$vpath[[1]])>0){
          d<-length(short_d$vpath[[1]])-1
          disp <- disp + d}

      }
    }
  }
  disp=disp/2
}

dispEmb_find <- function(g,coreNode){

  dHigh = 0;
  dNode = 0;
  rHigh = 0;
  rNode = 0;
  eHigh = 0;
  eNode = 0;

  pnOfU <- perNet_find(coreNode,g)
  u <- nodeID_find(pnOfU, coreNode)

  nodes <- V(pnOfU)
  for(v in nodes){
    if(v == u)
      next

    dip = disp_find(u,v,g)
    embd = embd_find(u,v,g)

    if (embd > 0)
    {
      rt = dip/embd
      if (rt > rHigh)
      {
        rNode = v;
        rHigh=rt;
      }
    }

    if (dip > dHigh)
    {
      dNode = v;
      dHigh=dip;
    }
    if (embd > eHigh)
    {
      eNode = v
      eHigh=embd;
    }

  }

  if (dNode > 0)
  {
    # community detection
    fc = fastgreedy.community(pnOfU); sizes(fc)
    mfc = membership(fc)

    sizeVet = rep(3, length(V(pnOfU)));
    sizeVet[dNode] = 8;
    colEd = rep(8, length(E(pnOfU)));
    colEd[which(get.edgelist(pnOfU,name=F)[,1] == dNode | get.edgelist(pnOfU,name=F)[,2] == dNode)] = 3;
    E(pnOfU)$color = colEd;
    widEd = rep(1, length(E(pnOfU)));
    widEd[which(get.edgelist(pnOfU,name=F)[,1] == dNode | get.edgelist(pnOfU,name=F)[,2] == dNode)] = 3;
    dev.new ();
    jpeg("5_dNode_1.jpg", width = 600, height = 500)
    plot(pnOfU, vertex.label= NA, vertex.color=mfc,vertex.size=sizeVet, edge.width = widEd,mark.groups = by(seq_along(mfc), mfc, invisible),main="Maximum Dispersion");
    dev.off();
  }

  else
  {
    print (paste(c("No high Disp node", toString(coreNode)), collapse=" "));
  }


  if (eNode > 0)
  {
    # community detection
    fc = fastgreedy.community(pnOfU); sizes(fc)
    mfc = membership(fc)
    sizeVet = rep(3, length(V(pnOfU)));
    sizeVet[eNode] = 8;
    colEd = rep(8, length(E(pnOfU)));
    colEd[which(get.edgelist(pnOfU,name=F)[,1] == eNode | get.edgelist(pnOfU,name=F)[,2] == eNode)] = 3;
    E(pnOfU)$color = colEd;
    widEd = rep(1, length(E(pnOfU)));
    widEd[which(get.edgelist(pnOfU,name=F)[,1] == eNode | get.edgelist(pnOfU,name=F)[,2] == eNode)] = 3;
    dev.new ();
    jpeg("5_eNode_1.jpg", width = 600, height = 500)
    plot(pnOfU, vertex.label= NA, vertex.color=mfc,vertex.size=sizeVet, edge.width = widEd,mark.groups = by(seq_along(mfc), mfc, invisible),main="Maximum Embeddedness");# ,mark.groups = by(seq_along(mfc), mfc) );
    dev.off();
  }
  else
  {
    print (paste(c("No high Emb node", toString(coreNode)), collapse=" "));
  }


  if (rNode > 0)
  {

    fc = fastgreedy.community(pnOfU); sizes(fc)
    mfc = membership(fc)

    sizeVet = rep(3, length(V(pnOfU)));
    sizeVet[rNode] = 8;
    colEd = rep(8, length(E(pnOfU)));
    colEd[which(get.edgelist(pnOfU,name=F)[,1] == rNode | get.edgelist(pnOfU,name=F)[,2] == rNode)] = 3;
    E(pnOfU)$color = colEd;
    widEd = rep(1, length(E(pnOfU)));
    widEd[which(get.edgelist(pnOfU,name=F)[,1] == rNode | get.edgelist(pnOfU,name=F)[,2] == rNode)] = 3;
    dev.new ();
    jpeg("5_rNode_1.jpg", width = 600, height = 500)
    plot(pnOfU, vertex.label= NA, vertex.color=mfc,vertex.size=sizeVet, edge.width = widEd,mark.groups = by(seq_along(mfc), mfc, invisible) , main="Maximum dispersion/embeddedness");
    dev.off();
  }
  else
  {
    print (paste(c("No high Disp node", toString(coreNode)), collapse=" "));
  }

}

dispVec <- c();
embVec <- c();

for(coreNode in core_nodes)
{
  pnOfU <- perNet_find(coreNode,g)
  u <- nodeID_find(pnOfU, coreNode)

  nodes <- V(pnOfU)
  for(v in nodes){
    if(v == u)
      next

    embd = embd_find(u,v,g)
    dip = disp_find(u,v,g)
    embVec <- c(embVec, embd);
    dispVec <- c(dispVec, dip);

  }
}


hist (embVec, breaks=seq (-0.5, by=1, length.out=max(embVec) +2), main ="embd Distribution", xlab="embd");
hist (dispVec, breaks=seq (-0.5, by=1, length.out=max(dispVec) +2), main="dip Distribution", xlab="dip");

dispEmb_find(g,core_nodes[1])
#dispEmb_find(g,core_nodes[10])
#dispEmb_find(g,core_nodes[20])



##############################
#      problem 6            #
##############################

library("igraph")
edgelistFile<-"/Users/Ke/Desktop/code/facebook_combined.txt"
g <- read.graph(edgelistFile , format = "ncol" , directed=FALSE)
coreNodes <- which(neighborhood.size(g, 1 , nodes=V(g)) > 200)
for (core_i in 1:length(coreNodes))
{
  core <- coreNodes[core_i]
  subGraphNodes <- neighborhood(g , 1 , nodes=core)
  subGraphNodes <- subGraphNodes[[1]]
  nonSubGraphNodes <- which(!((1:vcount(g)) %in% subGraphNodes))
  subGraph <- delete.vertices(g , nonSubGraphNodes)
  fg <- fastgreedy.community(subGraph)
  community_vector=numeric(0)
  ratio_vector=numeric(0)
  for (i in 1:length(fg)) {
    communityNodes <- V(subGraph)$name[which(fg$membership==i)]
    non_communityNodes <- V(subGraph)$name[which(fg$membership!=i)]
    if (length(communityNodes) >= 10){
      communityGraph <- delete.vertices(subGraph, non_communityNodes)
      dgr_min <- min(degree(communityGraph))
      ratio <- dgr_min / length (communityGraph)
      ratio1<-ecount(communityGraph)/vcount(communityGraph)
      ratio_vector=c(ratio_vector,ratio1)
    }
  }
  community_acquintance_number=which.min(ratio_vector)
  community_close_friends_number=which.max(ratio_vector)
  non_acquintance_communityNodes <- V(subGraph)$name[which(fg$membership!=community_acquintance_number)]
  non_close_friends_communityNodes <- V(subGraph)$name[which(fg$membership!=community_close_friends_number)]
  community_acquintanceGraph <- delete.vertices(subGraph, non_acquintance_communityNodes )
  community_close_friendsGraph <- delete.vertices(subGraph, non_close_friends_communityNodes )
  jpeg(paste(6,'Core #',core_i,' Acquintance.jpg'), width = 800, height = 600)
  plot(community_acquintanceGraph,main=paste('Acquintance Community of Core #',core_i))
  dev.off()
  jpeg(paste(6,'Core #',core_i,' Close Friends.jpg'), width = 800, height = 600)
  plot(community_close_friendsGraph,main=paste('Close Friends Community of Core #',core_i))
  dev.off()
}

##############################
#      problem 7            #
##############################

library("igraph")
filesPath <- "/Users/Ke/Desktop/code/gplus/"

egoNodeId <- dir(filesPath,pattern = "circles")
egoNodeIdnew <- list()
circle_comsum<- list()
comsum_index <- 0

for (i in 1:length(egoNodeId)){
  egoNodeIdnew[[i]] <- strsplit(egoNodeId[i],".circles")
  edgelistFile <- paste(filesPath , egoNodeIdnew[[i]]  , ".edges" , sep="")
  circlesFile <- paste(filesPath , egoNodeIdnew[[i]] , ".circles" , sep="")
  fileConnection <- file(circlesFile , open="r")
  lines <- readLines(fileConnection)
  close(fileConnection)
  if(length(lines)>2){
    g2Raw <- read.graph(edgelistFile , format = "ncol" , directed=TRUE)
    circles <-list()
    for (k in 1:length(lines)) {
      sp <- strsplit(lines[k],"\t")
      circles[[k]] <- sp[[1]][-1]
    }
    circle_com<-list()
    comsum_index = comsum_index+1
    g2 <- add.vertices(g2Raw,1,name=egoNodeIdnew[[i]])
    edgeAppendList <- c()
    for (nodeIndex in 1:(vcount(g2)-1)) {
      edgeAppendList <- c(edgeAppendList , c(vcount(g2),nodeIndex))
    }
    circle_com[[1]] <- egoNodeIdnew[[i]]
    g2 <- add.edges(g2,edgeAppendList)
    imc <- infomap.community(g2)
    wtc <- walktrap.community(g2)
    wtc_mem <- membership(wtc)
    imc_mem <-  membership(imc)
    circle_com[[3]] <- which.max(sizes(imc))
    circle_com[[2]] <- which.max(sizes(wtc))
    circle_com[[4]]<-numeric(length(sizes(wtc)))
    for (m in 1:length(lines)) {
      circle_com[[5+m]] <- numeric(length(sizes(wtc)))
      for(k in 1:length(circles[[m]])){
        for(l in 1:length(wtc_mem)){
          if((attributes(wtc_mem[l])$name)==circles[[m]][k]){
            circle_com[[4]][wtc_mem[l]]<-  circle_com[[4]][wtc_mem[l]]+1
            circle_com[[5+m]][wtc_mem[l]] <- circle_com[[5+m]][wtc_mem[l]]+1
          }
        }
      }
    }
    circle_com[[5]]<-numeric(length(sizes(imc)))
    for (m in 1:length(lines)) {
      circle_com[[5+m+length(lines)]] <-  numeric(length(sizes(imc)))
      for(k in 1:length(circles[[m]])){
        for(l in 1:length(imc_mem)){
          if((attributes(imc_mem[l])$name)==circles[[m]][k]){
            circle_com[[5]][imc_mem[l]]<-  circle_com[[5]][imc_mem[l]]+1
            circle_com[[5+m+length(lines)]][imc_mem[l]] <- circle_com[[5+m+length(lines)]][imc_mem[l]]+1
          }

        }
      }

    }
    circle_comsum[[comsum_index]] <- circle_com
  }
  else next
}
