library(igraph)

num = 1000
iteration = 50

p1 = 0.01
d1 = numeric()
count1 = numeric()
p2 = 0.05
d2 = numeric()
count2 = numeric()
p3 = 0.1
d3 = numeric()
count3 = numeric()

for (i in 1:iteration) {
	g1 = random.graph.game(num, p1, directed = FALSE)
	d1 = c(d1, diameter(g1))
	count1 = c(count1, as.integer(is.connected(g1)))
	g2 = random.graph.game(num, p2, directed = FALSE)
	d2 = c(d2, diameter(g2))
	count2 = c(count2, as.integer(is.connected(g2)))
	g3 = random.graph.game(num, p3, directed = FALSE)
	d3 = c(d3, diameter(g3))
	count3 = c(count3, as.integer(is.connected(g3)))
}

is.connected(g1)
mean(count1)
mean(d1)

is.connected(g2)
mean(count2)
mean(d2)

is.connected(g3)
mean(count3)
mean(d3)
