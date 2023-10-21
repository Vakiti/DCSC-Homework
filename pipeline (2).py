#!/usr/bin/env python
# coding: utf-8

# In[9]:


#!pip install python
#!pip install pandas
#!pip install psycopg2-binary
get_ipython().system('pip install sqlalchemy')


# In[12]:


import pandas as pd
import psycopg2
from sqlalchemy import create_engine

# Define the database connection URL
db_url = "postgresql+psycopg2://srija:Tearsofblood@9@db:5432/shelter"

def extract_data(csv_url):
    # Load the CSV data from the URL into a DataFrame
    data = pd.read_csv(csv_url)
    return data

def transform_data(data):

    dict = {'Animal ID': 'animal_id',
            'Name': 'name',
            'DateTime': 'datetime', 
            'Date of Birth': 'dob',
            'Outcome Type': 'outcome_type',
            'Outcome Subtype': 'outcome_subtype',
            'Animal Type': 'animal_type',
            'Age upon Outcome': 'age_at_outcome',
            'Age upon Outcome': 'age_at_outcome',
            'Breed': 'breed',
            'Color' : 'color'
    }

    # call rename () method
    data.rename(columns=dict,
            inplace=True)
    # Replace missing values with "unknown"
    data = data.fillna("unknown")

    # Creating DataFrames for the "Animal," "Outcome," and "Relationship" tables
    animal_df = data[["animal_id", "name", "dob", "breed", "color", "animal_type"]]
    outcome_df = data[["datetime", "outcome_type", "outcome_subtype"]]
    relationship_df = data[["animal_id", "datetime"]]

    return animal_df, outcome_df, relationship_df

def load_data(engine, animal_df, outcome_df, relationship_df):
    # Insert data into the "Animal" table
    animal_df.to_sql("Animal", engine, if_exists="replace", index=False)

    # Insert data into the "Outcome" table
    outcome_df.to_sql("Outcome", engine, if_exists="replace", index=False)

    # Insert data into the "Relationship" table
    relationship_df.to_sql("Relationship", engine, if_exists="replace", index=False)

def main():
    # Load the CSV data from the URL
    csv_url = "https://s3.amazonaws.com/shelterdata/shelter1000.csv"
    data = extract_data(csv_url)

    # Establish a database connection
    engine = create_engine(db_url)

    # Transform the data
    animal_df, outcome_df, relationship_df = transform_data(data)

    # Load the data into the database
    load_data(engine, animal_df, outcome_df, relationship_df)

    print("ETL process completed.")

if __name__ == "__main__":
    main()

