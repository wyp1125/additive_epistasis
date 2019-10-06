a<-read.delim("dnn_grs.auc",header=F)
a0=cbind(a[,3],a[,2])
b<-t(as.matrix(a0))
colnames(b)=as.character(a[,1])
png("fig3.png",width=6,height=6,units="in",res=400)
barplot(b,
xlab = "Noise ratio",
ylab = "AUC",
beside=T,
ylim=c(0,1),
axis.lty="solid",
col = c("yellow","blue")
)
legend("topright",c("GRS","DNN"),cex =1,fill=c("yellow","blue"))
dev.off()