library(ggplot2)
library(wesanderson)

MVteams.short.df= read.csv("MV_matrix.csv", sep = ";")
print(MVteams.short.df)

matrixdata = as.matrix(MVteams.short.df)
print(matrixdata)

vectordata=as.vector(MVteams.short.df)
print(vectordata)

barplot(matrixdata,
        cex.axis=0.6,
        col=c("lightgreen", "orange","brown", "lightblue", "violet", "darkgreen"), 
        width = c(4,4,4,4,4,5),
        border="black", 
        font.axis=100, 
        beside=T, 
        xlab="MV Teams", 
        font.lab=22
)

legend("topright", ncol=2, c("Won", "Draw", "Lost", "Goals Scored",
                                      "Goals Against", "Points"),
       x.intersp = 0.3,
       fill =c("lightgreen", "orange","brown", "lightblue", "violet", "darkgreen"), 
       border = "black",
       bty = "n")

##DEVI INVERTIRE X E Y NELLA MATRICE COSì CHE TI VIENE FUORI PER TEAM E NON PER PUNTI