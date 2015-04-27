library(igraph)

num = 1000
g = aging.prefatt.game(num, pa.exp = 1, aging.exp = -1, aging.bin = 100, directed = FALSE)
deg = degree(g)
h = hist(deg, breaks = seq(0, to = max(deg) + 1, by = 1), freq = FALSE, main = "Histogram of degree distribution with 1000 nodes", 
	xlab = "Degree")
p = data.frame(x = h$mids, y = h$density)
plot(p, type = "o", main = "Degree Distribution with 1000 nodes", xlab = "Degree", ylab = "Density")

clu = clusters(g)
gcc_index = which.max(clu$csize)
gcc_none = (1:vcount(g))[clu$membership != gcc_index]
gcc <- delete.vertices(g, gcc_none)
ans <- fastgreedy.community(gcc)
plot(ans, g)
ans