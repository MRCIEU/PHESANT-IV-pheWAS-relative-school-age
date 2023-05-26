

## this script assumes you have the following in this directory
# PHESANT-master (download phesant as a zip file and then extract in this directory)
# CSV of combined results of the three IV-pheWAS, combinedresults.csv


# read in PHESANT outcome information file
varList=read.table("PHESANT-master/variable-info/outcome-info.tsv", header=1, sep="\t", comment.char="",quote="");


resultsAll = read.csv('combinedresults.csv')

# remove X at start of field ID
resultsAll$varName = gsub("^X", "", resultsAll$varName)



# get just var ID
resultsAll$varID <- sapply(strsplit(resultsAll$varName,"[-#.]", perl=TRUE), "[", 1)

# combine results with outcome info
resultsAllx = merge(resultsAll, varList, by.x="varID", by.y="FieldID", all.x=FALSE, all.y=FALSE, sort=FALSE);

resultsAllx$description <- as.character(resultsAllx$Field)


###
### Add information on the field value for categorical multiple fields

cmIdxs = which(resultsAllx$ValueType=="Categorical multiple")

dccurrent=-1
if(length(cmIdxs)>0) {
  for (ii in 1:length(cmIdxs)) {
    i = cmIdxs[ii]
    thisDC = resultsAllx[i,"DATA_CODING"]
    dcVal = unlist(strsplit(resultsAllx$varName[i],"\\."))[2]
    print(thisDC)
    print(resultsAllx$varName[i])
    print(dcVal)
    if (thisDC == 240 & !is.na(dcVal) & dcVal == "S525") {
      
      print('xxxxxx')
    }
    
    # get data codes for this field
    if(dccurrent!=thisDC) {
      dcfile=paste('PHESANT-master/ukb_data_codes/data_codes/datacode-',thisDC,'.tsv', sep='')
    }
    if (file.exists(dcfile)) {
      
      if(dccurrent!=thisDC) {
        dclist = read.table(dcfile, header=1, sep="\t", comment.char="",quote="")
      }
      
      if (thisDC == 240 & dcVal == "S525") {
        
        print('aaaa')
      }
      
      # columns: coding	meaning
      ixx= which(dclist$coding == dcVal)
      
      if (thisDC == 240 & dcVal == "S525") {
        
        print(ixx)
      }
      
      if (length(ixx)>0) {
        meaning = dclist[ixx,"meaning"]
        newDescription = paste(resultsAllx[i,"description"], ": ", meaning, sep="")
        resultsAllx[i,"description"] <- newDescription
      }
    }
    else {
      print("DC file does not exist (could not add value to cat multiple results):")
      print(dcfile)
    }
    dccurrent=thisDC
  }
}



resultsAllx$TRAIT_OF_INTEREST = NULL
resultsAllx$EXCLUDED = NULL
resultsAllx$CAT_MULT_INDICATOR_FIELDS = NULL
resultsAllx$CAT_SINGLE_TO_CAT_MULT = NULL
resultsAllx$DATE_CONVERT = NULL
resultsAllx$Path = NULL
resultsAllx$Category = NULL
resultsAllx$Field = NULL
#resultsAllx$ValueType = NULL

write.table(resultsAllx, file="combinedresults-with-description.tsv", quote=T, sep='\t', row.names=F)







