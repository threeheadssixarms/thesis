#------------------------------- Set default path -----------------------------------
#plload("D:\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\R_Data\\Miss_Eval_Func\\.RData")
setwd("D:\\OneDrive for Business\\MyData\\Read\\Paper\\10. Clustered Shortest-Path Tree Problem\\Latex\\Journal of Heuristics (IF.1.8)_Del_18022018\\Pictures\\Compare-AAL-MFEA")
getwd()

rm(t3l)
rm(t4l)

t3l<-read.csv("Type_3_Large.csv")
t4l<-read.csv("Type_4_Large.csv")

#------------------------------- Create Data of Type 3 -----------------------------------
t34<-t3l[c("Instances", "GA_outperform_AAL")]
t34$compare<-c("GA_outperform_AAL")
t34$type<-c("Type 3")
names(t34)[2]="PI"


tmp<-t3l[c("Instances", "MFO_outperform_AAL")]
tmp$compare<-c("MFO_outperform_AAL")
tmp$type<-c("Type 3")
names(tmp)[2]="PI"
t34<-rbind(t34,tmp)
#save(t34,file="t3l_comp.RData")

tmp<-t3l[c("Instances", "MFO_outperform_GA")]
tmp$compare<-c("MFO_outperform_GA")
tmp$type<-c("Type 3")
names(tmp)[2]="PI"
t34<-rbind(t34,tmp)



#------------------------------- Create Data of Type 4 -----------------------------------
tmp<-t4l[c("Instances", "GA_outperform_AAL")]
tmp$compare<-c("GA_outperform_AAL")
tmp$type<-c("Type 4")
names(tmp)[2]="PI"
t34<-rbind(t34,tmp)


tmp<-t4l[c("Instances", "MFO_outperform_AAL")]
tmp$compare<-c("MFO_outperform_AAL")
tmp$type<-c("Type 4")
names(tmp)[2]="PI"
t34<-rbind(t34,tmp)

tmp<-t4l[c("Instances", "MFO_outperform_GA")]
tmp$compare<-c("MFO_outperform_GA")
tmp$type<-c("Type 4")
names(tmp)[2]="PI"
t34<-rbind(t34,tmp)


#------------------------------- Plot graph -----------------------------------
detach()
attach(t34)


library(ggplot2)

#dev.off(dev.cur())
windows()
dev.cur()


pl34<-ggplot(data = t34)

pl34<- pl34 + geom_bar(aes(x=Instances,y=PI,group=compare,fill=compare,width=0.6), alpha = 1, palettes = "BuPu", stat = "identity", subset(t34,compare == "MFO_outperform_AAL"))
pl34<- pl34 + geom_bar(aes(x=Instances,y=-PI,group=compare,fill=compare,width=0.6), stat = "identity", subset(t34,compare == "GA_outperform_AAL"))
pl34<- pl34 + geom_bar(aes(x=Instances,y=PI,group=compare,fill=compare,width=0.6), stat = "identity", subset(t34,compare == "MFO_outperform_GA"))

pl34<- pl34 + coord_flip()
pl34<- pl34 + facet_grid(type~.,scales = "free_y",space = "free_y")

pl34<- pl34 + scale_y_continuous(breaks=seq(-1,1,0.2), labels = abs(seq(-100,100,20)))
pl34<- pl34 + theme_bw()+scale_color_brewer(palette = "Set1")

pl34 <- pl34 + theme(legend.position = "top")
pl34 <- pl34 + scale_fill_discrete(limits=c("GA_outperform_AAL","MFO_outperform_AAL","MFO_outperform_GA"), labels=c("PI(Single task,AAL)","PI(Multi-tasks, AAL)","PI(Multi-tasks, Single task)"))
pl34 <- pl34 + theme(axis.title.x = element_text(size=8),axis.title.y = element_text(size=10))
pl34 <- pl34 + guides(fill=guide_legend(ncol=2))
#pl34 <- pl34 + guides(fill=guide_legend(title = NULL))
pl34 <- pl34 + theme(legend.title = element_blank())

#pl34 <- pl34 + geom_text(data=subset(t34,compare == "GA_outperform_AAL"), aes(x = Instances, y = PI, label = 100*round(PI,1)), size = 3, show.legend = F, colour="white")


pl34
ggsave("Type_34_BAR_comp.png", width=4, height = 4)

win.metafile("Type_34_BAR_comp.wmf",width=4,height = 4)
pl34
dev.off()


