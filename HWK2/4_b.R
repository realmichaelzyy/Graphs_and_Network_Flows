library(igraph)
library(netrw)
nodeNum = 1000
walkNum = 1000
stepSize = 100
g <- random.graph.game(nodeNum, p = 0.01, direct = FALSE)
rw = netrw(g, walker.num = walkNum, damping = 0.85, T = stepSize, output.visit.prob = TRUE, output.nodes = (1:nodeNum))
pagerank = rw$ave.visit.prob
rw_ = netrw(g, walker.num = walkNum, damping = 0.85, T = stepSize, output.visit.prob = TRUE, output.nodes = (1:nodeNum), 
	teleport.prob = pagerank)
pk = rw_$ave.visit.prob
relation = cor(pagerank, pk)
plot(pk, main = "PageRank")