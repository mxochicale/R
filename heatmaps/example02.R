#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           example02.R
# FileDescription:
# https://www.r-bloggers.com/how-to-create-a-fast-and-easy-heatmap-with-ggplot2/ 
# http://rpubs.com/melike/heatmapTable
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#################
# Start the clock!
start.time <- Sys.time()


###############
# Load of libraries
require(ggplot2)
require(reshape2)
require(scales)#for muted function


################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()
setwd("../")
main_repository_path <- getwd()
setwd("../")
github_path <- getwd()
setwd("../")
main_path <- getwd()


### Labels of rows and columns
name_genes <- paste(rep("GEN",20), LETTERS[1:20], sep="_")#rows
name_patients <- paste(rep("PATIENT", 20), seq(1,20,1), sep="_" )#columns

### Generation of dataframe
value_expression <- data.frame(genes = name_genes, matrix(rnorm(400,2,1.8),nrow=20,ncol=20))
names(value_expression)[2:21] <- name_patients

### Melt dataframe
df_heatmap <- melt(value_expression, id.vars="genes")
names(df_heatmap)[2:3] <- c("patient","expression_level")
head(df_heatmap)


### Elaboration of heatmap (white - steelblue)

ggplot(df_heatmap, aes(patient,genes))+
	geom_tile(aes(fill=expression_level))+
	geom_text(aes(fill=expression_level, label = round(expression_level,1)))+ ## write the values
	scale_fill_gradient2(low=muted("darkred"),
		            mid="white",
		            high=muted("midnightblue"))+
	ylab("List of genes")+
	xlab("List of patienst")+
	theme(legend.title=element_text(size=10),
	      legend.text=element_text(size=12),
	      plot.title=element_text(size=16),
	      axis.title=element_text(size=14,face="bold"),
	      axis.text.x=element_text(angle=90,hjust=1))+
	labs(fill="Expression level")
		
	

#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
