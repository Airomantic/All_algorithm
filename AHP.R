# Title     : GIS空间分析
# Objective : AHP层次决策分析
# Created by: jiangzongqing
# Created on: 2021/3/25

##输入：judgeMatrix 判断矩阵；round 结果约分位数
weight <- function (judgeMatrix, round=6) {
  n = ncol(judgeMatrix)
  # cumProd <- vector(length=n)
  cumProd <- apply(judgeMatrix, 1, prod)  ##求每行连乘积
  featureVectors <- cumProd^(1/n)  ##开n次方(特征向量)
  weight <- featureVectors/sum(featureVectors) ##求权重
  round(weight,round)
}
Detailed<- function (judgeMatrix, round=6) {
  n = ncol(judgeMatrix)
  # cumProd <- vector(length=n)
  cumProd <- apply(judgeMatrix, 1, prod)  ##求每行连乘积
  featureVectors <- cumProd^(1/n)  ##开n次方(特征向量)
  weight <- featureVectors/sum(featureVectors) ##求权重
  print(round(cumProd,round))
  print(round(featureVectors,round))
  print(round(weight,round))
}
###注：CRtest调用了weight函数
###输入：judgeMatrix
###输出：CI, CR
CRtest <- function (judgeMatrix, round=6){
  RI <- c(0, 0, 0.58, 0.9, 1.12, 1.24, 1.32, 1.41, 1.45, 1.49, 1.51) #随机一致性指标
  Wi <- weight(judgeMatrix)  ##计算权重
  n <- length(Wi)
  if(n > 11){
    cat("判断矩阵过大,请少于11个指标 \n")
  }
  if (n > 2) {
    W <- matrix(Wi, ncol = 1)
    judgeW <- judgeMatrix %*% W
    JudgeW <- as.vector(judgeW)
    la_max <- sum(JudgeW/Wi)/n
    CI = (la_max - n)/(n - 1)
    CR = CI/RI[n]
    cat("\n CI=", round(CI, round), "\n")
    cat("\n CR=", round(CR, round), "\n")
    if (CR <= 0.1) {
      cat(" 通过一致性检验 \n")
      cat("\n Wi: ", round(Wi, round), "\n")
    }
    else {
      cat(" 请调整判断矩阵,使CR<0.1 \n")
      Wi = NULL
    }
  }
  else if (n <= 2) {
    return(Wi)
  }
  consequence <- c(round(CI, round), round(CR, round))
  names(consequence) <- c("CI", "CR")
  consequence
}
en_a<- function (judgeMatrix, round=6){
  eigen(judgeMatix)
}

#先列后行
a<-c(1,1/3,1/4,1/2,
     3,1,2,2,
     4,1/2,1,1/2,
     2,1/2,2,1)
cat("展示原始矩阵\n")
(judgeMatix <- matrix(a, ncol=4,nrow=4))

##判断矩阵一致性检验
cat("计算乘积、开n次方、权重\n")
Detailed(judgeMatix)
CRtest(judgeMatix)
cat("计算特征值，CI，CR\n")
en_a(judgeMatix)$values
#打分归一化#采用离差归一化的方式对打分数据归一化
Tree3<-function (judgeMatix,treeChoose,round=6){
  b1=(treeChoose[,1]-min(treeChoose[,1]))/(max(treeChoose[,1])-min(treeChoose[,1]))
  b2=(treeChoose[,2]-min(treeChoose[,2]))/(max(treeChoose[,2])-min(treeChoose[,2]))
  b3=(treeChoose[,3]-min(treeChoose[,3]))/(max(treeChoose[,3])-min(treeChoose[,3]))
  b4=(treeChoose[,4]-min(treeChoose[,4]))/(max(treeChoose[,4])-min(treeChoose[,4]))
  data_scatter=cbind(b1,b2,b3,b4)
  print(data_scatter)
  cat("得分\n")
  cat("松树: ")
  print(sum(weight(judgeMatix)*data_scatter[1,]))
  cat("衫树: ")
  print(sum(weight(judgeMatix)*data_scatter[2,]))
  cat("桉树: ")
  print(sum(weight(judgeMatix)*data_scatter[3,]))
}

tree<-c(4,6,7,
    1,3,8,
    7,2,9,
    10,1,3)
(treeChoose <- matrix(tree, ncol=4,nrow=3))
cat("计算经济效益，生态效益，社会效益，技术要求\n")
Tree3(judgeMatix,treeChoose)
