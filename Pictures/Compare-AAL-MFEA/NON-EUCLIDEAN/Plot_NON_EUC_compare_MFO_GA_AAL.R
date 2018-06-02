#------------------------------- Set default path -----------------------------------
#load("D:\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\R_Data\\.RData")
setwd("D:\\OneDrive for Business\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\Latex\\Journal of Heuristics (IF.1.8)_Del_18022018\\Pictures\\Compare-AAL-MFEA\\NON-EUCLIDEAN")
getwd()

rm(type_1_small)



type_1_small<-read.csv("MOM_NON_EUC_15022018_V4.csv")


#------------------------------- Create Data of Type 1 -----------------------------------

t1s<-type_1_small[c("Instances", "GA_outperform_AAL")]
t1s$compare<-c("GA_outperform_AAL")
t1s$type<-c("Small instances")
names(t1s)[2]="PI"


tmp<-type_1_small[c("Instances", "MFO_outperform_AAL")]
tmp$compare<-c("MFO_outperform_AAL")
tmp$type<-c("Small instances")
names(tmp)[2]="PI"
t1s_comp<-rbind(t1s,tmp)
save(t1s_comp,file="t1s_comp.RData")

detach()
attach(t1s_comp)


library(ggplot2)
library(grid)
library(png)

windows()
dev.cur()

pl1<-ggplot(data = t1s_comp)

pl1<- pl1+geom_bar(aes(x=Instances,y=PI,group=compare,fill=compare,width=0.6), stat = "identity", subset(t1s_comp,compare == "MFO_outperform_AAL"))
pl1<- pl1+geom_bar(aes(x=Instances,y=-PI,group=compare,fill=compare,width=0.6), stat = "identity", subset(t1s_comp,compare == "GA_outperform_AAL"))
pl1<- pl1+coord_flip()#+facet_grid(type~.,scales = "free_y",space = "free_y")
pl1<- pl1+scale_y_continuous(breaks=seq(-1,1,0.2), labels =abs(seq(-100,100,20)))
pl1<- pl1+theme_bw()+scale_color_brewer(palette = "Set1")
pl1<- pl1+theme(legend.position = "top")+guides(fill=guide_legend(title = NULL))
pl1<- pl1+scale_fill_discrete(labels=c("PI(Single task,AAL)","PI(Multi-tasks, AAL)"))
pl1 <- pl1+theme(axis.title.x = element_text(size=8),axis.title.y = element_text(size=10))

pl1

ggsave("NON_EUC_comp.png", width=3.5, height = 10)

win.metafile("NON_EUC_comp.wmf",width=3.5, height = 20)
pl1
dev.off()