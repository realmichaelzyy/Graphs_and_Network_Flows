library(igraph)

num = 1000
iteration = 50
pc = numeric()

for (i in 1:iteration) {
	for (p in seq(from = 0, to = 0.01, by = 1e-04)) {
		g = random.graph.game(num, p, directed = FALSE)
		if (is.connected(g)) 
			break
	}
	pc = c(pc, p)
}

mean(pc)