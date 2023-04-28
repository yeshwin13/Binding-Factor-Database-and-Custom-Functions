
ImportDB <- function(file){
  # Load the XML package
  library(XML)

  # Set the file name
  file_path <- file

  # Read in the XML file
  xml_data <- xmlTreeParse(file_path)

  # Get the root node of the XML tree
  root_node <- xmlRoot(xml_data)

  # Extract the data from the XML tree and store it in a list
  xml_list <- xmlToList(root_node)

  # Convert the list to a dataframe
  # Might require an improvement in the future
  df <- as.data.frame(t(sapply(xml_list, unlist)), stringsAsFactors = FALSE)

  bf <- df[1]
  bf2 <- bf[1,1]
  #bf2
  bf_df <- data.frame(t(as.data.frame(bf2)))

  pfm <- df[2]
  pfm2 <- pfm[1,1]
  pfmatrix <- matrix(unlist(pfm2), nrow = 4, byrow = TRUE)
  
  #Passing the values of the dataframe to individual variables
  bfname = bf_df$Binding_Factor
  pstring = bf_df$Pattern_String
  plength = bf_df$Pattern_Length
  prolayers = bf_df$Profile_Layers
  promarks = bf_df$Profile_Marks
  modlayers = bf_df$Mod_Layers
  modmarks = bf_df$Mod_Marks
  width = bf_df$stateWidth
  minmis = bf_df$MinMismatch
  maxmis = bf_df$MaxMismatch
  
  #Adding all the variables to a list and returning it, since R can return only one object
  #User can retrieve individual variables from the list as seen below
  bf_args = list(bfname,pstring,plength,prolayers,promarks,modlayers,
                 modmarks,width,minmis,maxmis)
  return(bf_args)
}  

#Below section of the code is a work in progress. Since createbindingfactor function has optional
#variables, it might be more efficient to implement this within its function definition, rather
#than defining it outside

#Returning the list of variables
infoBf <- importDB()

#Selecting only the pattern string from the list
infoBf[2]

#Here we define a function to check the pattern string and pass it onto createBindingFactor function
#Left incomplete.

passDB <- function(infoBf){
  patstring <- infoBf[2]
  pattern <- "/|:|\\?|<|>|\\|\\\\|\\*,."
  
  
  checkspec <- grepl(pattern, patstring)
  
  #Check for regex patterns
  if(checkspec = TRUE){
    thisBf <- createBindingFactor.DNA_regexp("Name", patternString=,
                                             patternLength=, profile.layers=,
                                             profile.marks=, mod.layers =, 
                                             mod.marks=, stateWidth=, min.mismatch=, max.mismatch=)
    
  }
  #Check for the absence of regex patterns
  else if(checkspec = FALSE & patsring != "NA"){
    thisBf <- createBindingFactor.DNA_motif("Name", patternString=,
                                             patternLength=, profile.layers=,
                                               profile.marks=, mod.layers =, 
                                             mod.marks=, stateWidth=, min.mismatch=, max.mismatch=)
    
  }
  #Check for the absence of pattern string itself
  else if(patsring = "NA"){
    thisBf <- createBindingFactor.layer_region("Name", patternString=,
                                            patternLength=, profile.layers=,
                                            profile.marks=, mod.layers =, 
                                            mod.marks=, stateWidth=, min.mismatch=, max.mismatch=)
    
  }
}  
