# DCSC-Homework

"CSV Data Processing Python Script with Dockerization"

This repository contains a Python script designed to streamline CSV data manipulation. The script accepts two command-line arguments: the first argument specifies the source CSV file, and the second argument defines the destination for the processed data. The script processes the data in a customizable manner.

Additionally, this repository includes a Dockerfile configured to:

1. Pull a Python Docker image.
2. Copy the Python script into the container.
3. Automatically execute the Python script upon container initialization, ensuring seamless and reproducible data processing in a containerized environment.
