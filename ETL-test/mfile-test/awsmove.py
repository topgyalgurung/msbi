import  boto3

def mainlocal(debug=True):
    fileLoc=__file__ # get path for the executed script

    homeDir='/'.join(fileLoc.split('/')[:-2])

    srcDir=join(homeDir,'src')         #path to src folder
    dstDir=join(homeDir,'dst')         #path to dst folder
    arcDir=join(homeDir,'arc')         #path to arc folder
    logDir=join(homeDir,'log')         #path to log folder
    binDir=join(homeDir,'bin')         #path to bin folder
    tmpDir=join(homeDir,'tmp')         #path to tmp folder

if debug==True:
    print('Home directory \t\t:{}'.format(homeDir))

files=[file for file in os.listdir(srcDir)]
if '.fooling_git'in files:
    files.remove('.fooling_git')
elif '.gitignore' in files:
    files.remove('.gitignore')

with open(join(tmpDir,'input.txt'),'r') as inputFile:
    input=[line.rstrip() for line in inputFile] # rstrip remove \n and rest read lines to 

dstFiles=0  # counter of files to be moved to the dst folder
arcFiles=0
srcFiles=0

for file in files:
    if file in input:
        flag=os.path.exists(join(arcDir,file))
        if os.path.exists(join(dstDir,file)):
            srcFiles+=1
            if debug:
                print("Files {} exists in the destination".format(file))
                print("file not moved")
            else:
                dstFiles+=1
                if debug:
                    print("Files {} moved to {}".format(file,dstDir))
                os.rename(join(srcDir, file).join(dstDir,file))
    
    else:
        flag=os.path.exists(join(arcDir,file))
        if os.path.exists(join(arcDir,file)):
            srcFiles+=1
            if debug:
                print("Files {} exists in the destination".format(file))
                print("file not moved")
            else:
                arcFiles+=1
                if debug:
                    print("Archiving {}file not present in input {}".format(file,dstDir))
 
def mainAws(debug=True):
    s3=boto3.resource('s3')

    bucket=s3.Bucket('practice-movefolder')

    for obj in bucket.objects.all():
        path, filename =os.path.split(obj.key)
        print(path,filename)

def main(debug,filesys):
    if filesys.lower()=='local':
        mainlocal(debug)
    elif filesys.lower()=='aws':
        mainAws(debug)

main(debug=True, filesys='local')
#main(debug=True, fileSys='aws')
