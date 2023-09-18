#!/usr/bin/env python
# coding: utf-8

#import pandas library
import pandas as pd
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument('source',help='source.csv')
parser.add_argument('target', help='target.csv')
args = parser.parse_args()

#import dataset from computer
main_dataset=pd.read_csv("C:\\Users\\vakit\\OneDrive\\Desktop\\basic_income_dataset_dalia.csv")

#save first 100 rows into our dataset
my_dataset = main_dataset.head(100)

#display our dataset
my_dataset

#count missing values in each column
my_missing = my_dataset.isna().sum()
my_missing  #9 missing in 'dem_education_level'


my_dataset=my_dataset.dropna()


#count duplicate values in each column
my_dataset.duplicated().sum() #no duplicates 




my_dataset=my_dataset.drop('uuid', axis=1)


my_dataset



#saving and exporting dataframe to csv 
my_dataset.to_csv(args.target, index=False)

