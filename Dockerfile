FROM python:3.8

WORKDIR /app
COPY pipeline.py pipeline_c.py
RUN pip install pandas
RUN pip install argparse
ENTRYPOINT ["bash"]