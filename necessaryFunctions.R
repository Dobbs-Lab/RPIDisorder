#' reduceAlphabet
#'
#' Takes an amino acid or RNA string and reduces the alphabet to RPIMotif/RPISeq's necessary representation
#' @param seqObject A character string or rpi object containing the sequences to convert
#' @param type The type of sequence; proteins will be reduced to 7-letter alphabet based on physicochemical properties; RNA will be converted to a numeric representation
#'
#' @return seqObject Returns a converted character string
#' @return tempDF Returns a data frame with converted information
#' @export
#'
#' @examples

reduceAlphabet <- function(object, type){
  UseMethod("reduceAlphabet", object)
}

reduceAlphabet.default <- function(seqObject, type){
  if(type=="protein"){
    #Convert the protein strings in the object to the reduced alphabet
    seqObject <- chartr("A", "0", seqObject)
    seqObject <- chartr("G", "0", seqObject)
    seqObject <- chartr("V", "0", seqObject)
    seqObject <- chartr("I", "1", seqObject)
    seqObject <- chartr("L", "1", seqObject)
    seqObject <- chartr("F", "1", seqObject)
    seqObject <- chartr("P", "1", seqObject)
    seqObject <- chartr("Y", "2", seqObject)
    seqObject <- chartr("M", "2", seqObject)
    seqObject <- chartr("T", "2", seqObject)
    seqObject <- chartr("S", "2", seqObject)
    seqObject <- chartr("H", "3", seqObject)
    seqObject <- chartr("N", "3", seqObject)
    seqObject <- chartr("Q", "3", seqObject)
    seqObject <- chartr("W", "3", seqObject)
    seqObject <- chartr("R", "4", seqObject)
    seqObject <- chartr("K", "4", seqObject)
    seqObject <- chartr("D", "5", seqObject)
    seqObject <- chartr("E", "5", seqObject)
    seqObject <- chartr("C", "6", seqObject)
    seqObject <- chartr("a", "0", seqObject)
    seqObject <- chartr("g", "0", seqObject)
    seqObject <- chartr("v", "0", seqObject)
    seqObject <- chartr("i", "1", seqObject)
    seqObject <- chartr("l", "1", seqObject)
    seqObject <- chartr("f", "1", seqObject)
    seqObject <- chartr("p", "1", seqObject)
    seqObject <- chartr("y", "2", seqObject)
    seqObject <- chartr("m", "2", seqObject)
    seqObject <- chartr("t", "2", seqObject)
    seqObject <- chartr("s", "2", seqObject)
    seqObject <- chartr("h", "3", seqObject)
    seqObject <- chartr("n", "3", seqObject)
    seqObject <- chartr("q", "3", seqObject)
    seqObject <- chartr("w", "3", seqObject)
    seqObject <- chartr("r", "4", seqObject)
    seqObject <- chartr("k", "4", seqObject)
    seqObject <- chartr("d", "5", seqObject)
    seqObject <- chartr("e", "5", seqObject)
    seqObject <- chartr("c", "6", seqObject)
  } else if(type=="rna"){
    #Convert RNA strings to reduced alphabet
    seqObject <- chartr("A", "0", seqObject)
    seqObject <- chartr("U", "1", seqObject)
    seqObject <- chartr("T", "1", seqObject)
    seqObject <- chartr("C", "2", seqObject)
    seqObject <- chartr("G", "3", seqObject)
    seqObject <- chartr("a", "0", seqObject)
    seqObject <- chartr("u", "1", seqObject)
    seqObject <- chartr("t", "1", seqObject)
    seqObject <- chartr("c", "2", seqObject)
    seqObject <- chartr("g", "3", seqObject)
  }
  return(seqObject)
}

reduceAlphabet.rpi <- function(seqObject, type){
  tempDF <- seqObject
  if(type=="protein"){
    for(i in 1:nrow(seqObject)){
      tempDF$protSeq[i] <- reduceAlphabet(seqObject$protSeq[i])
    }
  } else if(type=="rna"){
    for(i in 1:nrow(seqObject)){
      tempDF$rnaSeq[i] <- reduceAlphabet(seqObject$rnaSeq[i])
    }
  }
  return(tempDF)
}

#' createFV
#'
#' @param type Specifies the type of interaction; positive is for positive training data, negative for negative training data, and testing for when class of data is unknown or data is testing data
#'
#' @return featureVectorDF A data frame containing the features/attributes fores each interaction
#' @export
#'
#' @examples
#'

