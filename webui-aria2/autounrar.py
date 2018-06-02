#!/usr/bin/python3

import subprocess
import os
import json
import shutil

maxlevel = 1

def CheckRarComplete( path, file, associatedFiles ):
	plsar = subprocess.Popen(['lsar', '-j', os.path.join(path, file)], stdout=subprocess.PIPE)
	lsarout, lsarerr = plsar.communicate()
	
	jsonObject = json.loads(lsarout.decode("utf-8"))
	
	if 'lsarContents' in jsonObject:
		if (any(jsonObject['lsarContents'])):
			# Take the file with the more parts
			nbparts = 0
			for contents in jsonObject['lsarContents']:
				if 'XADSolidObject' in contents:
					if (any(contents['XADSolidObject'])):		
						if 'Parts' in contents['XADSolidObject'][0]:
							currentparts = len(contents['XADSolidObject'][0]['Parts'])
							if (currentparts > nbparts):
								nbparts = currentparts
			
			print(str(len(associatedFiles))+"/"+str(nbparts) + " ", end='')
			if (len(associatedFiles)==nbparts):	
				return True

	return False
	
def UnRar( path, handlefile, properfile, associatedFiles ):
	
	extractPath = os.path.join('./Extract', properfile)
	os.mkdir(extractPath)
	
	print("Extracting")
	
	#punar = subprocess.Popen(['unar', '-q', '-o', extractPath, os.path.join(path, handlefile)], stdout=subprocess.PIPE)
	punar = subprocess.Popen(['unrar', 'x', os.path.join(path, handlefile), extractPath], stdout=subprocess.PIPE)
	unarout, unarerr = punar.communicate()
	if punar.returncode == 0:
		
		print("Moving files")
		
		for filename in os.listdir(extractPath):
			shutil.move(os.path.join(extractPath, filename), os.path.join('./Ended', filename))
		
		os.rmdir(extractPath)
		
		print("Removing files")
		
		for file in associatedFiles:
			os.remove(path + "/" + file)
		
		if path != "./Downloads" and not any(os.listdir(path)):
			os.rmdir(path)
		
		return True
		
	else:
		print("Error")
		os.rmdir(extractPath)
		print(unarout)
		print(unarerr)
	
	return False
	
def CheckForRar( path, level ):

	print("Checking " + path)
	
	if any(os.listdir(path)):
	
		osListDir = [f for f in os.listdir(path) if os.path.isfile(os.path.join(path, f))]

		allcompressedfiles = [f for f in osListDir if f.endswith(".rar") ]
		compressedfiles = [f for f in allcompressedfiles if f.find('.part')==-1 or f.find('.part1')>-1 ]
		
		allariafiles = [f for f in osListDir if f.endswith(".aria2")]
		
		if any(compressedfiles):
			while any(compressedfiles):

				compressedfiles.sort()
				
				handlepos = -1
				handlefile = ""
				properfile = ""
				associatedFiles = []
				ariafiles = []
				
				# Part File
				for index, file in enumerate(compressedfiles):
					part1pos = file.find('.part1')
					properfile = file[:part1pos]
					if (part1pos > -1):
						ariafiles = [f for f in allariafiles if f.startswith(properfile)]
						if (len(ariafiles)==0):
							handlepos = index
							handlefile = file
							associatedFiles = [f for f in allcompressedfiles if f.startswith(properfile)]
							break
						else:
							print("Aria2 files! " + properfile)
				
				# Single RAR
				if handlepos == -1:
					for index, file in enumerate(compressedfiles):
						if file.find('.part')==-1:
							properfile = file[:-4]
							ariafiles = [f for f in allariafiles if f.startswith(properfile)]
							if (len(ariafiles)==0):
								handlepos = index
								handlefile = file
								associatedFiles = [ file ]
								break
							else:
								print("Aria2 files! " + properfile)
							

				if handlepos > -1:
					print("Candidate: " + handlefile + " ", end='')
					
					del compressedfiles[handlepos]
					
					if CheckRarComplete( path, handlefile, associatedFiles ):
						ures = UnRar( path, handlefile, properfile, associatedFiles )
						#ures = False
						#print "Unrar"
						if ures:
							raise SystemExit(0)
					else:
						print("Incomplete")
							
				else:
					break
					
		print("----")
		
		if (level < maxlevel) :
			level += 1
			directories = [f for f in os.listdir(path) if os.path.isdir(os.path.join(path, f))]
			for directory in directories:
				CheckForRar(os.path.join(path, directory), level)
	
	else:
		if path != "./Downloads" and not any(os.listdir(path)):
			os.rmdir(path)
	
	return 
	

	
mypath = "./Downloads"

CheckForRar (mypath, 0)
