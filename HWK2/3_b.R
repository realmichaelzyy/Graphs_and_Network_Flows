library(igraph)
library(netrw)
nodeNum = 1000
walkNum = 1000
stepSize = 100
g <- random.graph.game(nodeNum, p = 0.01, direct = TRUE)
rw = netrw(g, walker.num = walkNum, damping = 1, T = stepSize, output.visit.prob = TRUE, output.nodes = (1:nodeNum))
pb = rw$ave.visit.prob
deg_total = degree(g)
deg_in = degree(g, mode = "in")
deg_out = degree(g, mode = "out")
relation_total = cor(deg_total, pb)
relation_in = cor(deg_in, pb)
relation_out = cor(deg_out, pb)
plot(pb, main = "Probability")