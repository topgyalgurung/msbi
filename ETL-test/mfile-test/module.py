import csv
import shutil
import os
from os import path

sourcepath=''
destination=''
archive=''
filename=''

with open(filename) as csvfile:
    readcsv=csv.reader(csvfile,delimiter=',')
    header=next(readcsv)
    # check if filename is empty
    if len(header)!=0:
        for row in readcsv:
            if(len(row))>=1:
                # get file with full path
                files=sourcepath+' '.join(map(str,row))
                print(files)
                # check if file name given in csv file is present in source folder
                if path.exists(files):
                    print('The file is in source folder: '+sourcepath)
                    # check if file is in csv and file present in dest ==> do not move to target
                    n==len(row)
                    # if file extension is not csv move to archive
                    if(file.split(".")[-1] in ['csv','CSV']) and (any(row==os.listdir(destination)[i:i]+n] for i in range(len(os.listdir(destination))-n+1))):
                        print('File {0} is not moved as it is present in target {1}.'.format(files,target))
                    elif(files.split(".")[-1] in ['csv','CSV']):
                        print('File {} moving to destination'.format(files))
                        shutil.move(files,destination)
                        print(files)
                    else:
                        try:
                            if(files.split(".")[-1] not in 'csv'):
                                shutil.move(files,archive)
                        except:
                            print('files {} is present in archive destination'.format(files));
                else:
                    print('The given file does not exist in the source folder')
    else:
        print('The csv file containing file list {} is empty'.format(filename))    