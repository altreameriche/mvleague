#LIB LOAD-----------------------------------------------------------------------
#  LOAD libraries

library(ggplot2)
library(plotly)

#READ DF------------------------------------------------------------------------
#    READ the dataframes

players.df= read.csv("players.csv", sep = ";")
MVteams.df= read.csv("teams_MV.csv", sep = ";")
SAteams.df=read.csv("serieA.csv", sep = ";")
CO.df=read.csv("national_teams.csv", sep = ";")

Player=players.df[,"player"]
MVplayers=c(Player[1:200])

role=players.df[,"role"]
roles=c(role[1:200])

Fantav=players.df[,"Fm"]
Fm=c(Fantav[1:200])

Mediav=players.df[,"Mv"]
Mv=c(Mediav[1:200])

Teams=players.df[,"team_name"]
MVTeam=c(Teams[1:200])

#Plotting more than one so that each can be used separately in the Rmd

#BSAcquedotto--------

p = players.df %>%
  filter(team_name=="BSAcquedotto") %>%
ggplot( aes(x=Fm, y=player, size = Pv, color=role)) +
  geom_point()+
  theme_bw()

ggplotly(p)

#Team Shark--------

p1 = players.df %>%
  filter(team_name=="Team Shark") %>%
  ggplot( aes(x=Fm, y=player, size = Pv, color=role)) +
  geom_point()+
  theme_bw()

ggplotly(p1)

#Team Vision--------

p2 = players.df %>%
  filter(team_name=="Team Vision") %>%
  ggplot( aes(x=Fm, y=player, size = Pv, color=role)) +
  geom_point()+
  theme_bw()

ggplotly(p2)

#Hellas Coteca--------

p3 = players.df %>%
  filter(team_name=="Hellas Coteca") %>%
  ggplot( aes(x=Fm, y=player, size = Pv, color=role)) +
  geom_point()+
  theme_bw()

ggplotly(p3)

#La ciurma alcolica--------

p4 = players.df %>%
  filter(team_name=="La ciurma alcolica") %>%
  ggplot( aes(x=Fm, y=player, size = Pv, color=role)) +
  geom_point()+
  theme_bw()

ggplotly(p4)

#Pregiudicati di Caltanissetta--------

p5 = players.df %>%
  filter(team_name=="Pregiudicati di Caltanissetta") %>%
  ggplot( aes(x=Fm, y=player, size = Pv, color=role)) +
  geom_point()+
  theme_bw()

ggplotly(p5)

#Absentia--------

p6 = players.df %>%
  filter(team_name=="Absentia") %>%
  ggplot( aes(x=Fm, y=player, size = Pv, color=role)) +
  geom_point()+
  theme_bw()

ggplotly(p6)

#Krampouezh Klub--------

p7 = players.df %>%
  filter(team_name=="Krampouezh Klub") %>%
  ggplot( aes(x=Fm, y=player, size = Pv, color=role)) +
  geom_point()+
  theme_bw()

ggplotly(p7)

#ALL TEAMS--------

p8 = MVteams.df %>%
  filter(G>=16) %>%
  ggplot( aes(y=V, x=Gf, size = Pt..Totali, color=team_name)) +
  geom_point()+
  theme_bw()

ggplotly(p8)

#--------------------


