library(ggplot2)

MVteams.short.df= read.csv("MV_matrix.csv", sep = ";")

matrixdata = as.matrix(MVteams.short.df)

barplot(matrixdata,
        cex.axis=0.6,
        col=c("lightgreen", "orange","brown", "lightblue", "violet", "darkgreen"), 
        width = c(4,4,4,4,4,5),
        border="black", 
        beside=T, 
        xlab="MV Teams")

legend("topright",ncol=2,
       c("Won", "Draw", "Lost", "Goals Scored",
       "Goals Against", "Points"),
       cex=0.6,
       x.intersp = 0.3,
       fill =c("lightgreen", "orange","brown", "lightblue", "violet", "darkgreen"), 
       border = "black",
       bty = "n")

##DEVI INVERTIRE X E Y NELLA MATRICE COSì CHE TI VIENE FUORI PER TEAM E NON PER PUNTI
