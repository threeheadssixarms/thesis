#------------------------------- Set default path -----------------------------------
#load("D:\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\R_Data\\.RData")
setwd("D:\\OneDrive for Business\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\Latex\\Journal of Heuristics (IF.1.8)_Del_18022018\\Pictures\\Compare-AAL-MFEA")
getwd()

rm(type_1_small)
rm(type_1_large)


type_1_small<-read.csv("Type_1_Small.csv")
type_1_large<-read.csv("Type_1_Large.csv")


#rm(type_1_small)
#rm(type_1_large)

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

t1l<-type_1_large[c("Instances", "GA_outperform_AAL")]
t1l$compare<-c("GA_outperform_AAL")
t1l$type<-c("Large instances")
names(t1l)[2]="PI"

tmp<-type_1_large[c("Instances", "MFO_outperform_AAL")]
tmp$compare<-c("MFO_outperform_AAL")
tmp$type<-c("Large instances")
names(tmp)[2]="PI"
t1l_comp<-rbind(t1l,tmp)

save(t1l_comp,file="t1l_comp.RData")

t1_comp<-rbind(t1s_comp,t1l_comp)

detach()
attach(t1_comp)


library(ggplot2)
library(grid)
library(png)

windows()
dev.cur()

pl1<-ggplot(data = t1_comp)

pl1<- pl1+geom_bar(aes(x=Instances,y=PI,group=compare,fill=compare,width=0.6), stat = "identity", subset(t1_comp,compare == "MFO_outperform_AAL"))
pl1<- pl1+geom_bar(aes(x=Instances,y=-PI,group=compare,fill=compare,width=0.6), stat = "identity", subset(t1_comp,compare == "GA_outperform_AAL"))
pl1<- pl1+coord_flip()+facet_grid(type~.,scales = "free_y",space = "free_y")
pl1<- pl1+scale_y_continuous(breaks=seq(-1,1,0.2), labels =abs(seq(-100,100,20)))
pl1<- pl1+theme_bw()+scale_color_brewer(palette = "Set1")
pl1<- pl1+theme(legend.position = "top")+guides(fill=guide_legend(title = NULL))
pl1<- pl1+scale_fill_discrete(labels=c("PI(Single task,AAL)","PI(Multi-tasks, AAL)"))
pl1 <- pl1+theme(axis.title.x = element_text(size=8),axis.title.y = element_text(size=10))

pl1

ggsave("Type_1_comp.png", width=3.5, height = 7)

win.metafile("Type_1_comp.wmf",width=3.5, height = 7)
pl1
dev.off()