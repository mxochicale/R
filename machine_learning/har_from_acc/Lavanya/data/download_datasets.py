
# SourceCode
# https://github.com/guillaume-chevalier/HAR-stacked-residual-bidir-LSTMs/tree/master/data

 ### Human Activity Recognition Using Smartphones Data Set
# https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones
# !wget "https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI HAR Dataset.zip"
# !wget "https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI HAR Dataset.names"
# !wget https://archive.ics.uci.edu/ml/machine-learning-databases/00226/OpportunityUCIDataset.zip

# import copy
import os
from subprocess import call

print("")

print("Downloading UCI HAR Dataset...")

#Change Path
DataSetDirectory = "/home/map479/mxochicale/github/DataSets/UCI_HAR"

if not os.path.exists(DataSetDirectory):
    os.makedirs(DataSetDirectory)
    os.chdir(DataSetDirectory)

    #Get dataset
    call(
        'wget "https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI HAR Dataset.zip"',
        shell=True
    )


    print("Downloading done.\n")
else:
    print("Dataset already downloaded to {}. Did not download twice\n".format(DataSetDirectory))



print("Extracting to {}.".format(DataSetDirectory))
os.chdir(DataSetDirectory)

extract_directory = os.path.abspath("UCI HAR Dataset")
if not os.path.exists(extract_directory):
    call(
        'unzip -nq "UCI HAR Dataset.zip"',
        shell=True
    )
    print("Extracting successfully done to {}.".format(extract_directory))
else:
    print("Dataset already extracted to {}. Did not extract twice\n".format(extract_directory))


    
