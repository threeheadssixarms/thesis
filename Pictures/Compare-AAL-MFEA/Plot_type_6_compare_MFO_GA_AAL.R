#------------------------------- Set default path -----------------------------------
#rm(list=ls())
#load("D:\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\R_Data\\.RData")
setwd("D:\\OneDrive for Business\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\Latex\\Journal of Heuristics (IF.1.8)_Del_18022018\\Pictures\\Compare-AAL-MFEA")
getwd()

rm(type_6_small)
rm(type_6_large)


type_6_small <- read.csv("Type_6_Small.csv")
type_6_large <- read.csv("Type_6_Large.csv")

#rm(type_6_small)
#rm(type_6_large)

#------------------------------- Create Data of Type 6 -----------------------------------


t6s<-type_6_small[c("Instances", "GA_outperform_AAL")]
t6s$compare<-c("GA_outperform_AAL")
t6s$type<-c("Small instances")
names(t6s)[2]="PI"


tmp<-type_6_small[c("Instances", "MFO_outperform_AAL")]
tmp$compare<-c("MFO_outperform_AAL")
tmp$type<-c("Small instances")
names(tmp)[2]="PI"
t6s_comp<-rbind(t6s,tmp)
save(t6s_comp,file="t6s_comp.RData")

t6l<-type_6_large[c("Instances", "GA_outperform_AAL")]
t6l$compare<-c("GA_outperform_AAL")
t6l$type<-c("Large instances")
names(t6l)[2]="PI"

tmp<-type_6_large[c("Instances", "MFO_outperform_AAL")]
tmp$compare<-c("MFO_outperform_AAL")
tmp$type<-c("Large instances")
names(tmp)[2]="PI"
t6l_comp<-rbind(t6l,tmp)

save(t6l_comp,file="t6l_comp.RData")

t6_comp<-rbind(t6s_comp,t6l_comp)
detach()
attach(t6_comp)


library(ggplot2)

windows()
dev.cur()

pl6<-ggplot(data = t6_comp)

pl6<- pl6+geom_bar(aes(x=Instances,y=PI,group=compare,fill=compare, width=0.6), stat = "identity", subset(t6_comp,compare == "MFO_outperform_AAL"))
pl6<- pl6+geom_bar(aes(x=Instances,y=-PI,group=compare,fill=compare, width=0.6), stat = "identity", subset(t6_comp,compare == "GA_outperform_AAL"))
pl6<- pl6+coord_flip()+facet_grid(type~.,scales = "free_y",space = "free_y")
pl6<- pl6+scale_y_continuous(breaks=seq(-1,1,0.2), labels =abs(seq(-100,100,20)))
pl6<- pl6+theme_bw()+scale_color_brewer(palette = "Set1")
pl6<- pl6+theme(legend.position = "top")+guides(fill=guide_legend(title = NULL))
pl6<- pl6+scale_fill_discrete(labels=c("PI(Single task,AAL)","PI(Multi-tasks, AAL)"))
pl6 <- pl6+theme(axis.title.x = element_text(size=8),axis.title.y = element_text(size=10))

pl6

#png("Type_6_comp.png")
#print(pl6)
#png("data.png", height=700, width=650)

ggsave("Type_6_comp.png", width=3.8,height = 8)

win.metafile("Type_6_comp.wmf",width=3.8,height = 8)
pl6



dev.off()