
library(XML)

# define a function to prompt the user for input and add it to the dataframe
ExportDB <- function() {
  library(XML)
  my_df = data.frame(Binding_Factor=character(), Description=character(), Author=character(), 
             Date_of_Creation=character(), Version=character(), Reference=character(), 
             Pattern_String=character(), Pattern_Length=character(), 
             Profile_Layers=character(), Profile_marks=character(),
             Mod_Layers=character(), Mod_Marks=character(), stateWidth=character(),
             MinMismatch=character(), MaxMismatch=character())
  
  # get data from user
  Bf <- readline("Enter Binding Factor Name: ")
  
  file_name <- paste0(Bf, ".xml")
  if (file.exists(file_name)) {
    message(paste0("File '", file_name, "' already exists"))
  } 
  else {
    Desc <- readline("Enter a short description of the Binding Factor: ")
    Auth <- readline("Author: ")
    Date <- readline("Date of Creation: ")
    Ver <- readline("Enter Version: ")
    Ref <- readline("Enter Reference: ")
    pattern_string <- readline("Enter pattern_string: ")
    pattern_length <- readline("Enter Pattern Length: ")
    profile_layers <- readline("Enter Profile Layers: ")
    profile_marks <- readline("Enter Profile Layer Marks: ")
    mod_layers <- readline("Enter Modification Layers: ")
    mod_marks <- readline("Enter Modification Layer Marks: ")
    state_width <- readline("Enter State Width: ")
    MinM <- readline("Enter minimum permissible mismatches: ")
    MaxM <- readline("Enter maximum permissible mismatches: ") 
    
    # add data to dataframe
    my_df <- rbind(my_df, data.frame(Binding_Factor=Bf, Description=Desc, Author=Auth, 
                                     Date_of_Creation=Date, Version=Ver, Reference=Ref, 
                                     Pattern_String=pattern_string, Pattern_Length=pattern_length, 
                                     Profile_Layers=profile_layers, Profile_marks=profile_marks,
                                     Mod_Layers=mod_layers, Mod_Marks=mod_marks, stateWidth=state_width,
                                     MinMismatch=MinM, MaxMismatch=MaxM))
    
    doc <- newXMLDoc()
    root <- newXMLNode("database", doc = doc)
    for (i in 1:nrow(my_df)) {
      row <- newXMLNode("bf", parent = root)
      for (j in 1:ncol(my_df)) {
        newXMLNode(colnames(my_df)[j], as.character(my_df[i, j]), parent = row)
      }
    }
    
    # Save the XML document to a file
    saveXML(doc, file = file_name)    
  }
  

}

# prompt user for input and add it to dataframe
ExportDB()