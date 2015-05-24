run_analysis <- function (pref=getwd(),                      # Default is working directory
                          select_col="-mean\\()|-std\\()",   # grep pattern to select columns to keep
                          summary_funs=mean,                 # desired summary function
                          nrows=-1) {                        # Option to limit the number of rows to proc
        
        # getData(<subdir>)
        #       reads subject, activity, and measurement files and returns them in a dataframe after
        #       labeling the columns & converting the activity column to a text factor.
        #  NOTE: To speed up the loading & save memory, only the required columns are returned.
        
        getData <- function(subdir) {
                
                cbind( subject=read.table(paste(pref,"/",subdir,"/subject_",subdir,".txt",sep=""),
                                          col.names=c("subject"),nrows=nrows,colClasses="numeric"),
                       activity=read.table(paste(pref,"/",subdir,"/y_",subdir,".txt",sep=""),
                                                      col.names=c("activity"),nrows=nrows,
                                                      colClasses="numeric"), 
                       read.table(paste(pref,"/",subdir,"/X_",subdir,".txt",sep=""),
                                  colClasses=selcols,col.names=collabels,nrows=nrows)
                )
        }
        
        # Read features file.  This will become the column headers once we read the measurement file.
        # Also, at this point, select the columns that we need to keep so that the read goes faster
        
        actlabels <- ((read.table(paste(pref,"/activity_labels.txt",sep=""),as.is=T))[,2])
        collabels <- ((read.table(paste(pref,"/features.txt",sep=""),as.is=T))[,2])
        selcols <- ifelse(grepl(select_col, collabels),"numeric","NULL")
        
        #  Make one big tidy table from the test & training data
        
        getdata014_merged <<- rbind( getData("test"), getData("train") )
        getdata014_merged$activity <<- factor(actlabels[getdata014_merged$activity],actlabels)
        
        
        # group by activity & subject, and summerise each column
        
        getdata014_report <- as.tbl(getdata014_merged) %>%
                        group_by(activity,subject) %>% 
                        summarise_each(funs(summary_funs))
        #
        # write.table(getdata014_mean, file="getdata014_mean.txt", row.names=F)

        # return summary table  - just because. 
        getdata014_report
}