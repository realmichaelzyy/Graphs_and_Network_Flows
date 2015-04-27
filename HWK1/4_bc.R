library(igraph)

iteration = 10
num = 1000
d = numeric()
count = numeric()
deg1 = numeric()
deg2 = numeric()

for (i in 1:iteration) {
	g = forest.fire.game(num, fw.prob = 0.37, bw.factor = 0.32/0.37, directed = TRUE)
	d = c(d, diameter(g))
	clu = clusters(g)
	gcc_index = which.max(clu$csize)
	gcc_none = (1:vcount(g))[clu$membership != gcc_index]
	gcc = delete.vertices(g, gcc_none)
	ans = spinglass.community(gcc)
	count = c(count, modularity(ans))
}
plot(ans, g)
mean(d)
mean(count)
ans