createFeatureVector <- function(protSeq, rnaSeq, disorderFile){
  #Load in conjoint triad and conjoint tetrad information
  data(c3List)
  data(c4List)

  #Reduce the protein alphabet and convert RNA to numeric pattern
  protSeq <- reduceAlphabet(protSeq, "protein")
  rnaSeq  <- reduceAlphabet(rnaSeq, "rna")

  #Define three empty matrices to hold the three feature vector components (protein, RNA, Disorder)
  featureProtDF   <- matrix(0, nrow=1, ncol=343)
  featureRnaDF    <- matrix(0, nrow=1, ncol=256)
  colNL <- c(c3List, c4List, "D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "D11", "D12", "D13", "D14", "D15", "disPhillic", "disMod", "disPhobic", "disPos", "disNeg", "disNeut", "ordPhillic", "ordMod", "ordPhobic", "ordPos", "ordNeg", "ordNeut","class")

  #Slide a 3 amino acid window across the amino acid sequence and add the counts of the triads to the matrix
  for(j in 1:(nchar(protSeq)-2)){
    pPattern <- substr(protSeq, j, j+2)
    triad <- grep(pPattern, c3List, value=FALSE)
    if(length(triad)>0){
      featureProtDF[1, triad] <- featureProtDF[1, triad] + 1
    }
  }

  #Normalize the conjoint triad count
  minPFreq <- min(featureProtDF[1, ])
  maxPFreq <- max(featureProtDF[1, ])

  for(k in 1:343){
    featureProtDF[1, k] <- (featureProtDF[1, k]-minPFreq)/(maxPFreq)
  }

  #Slide a 4 ribonucleotide window across the amino acid sequence and add the counts of the tetrads to the matrix
  for(l in 1:(nchar(rnaSeq)-3)){
    rPattern <- substr(rnaSeq, l, l+3)
    tetrad <- grep(rPattern, c4List, value=FALSE)
    if(length(tetrad)>0){
      featureRnaDF[1, tetrad] <- featureRnaDF[1, tetrad] + 1
    }
  }

  #Normalize the conjoint tetrad count
  minRFreq <- min(featureRnaDF[1, ])
  maxRFreq <- max(featureRnaDF[1, ])

  for(m in 1:256){
    featureRnaDF[1, m] <- (featureRnaDF[1, m]-minRFreq)/(maxRFreq)
  }

  #Process disorder
  featureDisoDF <- getDisorderFeatureVector(disorderFile)


  #concatenate feature vectors, and set class type:
  featureDFclassless <- cbind(cbind(featureProtDF, featureRnaDF), featureDisoDF)

  #Set class features; -1 means class unknown
  classVal <- data.frame(classVal = "?")
  featureDF <- cbind(featureDFclassless, classVal)

  colnames(featureDF) <- colNL
  featureVectorDF <- as.data.frame(featureDF)
  return(featureVectorDF)
}


getRpiDisorderArff <- function(protSeq, rnaSeq, disoFile){
  featureVector <- createFeatureVector(protSeq, rnaSeq, disoFile)
  return(featureVector)
}


#Necessary Functions#' writeSpArff
#'
#' Write a sparse .arff file
#' @param df Data frame containing feature vector to write to sp.arff
#' @param fileName The name of the out file
#'
#' @return TRUE Returns TRUE if executed to completion
#' @export
#'
#' @examples

writeSpArffRpiDisorder <- function(df, fileName, appending){
  UseMethod("writeSpArff", df)
}

writeSpArff <- function(df, fileName, appending = FALSE){

  sink(file=fileName, append=TRUE, type="output")
  colList <- colnames(df)

  if(!appending){
  	pNames <- unlist(lapply("P", paste0, as.character(1:343)))
  	rNames <- unlist(lapply("R", paste0, as.character(1:256)))
  	colListV <- c(pNames, rNames, "D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "D11", "D12", "D13", "D14", "D15", "disPhillic", "disMod", "disPhobic", "disPos", "disNeg", "disNeut", "ordPhillic", "ordMod", "ordPhobic", "ordPos", "ordNeg", "ordNeut","class")
  	
  	cat(paste0("@relation ", substitute(df), " \n"), append=TRUE)
  	
  	#Write ARFF headings
  	for(i in 1:(length(colListV)-1)){
  		if(i < 627){
  			typeStuff <- "numeric"
  		}
  		outLine <- paste0("@attribute ", colListV[i], " ", typeStuff)
  		cat(outLine, append=TRUE)
  		cat("\n", append=TRUE)
  	}
  	
  	cat("@attribute class {0,1}", append=TRUE)
  	cat("\n", append=TRUE)
  	cat("@data", append=TRUE)
  }
 
  cat("\n", append=TRUE)
  cat("{", append=TRUE)

  for(k in 1:627){
    colNum <- k
    if(k < 627){
      if(df[1,k] != 0){
        dat <- paste0(colNum-1, " ", round(as.numeric(df[1,k]), digits = 6), ",")
        cat(dat, append=TRUE)
      }
    } else {
      dat <- paste0(626, " ?}")
      cat(dat, append=TRUE)
    }

  }

  sink(NULL)
  return(TRUE)
}

getDisorderFeatureVector <- function(inFile){
   contents <- read.table(inFile, na.strings="NOTAPPLICABLE", skip=3, stringsAsFactors = FALSE)
   
   #calculate features
   percentDisordered <- length(which(contents$V3=="*"))/nrow(contents)
   
   #Determine physicochemical property % disordered
   hydrophilicAA <- c("R", "N", "D", "E", "Q", "K", "S", "T")
   modHydroAA <- c("C", "H", "M")
   hydrophobicAA <- c("A", "V", "G", "I", "L", "F", "P", "W", "Y")
   posChargeAA <- c("R", "K", "H")
   neutChargeAA <- c("N", "Q", "S", "T", "C", "M", "A", "V", "G", "I", "L", "F", "P", "W", "Y")
   negChargeAA <- c("D", "E")
   
   if(length(which(contents$V3=="*")) > 0){
   	perDisPhillic <- length(which((contents$V3=="*")&(contents$V2 %in% hydrophilicAA)))/ length(which((contents$V3=="*")))
   	perDisMod     <- length(which((contents$V3=="*")&(contents$V2 %in% modHydroAA)))   / length(which((contents$V3=="*")))
   	perDisPhobic  <- length(which((contents$V3=="*")&(contents$V2 %in% hydrophobicAA)))/ length(which((contents$V3=="*")))
   	perDisPos     <- length(which((contents$V3=="*")&(contents$V2 %in% posChargeAA)))  / length(which((contents$V3=="*")))
   	perDisNeg     <- length(which((contents$V3=="*")&(contents$V2 %in% negChargeAA)))  / length(which((contents$V3=="*")))
   	perDisNeut    <- length(which((contents$V3=="*")&(contents$V2 %in% neutChargeAA))) / length(which((contents$V3=="*")))
   } else {
   	perDisPhillic <- 0
   	perDisMod     <- 0
   	perDisPhobic  <- 0
   	perDisPos     <- 0
   	perDisNeg     <- 0
   	perDisNeut    <- 0
   }
   
   
   if(length(which(contents$V3!="*")) > 0){
   	perOrdPhillic <- length(which((contents$V3!="*")&(contents$V2 %in% hydrophilicAA)))/ length(which((contents$V3!="*")))
   	perOrdMod     <- length(which((contents$V3!="*")&(contents$V2 %in% modHydroAA)))   / length(which((contents$V3!="*")))
   	perOrdPhobic  <- length(which((contents$V3!="*")&(contents$V2 %in% hydrophobicAA)))/ length(which((contents$V3!="*")))
   	perOrdPos     <- length(which((contents$V3!="*")&(contents$V2 %in% posChargeAA)))  / length(which((contents$V3!="*")))
   	perOrdNeg     <- length(which((contents$V3!="*")&(contents$V2 %in% negChargeAA)))  / length(which((contents$V3!="*")))
   	perOrdNeut    <- length(which((contents$V3!="*")&(contents$V2 %in% neutChargeAA))) / length(which((contents$V3!="*")))
   } else {
   	perOrdPhillic <- 0
   	perOrdMod     <- 0
   	perOrdPhobic  <- 0
   	perOrdPos     <- 0
   	perOrdNeg     <- 0
   	perOrdNeut    <- 0
   }
   
   

   
   
   #Determine disordered quartiles
   quartileSize <- trunc(nrow(contents)/4)
   additional4 <- seq(1, ((nrow(contents)/4)-quartileSize)*4)
   
   range1 <- quartileSize + (if(1 %in% additional4){1}else{0})
   range2 <- range1 + quartileSize + (if(2 %in% additional4){1}else{0})
   range3 <- range2 + quartileSize + (if(3 %in% additional4){1}else{0})
   range4 <- range3 + quartileSize + (if(4 %in% additional4){1}else{0})
   
   q1 <- round(length(which(contents$V3[1:range1]=="*"))/(quartileSize + (if(1 %in% additional4){1}else{0})), digits=6)
   q2 <- round(length(which(contents$V3[(range1+1):range2]=="*"))/(quartileSize+(if(2 %in% additional4){1}else{0})), digits=6)
   q3 <- round(length(which(contents$V3[(range2+1):range3]=="*"))/(quartileSize+(if(3 %in% additional4){1}else{0})), digits=6)
   q4 <- round(length(which(contents$V3[(range3+1):range4]=="*"))/(quartileSize+(if(4 %in% additional4){1}else{0})), digits=6)
   
   #Determine disordered tenths
   tenthSize <- trunc(nrow(contents)/10)
   additional10 <- seq(1, ((nrow(contents)/10)-tenthSize)*10)
   
   ranget1 <- tenthSize + (if(1 %in% additional10){1}else{0})
   ranget2 <- ranget1 + tenthSize + (if(2 %in% additional10){1}else{0})
   ranget3 <- ranget2 + tenthSize + (if(3 %in% additional10){1}else{0})
   ranget4 <- ranget3 + tenthSize + (if(4 %in% additional10){1}else{0})
   ranget5 <- ranget4 + tenthSize + (if(5 %in% additional10){1}else{0})
   ranget6 <- ranget5 + tenthSize + (if(6 %in% additional10){1}else{0})
   ranget7 <- ranget6 + tenthSize + (if(7 %in% additional10){1}else{0})
   ranget8 <- ranget7 + tenthSize + (if(8 %in% additional10){1}else{0})
   ranget9 <- ranget8 + tenthSize + (if(9 %in% additional10){1}else{0})
   ranget10 <- ranget9 + tenthSize + (if(10 %in% additional10){1}else{0})
   
   t1 <- round(length(which(contents$V3[1:ranget1]=="*"))/(tenthSize + (if(1 %in% additional10){1}else{0})), digits=6)
   t2 <- round(length(which(contents$V3[(ranget1+1):ranget2]=="*"))/(tenthSize + (if(2 %in% additional10){1}else{0})), digits=6)
   t3 <- round(length(which(contents$V3[(ranget2+1):ranget3]=="*"))/(tenthSize + (if(3 %in% additional10){1}else{0})), digits=6)
   t4 <- round(length(which(contents$V3[(ranget3+1):ranget4]=="*"))/(tenthSize + (if(4 %in% additional10){1}else{0})), digits=6)
   t5 <- round(length(which(contents$V3[(ranget4+1):ranget5]=="*"))/(tenthSize + (if(5 %in% additional10){1}else{0})), digits=6)
   t6 <- round(length(which(contents$V3[(ranget5+1):ranget6]=="*"))/(tenthSize + (if(6 %in% additional10){1}else{0})), digits=6)
   t7 <- round(length(which(contents$V3[(ranget6+1):ranget7]=="*"))/(tenthSize + (if(7 %in% additional10){1}else{0})), digits=6)
   t8 <- round(length(which(contents$V3[(ranget7+1):ranget8]=="*"))/(tenthSize + (if(8 %in% additional10){1}else{0})), digits=6)
   t9 <- round(length(which(contents$V3[(ranget8+1):ranget9]=="*"))/(tenthSize + (if(9 %in% additional10){1}else{0})), digits=6)
   t10 <- round(length(which(contents$V3[(ranget9+1):ranget10]=="*"))/(tenthSize + (if(10 %in% additional10){1}else{0})), digits=6)
   
   
   tempDF <- data.frame(D1 = percentDisordered, 
   										 D2 = q1, 
   										 D3 = q2, 
   										 D4 = q3, 
   										 D5 = q4, 
   										 D6 = t1, 
   										 D7 = t2, 
   										 D8 = t3, 
   										 D9 = t4, 
   										 D10 = t5, 
   										 D11 = t6, 
   										 D12 = t7, 
   										 D13 = t8, 
   										 D14 = t9, 
   										 D15 = t10, 
   										 Disordered_phillic = perDisPhillic, 
   										 Disordered_Mod = perDisMod, 
   										 Disordered_phobic = perDisPhobic, 
   										 Disordered_Pos = perDisPos, 
   										 Disordered_Neg = perDisNeg, 
   										 Disordered_Neut = perDisNeut, 
   										 Ordered_phillic = perOrdPhillic, 
   										 Ordered_Mod = perOrdMod, 
   										 Ordered_phobic = perOrdPhobic, 
   										 Ordered_pos = perOrdPos, 
   										 Ordered_Neg = perOrdNeg, 
   										 Ordered_Neut = perOrdNeut, 
   										 stringsAsFactors = FALSE)
   
   return(tempDF)
}


