# Repeated Testing Table Function
# Can be used for any type of multiple testing
# here it uses a glm but I've also used it with 'lm' and t-tests
# be sure to change the column numbers as they were specific to a project

var_glm <- function(df){
  pvalue <- NULL
  for(i in unique(colnames(df[,c(1:13, 79, 81)]))) {
    var <- df[,i]
    test <- glm(Event2 ~ var, data = df, family = "binomial")
    pval <- round(coef(summary(test))[,4][[2]], 4)
    pval <- cbind(pval, exp(summary(test)$coefficients[,1][[2]]))
    pval <- cbind(pval, exp(summary(test)$coefficients[,1][[2]] + qnorm(c(0.025)) * summary(test)$coefficients[,2][[2]]))
    pval <- cbind(pval, exp(summary(test)$coefficients[,1][[2]] + qnorm(c(0.975)) * summary(test)$coefficients[,2][[2]]))
    pvalue <- rbind(pvalue, pval)
  }
  pvalue <- as.data.frame(pvalue)
  pvalue$Unit <- colnames(df[,c(1:13, 79, 81)])
  colnames(pvalue) <- c("P Value", "Odds Ratio", "LowerCI", "UpperCI", "Variable")
  pvalue$CI95 <- paste("(",round(pvalue$LowerCI, 2),", ",round(pvalue$UpperCI, 2),")")
  pvalue <- pvalue[-c(3, 4)]
  return(pander(pvalue))
}
