library(plotrix)
data=read.csv("mostpresentSAteam.csv", sep = ";")

dataf=as.vector(data)

slices = c(dataf$num_players)
lbls =c(dataf$serie_A_team)
pct = round(slices/sum(slices)*100)
lbls = paste(lbls, pct) # add percents to labels
lbls = paste(lbls,"%",sep="") # ad % to labels

piepie=pie3D(slices,theta=0.9,
      col=c("#348673","#004B93","#f3cc22","#FF0044","#B100AA","#ccff73",
                     "#ccff73","#B100AA","#f3cc22",
                     "#348673","#004B93","#ccff73","#DD5322",
                     "#A0ADD1","#B0113D","#A0ADD1","#00caac","#A0ADD1",
                     "#B100AA","#DEDEDE"),
      explode=0.3, main="Which SA team is more present?")


pie3D.labels(piepie,radius=1.1,height=0.3,theta=0.75,
             labels=lbls,
             labelcol="black",
             labelcex=0.5,labelrad=1.5,minsep=0.4)

legend(x="top",inset= .04, piepie,ncol=6,
       c(16, 15, 14, 11,9,8,7,6,5,3,2),
       x.intersp = 0.3,
       cex=0.6,
       fill =c("#ccff73","#348673","#B100AA","#DD5322","#A0ADD1",
              "#004B93","#B0113D","#FF0044","#00caac","#f3cc22","#DEDEDE"), 
       border = "black",
       bty = "n")
