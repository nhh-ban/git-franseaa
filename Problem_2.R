#Problem 2

# The answers to this file is based on galaxy_skeleton2.R

library(tidyverse)

#Reading data
raw_file <- readLines(con = "suites_dw_Table1.txt")

substr(x = raw_file, start = 0, stop = 2)

#Identifying where "--" starts
L <- 
  (substr(x = raw_file, start = 14, stop = 15) == "--") %>% 
  which() %>% 
  min()

#Saving the variable information 
cat(raw_file[1:(L-2)], sep = "\n", file = "Variable_Description.txt")

#Storing the variable names
variable_names <- c(raw_file[13])

#Splitting the vector so that the variable names does not containt "|"
variable_names <- 
  str_split(string = variable_names, pattern = "\\|") %>% 
  unlist() %>% 
  str_trim()


#Splitting the values in raw_file by the comma. 
comma_separated_values <- 
  raw_file[15:810] %>% 
  gsub("\\|", ",", .) %>% 
  gsub(" ", "", .)

#Combining the variable names and comma_separated_values
comma_separated_values_with_names <- 
  c(paste(variable_names, collapse = ","),
    comma_separated_values)    

#Saving the data as a csv
cat(comma_separated_values_with_names, sep = "\n", file = "galaxy_data.csv")

#Reading back the file created above
galaxies <- read_csv("galaxy_data.csv")

galaxies


##Problem 3

#Creating a plot to look at why the smaller obects are underrepresented. 
galaxy_plot <- ggplot(galaxies, aes(x = log(a_26))) + 
  geom_histogram()
galaxy_plot

#The documentation provided in GitHub of the data, tells that the variable
# a_26 is the diameter of the respective galaxy. Using the log() function 
# to transform the data so it will be easier to plot using the histogram. 
#The plot (galaxy_plot) shows that the normal distribution of the size of the
# galaxies are leaning heavily to the right, where the right hand side
# of the mean is a lot steeper than the left hand side of the mean. 
#This is without knowledge of the real mean, assuming that the mean in the data
# is equal to the true mean. 
#This shows that there may be an underrepresentation of the smaller galaxies
# in the dataset. Without a lot of knowledge of astronomy, a explanation for 
# the underrepresentation could be that smaller galaxies provides less light
# for the telescopes to pick up. 
