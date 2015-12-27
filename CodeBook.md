data:
activity_subject_mean: table cast from data_melt, generate mean of measure variables
activity_test: table read from y_test.txt
activity_train: table read from y_train.txt
all_data: table merged from train and test
all_data_rd: table all_data removed duplicated columns
data_melt: table melt mean_std_data_3 with id variables being subject, activity and activity_subject_f
		   measure variables being mean and std variables
features: table read from features.txt
mean_std_data: table selected from table all_data_rd by mean_std_field
mean_std_data_2: table from adding variables of activity factor and subject factor to mean_std_data
mean_std_data_3: table from adding activity_subject_f factor to mean_std_data_2
subject_test: table read from subject_test.txt
subject_train: table read from subject_train.txt
test: table read from X_test.txt
train: table read from X_train.txt
		   
variable：
activities: vector containing activity descriptive string
activity_subject_f: factor combine activity factor and subject factor
all_activity: vector concatenate activity index from activity_train and activity_test
all_activity_f: factor of all_activity with label being the activity descriptive string
all_subject: vector concatenate subject index from subject_train and subject_test
field: factor contain all the field string
mean_std_field: index of columns of table all_data_rd which contains mean and std in the column name

transformations:
1.Merge X_train.txt and X_test.txt
2.Add features to column names of the merged data.
3.Select only columns with mean and std. 
4.Add columns of activity factor and subject factor.
5.Rename column names into more descriptive.
6.Add column of factor combined activity and subject.
7.Melt the table with measure variables being mean and std variables.
8.Cast the table generate means of variables grouped by activity_subject_f.
9.Assign row names of the table with acitivity_subject_f factor and remove the column of activity_subject_f.
10.Write result table to file.