######################### FUNCTION TO PERFORM FISHER TEST ON CONTINGENCY TABLES ##################################
# INPUT: a contingency table, ..., significance level
#   checks if contingency table has correct margins
#   performs test
#   outputs a string to describe test result

runFisherTest<-function(cont_table,coloc_yes,coloc_no,other_res_yes,other_res_no,alpha){
  
  # checks if total marginals are ok
  if(margin.table(cont_table,1)!=c(coloc_yes,coloc_no) || margin.table(cont_table,2)!=c(other_res_yes,other_res_no)){
    
    cat("Something is wrong with marginals: check!")
    
  }else{
    
    cat("Fisher exact test on this contingency table:")  
    temp<-fisher.test(cont_table)
    print(temp)
    
    # tests for statistical significance
    if(temp$p.value<alpha){
      cat(paste("The hypotesis of association of",
                unique(gsub("_(YES|NO)","",colnames(cont_table),perl=T)), 
                "on",
                unique(gsub("_(YES|NO)","",rownames(cont_table),perl=T)),
                "is statistically significant.",sep=" "))
    }else{
      cat(paste("The hypotesis of association of",
                unique(gsub("_(YES|NO)","",colnames(cont_table),perl=T)), 
                "on",
                unique(gsub("_(YES|NO)","",rownames(cont_table),perl=T)),
                "is NOT statistically significant.",sep=" "))
    }
  }
}

####### TEST
cont_table<-matrix(c(22,2,19,1),2,2)
rownames(cont_table)<-c("colocalized_YES","colocalized_NO")
colnames(cont_table)<-c("other_resistances_YES","other_resistances_NO")

other_res_no<-20
other_res_yes<-24
coloc_no<-3
coloc_yes<-41

alpha=0.05 # sign. value
runFisherTest(cont_table,coloc_yes,coloc_no,other_res_yes,other_res_no,alpha)