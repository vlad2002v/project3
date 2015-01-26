file:  README.md 

remove/delete all currently running objects in R 

set "working directory" ("WD")

CREATE FOLDER FOR DATA IN WORKING DIRECTORY

Download .zip file which contains the data

Extract the data from the .zip file

Review contents of the unziped data 

Read in the "activity_labels" file to get the label codes item

Read in the "features.txt" file to get the features item

Establish important features by creating index

Read in the files from "train" folder

Read in the files from "test" folder

Merge the "test" folder data = "df_test" object and the "train" folder data = "df_training" object 

Replace "labelcode" variable in "DataFrame" object with the text labels from "labels" object

Transform the dataset to use label and subject as identifiers

Produce the tidy dataset with means of each variable for each activitt and each subject 

produce CodeBook.md 

produce README.md 
