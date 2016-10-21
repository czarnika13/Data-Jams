library(dplyr)
library(RSQLite)

####Horror Movies####
#https://www.kaggle.com/deepmatrix/imdb-5000-movie-dataset
#Read data into R
movie_metadata <- read.csv("~/Downloads/Data-Jam-2/kaggle-data/movie_metadata.csv")
#Filter movies - only want movies with genres that contain Horror
horror = movie_metadata %>% 
  filter(grepl("Horror", genres))
#Filter movies - only want movies with keywords that contain the list below
keywords = movie_metadata %>% 
  filter(grepl("horror|monster|vampire|zombie|haunted|
               murder|post-apocalypse|serial killer|slasher|
               anti hero|caper|criminal mastermind|dark hero|
               kidnapping|psychopath|shootout|supernatural", plot_keywords))
#Join the two sets horror and keywords
halloween_movies = full_join(horror, keywords)
#Remove unneccessary variables
remove(horror, keywords)
#Filter our any Comedy movies
halloween_movies = halloween_movies %>%
  filter(!grepl("Comedy", genres))
#Filter out any duplicate rows
halloween_movies = unique(halloween_movies)
#Remove unneccessary variables
remove(movie_metadata)


####The Simpsons: Treehouse of Horrors####
#https://www.kaggle.com/wcukierski/the-simpsons-by-the-data
#Read data into R
simpsons_script_lines <- read.csv("~/Downloads/Data-Jam-2/kaggle-data/simpsons_script_lines.csv")
simpsons_episodes <- read.csv("~/Downloads/Data-Jam-2/kaggle-data/simpsons_episodes.csv")
#Make an episode id column for future join
simpsons_episodes$episode_id = simpsons_episodes$id
simpsons_script_lines$episode_id = as.numeric(as.character(simpsons_script_lines$episode_id))
#Extract all Halloween episodes 
simpsons_halloween = simpsons_episodes %>% 
  filter(grepl("Treehouse|Halloween", title))
#Join script data with only Halloween episode data
simpsons_script = inner_join(simpsons_halloween, simpsons_script_lines, "episode_id")
remove(simpsons_script_lines, simpsons_episodes)


####Cause of Death####
#https://www.kaggle.com/cdc/mortality
#Connect to SQLite DB
db = "~/Downloads/Data-Jam-2/kaggle-data/death_records.sqlite"
sqlite = dbDriver("SQLite")  
mydb = dbConnect(sqlite, db)
#Remove unneccesary variables
remove(db, sqlite)
#Show all tables in DB
dbListTables(mydb)
#CREATE QUERIES HERE, example below calling all observations within DeathRecords
results = dbSendQuery(mydb, "SELECT * FROM DeathRecords")
#Create R dataset from results
deathrecords = data.frame(fetch(results))
#Clear cache
dbClearResult(results)


####Plane Crashes####
#https://www.kaggle.com/saurograndi/airplane-crashes-since-1908
#Read data into R
airplane_crashes <- read.csv("~/Downloads/Data-Jam-2/kaggle-data/Airplane_Crashes_and_Fatalities_Since_1908.csv")


####Shark Attacks####
#https://www.kaggle.com/teajay/global-shark-attacks
#Read data into R
shark_attacks <- read.csv("~/Downloads/Data-Jam-2/kaggle-data/attacks.csv")