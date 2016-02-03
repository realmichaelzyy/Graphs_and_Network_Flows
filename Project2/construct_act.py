#!/usr/bin/python
# Refer to edge generation algorithm in GitHub

import re
f = open("processed_act.txt", "r")
g = open("graph_act.txt", "w")
p = open("movie_genre.txt", "r")

Dic_Movie = {}
Id_Movie = 0
Dic_Act = {}
Id_Act = 0
for line in p.readlines():
    tokens = line.split("\t\t")
    Dic_Movie[tokens[0]] = [Id_Movie]
    Id_Movie += 1

for line in f.readlines():
    tokens = line.split("\t\t")
    name = tokens[0]
    tokens[0] = Id_Act
    for i in range(1, len(tokens)):
        movie = tokens[i]
        year = re.search(r'\(\d\d\d\d\)|\(\?\?\?\?\)', movie)
        if year:
            end = movie.find(year.group())
            tokens[i] = movie[:end + 6]
        if Dic_Movie.has_key(tokens[i]):
            Dic_Movie[tokens[i]].append(name)
        else:
            Dic_Movie[tokens[i]] = [len(Dic_Movie)]
            Dic_Movie[tokens[i]].append(name)
    Dic_Act[name] = tokens
    Id_Act += 1

# Construct Act Graph
Edge_Act = {}
for key in Dic_Act:
    for i in range(1, len(Dic_Act[key])):
        movie = Dic_Act[key][i]
        for people in Dic_Movie[movie]:
            if people == key or isinstance(people, int):
                continue
            if Edge_Act.has_key((Dic_Act[key][0], Dic_Act[people][0])):
                Edge_Act[
                    (Dic_Act[key][0], Dic_Act[people][0])] += 1.0 / (len(Dic_Act[key]) - 1)
            else:
                Edge_Act[
                    (Dic_Act[key][0], Dic_Act[people][0])] = 1.0 / (len(Dic_Act[key]) - 1)

for key in Edge_Act:
    s = '%d\t%d\t%f\n' % (key[0], key[1], Edge_Act[key])
    g.write(s)

f.close()
g.close()
p.close()
