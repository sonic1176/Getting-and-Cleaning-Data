# Codebook for Assignment
##Variables and Data

**datasource** *(not represented in the output dataset)*  
Datatype: `Factor`  
The datasource distinguishes between the two areas of data. There is the *'Train Data'* and the *'Test Data'*.  

**activityID**  
Datatype: `integer`  
The activityID represents the number of one of the six captured activities.  
- 1 walking
- 2 walking upstairs
- 3 walking downstairs
- 4 sitting
- 5 standing
- 6 laying

**activityText**  
Datatype: `character`  
The activityText provides the Text of the six activities listed in activityID.  

**subjectID**  
Datatype: `integer`  
The subjectID is an integer between 1 and 30 represents one of the 30 volunteers which 
took part in the evaluated experiment.

**variable**  
Datatype: `Factor`  
The variable contains all calculatd measures for mean and standard deviation.

**value** *(not represented in the output dataset)*  
Datatype: `numeric`  
The value is a numeric value between -1 and 1.   

**meanValue**
Datatype: `double`  
The meanValue represents the mean of all values aggregated by subject, activity and variable.

##Transformations to clean data
To get from raw data to tidy data, the first step was to connect to pure data with the labels 
provided in the two label-files *activity_labels.txt* and *features.txt*. The next step was to 
bind the subjects and the actities for each observation with the observations itself.
Now having a complete table the task was just two keep the values for standard deviation and 
mean-values.  
This have to be executed two times to get the test data as well as the train data and to 
distinguish between the test and train data a column for the datasource keeps its source.   
In the end the two tables (test and train) were put together as one table.  
  
The submit of that data was reduced by dropping datasource and aggregate as mentioned in meanValue.
