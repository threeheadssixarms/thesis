#------------------------------- Set default path -----------------------------------
#rm(list=ls())
#load("D:\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\R_Data\\.RData")
setwd("D:\\OneDrive for Business\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\Latex\\Journal of Heuristics (IF.1.8)_Del_18022018\\Pictures\\Compare-AAL-MFEA")
getwd()


rm(type_5_small)
rm(type_5_large)


type_5_small <- read.csv("Type_5_Small.csv")
type_5_large <- read.csv("Type_5_Large.csv")

#rm(type_1_small)
#rm(type_1_large)

#------------------------------- Create Data of Type 5 -----------------------------------

t5s<-type_5_small[c("Instances", "GA_outperform_AAL")]
t5s$compare<-c("GA_outperform_AAL")
t5s$type<-c("Small instances")
names(t5s)[2]="PI"

tmp<-type_5_small[c("Instances", "MFO_outperform_AAL")]
tmp$compare<-c("MFO_outperform_AAL")
tmp$type<-c("Small instances")
names(tmp)[2]="PI"
t5s_comp<-rbind(t5s,tmp)

save(t5s_comp,file="t5s_comp.RData")

rm(tmp)
t5l<-type_5_large[c("Instances", "GA_outperform_AAL")]
t5l$compare<-c("GA_outperform_AAL")
t5l$type<-c("Large instances")
names(t5l)[2]="PI"

tmp<-type_5_large[c("Instances", "MFO_outperform_AAL")]
tmp$compare<-c("MFO_outperform_AAL")
tmp$type<-c("Large instances")
names(tmp)[2]="PI"

t5l_comp <- rbind(t5l,tmp)
save(t5l_comp,file="t5l_comp.RData")

t5_comp <- rbind(t5s_comp,t5l_comp)
save(t5_comp,file="t5l_comp.RData")
attach(t5_comp)


library(ggplot2)
library(grid)
#library(png)

windows()
dev.cur()

pl5 <- ggplot(data = t5_comp)

pl5 <- pl5+geom_bar(aes(x=Instances,y=PI,group=compare,fill=compare, width=0.6), stat = "identity", subset(t5_comp,compare == "MFO_outperform_AAL"))
pl5 <- pl5+geom_bar(aes(x=Instances,y=-PI,group=compare,fill=compare, width=0.6), stat = "identity", subset(t5_comp,compare == "GA_outperform_AAL"))
pl5 <- pl5+coord_flip()+facet_grid(type~.,scales = "free_y",space = "free_y")
pl5 <- pl5+scale_y_continuous(breaks=seq(-1,1,0.2), labels =abs(seq(-100,100,20)))
pl5 <- pl5+theme_bw()+scale_color_brewer(palette = "Set1")
pl5 <- pl5+theme(legend.position = "top")+guides(fill=guide_legend(title = NULL))
pl5 <- pl5+scale_fill_discrete(labels=c("PI(Single task,AAL)","PI(Multi-tasks, AAL)"))
pl5 <- pl5+theme(axis.title.x = element_text(size=8),axis.title.y = element_text(size=10))

pl5
ggsave("Type_5_comp.png", width=3.5, height = 7)

win.metafile("Type_5_comp.wmf",width=3.5,height = 7)
pl5
dev.off()