# Refer to edge generation algorithm in GitHub
import re
f = open("processed_act.txt", "r")
p = open("movie_genre.txt", "r")
q = open("movie_actor.txt", "w")

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

for i in Dic_Movie_New:
    line = i + '\t'
    for j in xrange(len(Dic_Movie_New[i])):
        if j == (len(Dic_Movie_New[i]) - 1):
            line = line + str(Dic_Movie_New[i][j])
        else:
            line = line + str(Dic_Movie_New[i][j]) + '\t'
    q.write(line + '\n')

f.close()
p.close()
q.close()
