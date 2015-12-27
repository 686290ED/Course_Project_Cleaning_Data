This is the readme file to say how the scrip works.

For the first part, the script reads in the train and test data, merge them using merge function with parameters that like outer join,
joining all data from train and test data. 

For the second part, first reading features.txt to get the colnames of the table.
The features.txt has two columns, subset the second column with features and assign it to field. 
Assign field to colnames of the merged data got from the first step. 
Since field names contain duplicated ones which is not used after, subset the merged data and remove duplicated columns. 
Using grep function to generate index of column with name containing mean and std. Since there are meanFreq(), use mean() to 
match mean() variable. Use backslash to escape (). 
Use select function to select from the merged data the columns with index got above and assign to mean_std_data.

For the third part, first read in activity index for train and test data. 
Concatenate them into vector using unlist and c. 
Form the activity index into factor and label it with activity descriptive string. 
For subject part, read in subject for train and test data, concatenate using the same method as activity index. 
Add activity and subject as new variables to mean_std_data using mutate function from plyr package, assign
the data to mean_std_data_2. 

For the fourth part, using gsub function to globally replace string.
"t" for time and "f" for frequency appear at the start of the string, using ^ to restrict. 
Firstly run appears ..., add a line to replace ".". 

For the fifth part, using reshape2 package to summarize. 
First generate a factor variable activity_subject_f combining activity and subject using interaction function. 
Add the factor variable to mean_std_data_2 using mutate function. 
Using melt and dcast function from reshape2 package to melt and cast data. 
For melt function, choose mean and std variables as measure variables(which is the first 66 columns)
and activity and subject factors as id variables. 
At last assign activity_subject_f to rownames of activity_subject_mean data and remove the activity_subject_f column.

Lastly write the result data to file. 

