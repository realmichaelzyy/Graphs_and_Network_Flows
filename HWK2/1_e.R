library(igraph)
library(netrw)
degrees = numeric()
walkNum = 1000
stepSize = 100
g <- random.graph.game(1000, p = 0.01, direct = FALSE)
deg = degree(g)
for (i in 1:100) {
	rw <- netrw(g, walker.num = walkNum, damping = 1, T = stepSize, output.walk.path = TRUE)
	paths = rw$walk.path
	for (j in 1:walkNum) {
		deg = c(deg, deg[paths[stepSize, j]])
	}
}

h = hist(deg, breaks = seq(-0.5, by = 1, length.out = max(deg) + 2), freq = F, main = "Histogram of degree distribution")