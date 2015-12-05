import csv
import os
import pdb

previous = None

def main():
	cwd = os.getcwd()
	cwd = os.path.join(cwd, 'source files')
	os.remove(os.path.join(cwd, 'names.csv'))
	for f in os.listdir(cwd):
		if f.endswith('.csv'):
			path = os.path.join(cwd,f)
			names = get_names(path)
			with open(os.path.join(cwd, 'names.csv'), 'a') as fw:
				fw.write(f + ",")
				fw.write(names)

def get_names(path):
	global previous
	print path
	with open(path, 'r') as f:
		return f.readline() 


main()