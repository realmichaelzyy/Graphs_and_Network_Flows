library(igraph)
library(netrw)
nodeNum = 1000
walkNum = 1000
stepSize = 100
g <- random.graph.game(nodeNum, p = 0.01, direct = FALSE)
rw = netrw(g, walker.num = walkNum, damping = 1, T = stepSize, output.visit.prob = TRUE, output.nodes = (1:nodeNum))
deg = degree(g)
pb = rw$ave.visit.prob
relation = cor(deg, pb)
plot(pb, main = "Probability")