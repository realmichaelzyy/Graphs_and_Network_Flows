library(igraph)

num = 1000
iteration = 50

p1 = 0.01
deg1 = numeric()
d1 = numeric()
p2 = 0.05
deg2 = numeric()
d2 = numeric()
p3 = 0.1
deg3 = numeric()
d3 = numeric()

for (i in 1:iteration) {
	g1 = random.graph.game(num, p1, directed = FALSE)
	deg1 = c(deg1, degree(g1))
	d1 = c(d1, diameter(g1))
	g2 = random.graph.game(num, p2, directed = FALSE)
	deg2 = c(deg2, degree(g2))
	d2 = c(d2, diameter(g2))
	g3 = random.graph.game(num, p3, directed = FALSE)
	deg3 = c(deg3, degree(g3))
	d3 = c(d3, diameter(g3))
}

h1 = hist(deg1, breaks = seq(from = 0, to = max(deg1) + 1, by = 1), freq = FALSE, main = "Histogram of degree distribution when p=0.01", 
	xlab = "Degree")
h2 = hist(deg2, breaks = seq(from = 0, to = max(deg2) + 1, by = 1), freq = FALSE, main = "Histogram of degree distribution when p=0.05", 
	xlab = "Degree")
h3 = hist(deg3, breaks = seq(from = 0, to = max(deg3) + 1, by = 1), freq = FALSE, main = "Histogram of degree distribution when p=0.1", 
	xlab = "Degree")
