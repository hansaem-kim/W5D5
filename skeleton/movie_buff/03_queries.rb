def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.select(:title, :id).joins(:actors).where(actors: {name: those_actors}).group(:id).having('COUNT(*) = ?', those_actors.length)
#   .where(actors: {name: those_actors})
end
def golden_age
  # Find the decade with the highest average movie score.
    Movie.select("((yr/10 )* 10)  AS decade", "AVG(score) AS average_score").group("decade").order("average_score DESC").first.decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery

    movies1 = Movie.select(:id).joins(:actors).where('name = ?', name)

    Actor.joins(:movies).where(movies: { id: movies1 }).where.not('name = ?', name).distinct.pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.select(:name).left_outer_joins(:castings).where(castings: {movie_id: nil}).count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

    
   
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

    Actor.select(:id, :name, 'MAX(yr)-MIN(yr) AS career').joins(:movies).group(:id).order("career DESC").limit(3).order(:name)
end
