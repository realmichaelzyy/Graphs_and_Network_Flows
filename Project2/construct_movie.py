# Refer to edge generation algorithm in GitHub
import re
f = open("processed_act.txt", "r")
p = open("movie_genre.txt", "r")
q = open("graph_movie.txt", "w")

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

Dic_Movie_New = {}
for key in Dic_Movie:
    if(len(Dic_Movie[key])) > 15 and len(key) > 0:
        Dic_Movie_New[key] = Dic_Movie[key]

# Construct Movie Graph
Edge_Movie = {}
Edge_MovieDeno = {}
for key in Dic_Movie_New:
    for i in range(1, len(Dic_Movie_New[key])):
        actor = Dic_Movie_New[key][i]
        for movie in Dic_Act[actor]:
            if movie == key or isinstance(movie, int) or (not Dic_Movie_New.has_key(movie)):
                continue
            totalAct = len(Dic_Movie_New[key]) + len(Dic_Movie_New[movie]) - 2
            if Edge_Movie.has_key((Dic_Movie_New[key][0], Dic_Movie_New[movie][0])):
                Edge_Movie[
                    (Dic_Movie_New[key][0], Dic_Movie_New[movie][0])] += 1
                Edge_MovieDeno[
                    (Dic_Movie_New[key][0], Dic_Movie_New[movie][0])] = totalAct
            elif Edge_Movie.has_key((Dic_Movie_New[movie][0], Dic_Movie_New[key][0])):
                Edge_Movie[
                    (Dic_Movie_New[movie][0], Dic_Movie_New[key][0])] += 1
                Edge_MovieDeno[
                    (Dic_Movie_New[movie][0], Dic_Movie_New[key][0])] = totalAct
            else:
                Edge_Movie[
                    (Dic_Movie_New[key][0], Dic_Movie_New[movie][0])] = 1
                Edge_MovieDeno[
                    (Dic_Movie_New[key][0], Dic_Movie_New[movie][0])] = totalAct

for key in Edge_Movie:
    numerator = Edge_Movie[key] / 2
    denominator = Edge_MovieDeno[key] - numerator
    weight = 1.0 * numerator / denominator
    s = '%d\t%d\t%f\n' % (key[0], key[1], weight)
    q.write(s)

f.close()
p.close()
q.close()
