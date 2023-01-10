-- 1.List the films where the yr is 1962 [Show id, title] 

SELECT id, title
FROM movie
WHERE yr=1962;


-- 2.Give year of 'Citizen Kane'.

SELECT yr
FROM movie
WHERE TITLE = 'Citizen Kane';


-- 3.List all of the Star Trek movies, include the id, title and yr (all of these movies include the words
Star Trek in the title). Order results by year.

select id,title,yr
from movie
where title like '%Star Trek%'
order by yr;


-- 4.What id number does the actor 'Glenn Close' have?

select id
from actor
where name = 'Glenn Close';


-- 5.What is the id of the film 'Casablanca'?

select id
from movie
where title = 'Casablanca';


-- 6.Obtain the cast list for 'Casablanca'. what is a cast list?Use movieid=11768, (or whatever value you got from the previous question)

select a.name
from movie m
join casting c on c.movieid = m.id
join actor a on a.id = c.actorid
where m.id = 11768;


-- 7. Obtain the cast list for the film 'Alien'

select a.name
from movie m
join casting c on c.movieid = m.id
join actor a on a.id = c.actorid
where m.title = 'Alien';


-- 8. List the films in which 'Harrison Ford' has appeared

select m.title
from movie m
join casting c on c.movieid = m.id
join actor a on a.id = c.actorid
where a.name = 'Harrison Ford';


-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

select m.title
from movie m
join casting c on c.movieid = m.id
join actor a on a.id = c.actorid
where a.name = 'Harrison Ford' and c.ord <> 1;


-- 10. List the films together with the leading star for all 1962 films.

select m.title, a.name
from movie m
join casting c on c.movieid = m.id
join actor a on a.id = c.actorid
where m.yr = 1962 and c.ord = 1;


-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
movie JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name='Doris Day'
GROUP BY yr
HAVING COUNT(title) > 1;


-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in. Did you get "Little Miss Marker twice"?

SELECT movieid FROM casting
WHERE actorid IN (
SELECT id FROM actor
WHERE name='Julie Andrews');


-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

with t1 as (select a.name as name, count(ord) as movie_counts
from actor a
join casting c on c.actorid = a.id
where c.ord = 1
group by a.name
having movie_counts>=15
)
select t1.name
from t1;


-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

select m.title as movie_name, count(a.name) as no_of_actors
from movie m
join casting c on c.movieid = m.id
join actor a on a.id = c.actorid
where m.yr = 1978
group by m.title
order by no_of_actors desc, movie_name;


-- 15. List all the people who have worked with 'Art Garfunkel'.

select a1.name from actor a1
join casting c1 on a1.id = c1.actorid
where c1.movieid in(select m.id as movie_id
from movie m
join casting c on c.movieid = m.id
join actor a on a.id = c.actorid
where a.name = 'Art Garfunkel'
group by m.title)
and a1.name <> 'Art Garfunkel';