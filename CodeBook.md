Code Book: Please note this is an overview and code has been commented for ease and readability.
Step 1: set directory
Step 2: load data tables into the environment

Explanation of datasets:
	features = different measurements captured from accelerator and gyroscope
	activity = names of activities (sitting, standing, etc.)
	x,y test and train = recorded data that has been normalized

Step 3: merge datasets and take only mean and standard deviation
Step 4: clean column names
Step 5: create additional dataset with activity averages