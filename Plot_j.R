# Title     : TODO
# Objective : TODO
# Created by: jiangzongqing
# Created on: 2021/3/4

#注意有时需要加这句
# options(repos=c(CRAN="http://mirror.tuna.tsinghua.edu.cn/CRAN/"))
# install.packages('foreign')
# install.packages('ggplot2')
# install.packages('plyr', repos = "http://cran.us.r-project.org")
library(foreign)
library(ggplot2)
library(showtext)

#Pycharm运行R脚本画图时显示中文字符  
par(family="STXihei")
path_data <- "/Users/jiangzongqing/Library/Mobile Documents/com~apple~CloudDocs/R/first/Data/案例数据1：北爱尔兰多年牧草地土壤属性"
setwd(path_data)
data<-read.dbf("sample.dbf")

View(data)
View(data)
dim(data)
names(data)
typeof(data)
typeof(data$PH)

par(family="PingFangSC-Regular")
# par(family='STKaiti')
#绘制直方图
# p<-ggplot(data,aes(x=PH)) +
#   geom_histogram(binwidth=0.1,fill="lightblue",colour="black")
# p
# p+theme_light()+
#   scale_x_continuous(limits = c(5.0,7.0))+
#   labs(title = "案例一 pH数据直方图",x="pH",y="频数")+
#   # theme(text=element_text(family="Songti SC",size=12,face = "bold"))+
#   theme(plot.title = element_text(face = "bold",size = 12,hjust = 0.5))+
#   theme(axis.text.y = element_text(size = 10,angle = 90))+
#   theme(axis.text.x = element_text(size = 10))
# p
#绘制箱线图，注意需要添加fileEncoding = "GBK"
# data<-read.csv("sample.csv",fileEncoding = "GBK")
# data<-data[data$class%in%c("有效钾","有效镁"),]
#
# p<- ggplot(data, aes(x=factor(class),y=content,fill=factor(class)))+
#   geom_boxplot()+
#   scale_fill_brewer(palette="Pastel2")
# p

# p<-ggplot(data, aes(x=factor(class),y=content,fill=factor(class)))+
#   geom_boxplot(outlier.colour = "red",outlier.shape = 8,outlier.size = 1.5)+
#   scale_fill_brewer(palette = "Pastel2")
#   scale_color_manual(values = c("#56B4E9","#E69F00"))
# p
# p+theme(legend.position = "top")+
#   theme(legend.position = "bottom")+
#   theme(legend.position = "none")
# p

#美化箱线图
# theme(legend.position = "none") #去图例
# xlab("")+
#   ylab("含量(mg/L)")
# p

library(GGally)
data$Kclass<-ifelse(data$EXTRA_K<60,c("class3"),
                    ifelse(data$EXTRA_K<80,c("class2"),c("class1")))
data<-data[,c(6:10,14)]
ggscatmat(data)
ggscatmat(data,color = "Kclass")

# library(lattice)
#
# data$pHclass<-ifelse(data$PH<5.5,c("Acid"),ifelse(data$PH<6.5,c("Weak acid"),c("Neutral")))
# #绘制平行线
# parallelplot(
#   ~data[4:10],
#   data,
#   groups=pHclass,
#   theme(legend.position = "top"),
#   horizontal.axis=FALSE
# )