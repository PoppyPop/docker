#!/usr/bin/python2

import subprocess
import os
import json
import shutil

maxlevel = 1;


def CheckForRar( path, level ):

    compressedfiles = [f for f in os.listdir(path) if os.path.isfile(os.path.join(path, f)) and f.endswith(".rar")]
    
    ariafiles = [f for f in os.listdir(path) if os.path.isfile(os.path.join(path, f)) and f.endswith(".aria2")]
    
    directories = [f for f in os.listdir(path) if os.path.isdir(os.path.join(path, f))]

    if (any(compressedfiles) and not any(ariafiles)):
        compressedfiles.sort();
        
        print path;
        print compressedfiles[0];
        
        plsar = subprocess.Popen(['lsar', '-j', os.path.join(path, compressedfiles[0])], stdout=subprocess.PIPE);
        lsarout, lsarerr = plsar.communicate();
        
        jsonObject = json.loads(lsarout);
        
        if 'lsarContents' in jsonObject:
            if (any(jsonObject['lsarContents'])):
                # Take the file with the more parts
                nbparts = 0;
                for contents in jsonObject['lsarContents']:
                    if 'XADSolidObject' in contents:
                        if (any(contents['XADSolidObject'])):        
                            if 'Parts' in contents['XADSolidObject'][0]:
                                currentparts = len(contents['XADSolidObject'][0]['Parts']);
                                if (currentparts > nbparts):
                                    nbparts = currentparts;
                        
                if (len(compressedfiles)==nbparts):
                    print "Extracting";
                    
                    extractPath = os.path.join('./Extract', compressedfiles[0]);
                    
                    punar = subprocess.Popen(['unar', '-q', '-o', extractPath, os.path.join(path, compressedfiles[0])], stdout=subprocess.PIPE);
                    unarout, unarerr = punar.communicate();
                    if punar.returncode == 0:
                        
                        print "Moving files";
                        
                        for filename in os.listdir(extractPath):
                            shutil.move(os.path.join(extractPath, filename), os.path.join('./Ended', filename));
                        
                        os.rmdir(extractPath);
                        
                        print "Removing files";
                        
                        for file in compressedfiles:
                            os.remove(path + "/" + file);
                            
                        os.rmdir(path);
                        
                        raise SystemExit(0);
                    else:
                    	print "Error";
                    	os.rmdir(extractPath);
                        print unarout;
                        
        print "----"  

    if (level < maxlevel) :
        level += 1;
        for directory in directories:
            CheckForRar(os.path.join(path, directory), level);
    
    return;  

mypath = "./Downloads";

CheckForRar (mypath, 0);

#for path, dirs, files in os.walk(mypath):
    #CheckForRar(path, dirs, files);
             
             
             
           

# TODO later
# Simple command
# subprocess.Popen(['ls', '-1'], stdout=subprocess.PIPE)