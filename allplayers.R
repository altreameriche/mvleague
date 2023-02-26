library(DT)

ALLplayers=read.csv("playersscore.csv", sep = ";", head=T)

datatable(ALLplayers, rownames = T, filter="top", 
          options = list(pageLength = 10, scrollX=T) )
