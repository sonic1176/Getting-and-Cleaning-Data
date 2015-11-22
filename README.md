## Getting-and-Cleaning-Data
### Assignment for Coursera Course
### Description for tidying and reshaping data  

### Prerequisites
- Copy/download the complete folder provided by this Course Assignment to the working directory
- Download run_analysis.R to working directory and run it.

### Steps which will be executed are described as follows:

#### 1. Load relevant labels from csv-Files for activities and features
- Read files with relevant labels (*activity_labels.txt* and *features.txt*)
- Set selfexplaning headers
- Substitute underscore against blank and rename verbs to lower case in activities  

#### 2. Load test datasets for allocation of activity type and subject
- Read files with activities and subjects for each observation (*y_test.txt* and *subject_test.txt*)
- Merge labels of activity to ID of activity
- Set selfexplaning headers
 
#### 3. Load test data, name them and keep only relevant columns
- Read calculated data (*x_test.txt*)
- Set headers with already loaded labels from features.txt
- Keep only columns with headers containing 'mean()' or 'std()'

#### 4. Merge tables to a complete table for Test Data
- Create a new column identifies test data
- Append activity, subject and test data

#### 5. Repeat steps 2, 3 and 4 with train data

#### 6. Concat datasets
- Set rows from both complete tables below each other

#### 7. Reshape data
- Keep headers 1 to 4 and throw the observations to rows

#### 8. Aggregate data
- Calculate the mean value grouped by variable, activity and subject

#### 9. Write to file
- Write a file *output.txt* to the working directory
