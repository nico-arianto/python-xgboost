FROM python:2.7-slim

LABEL maintainer "Nico Arianto <nico.arianto@gmail.com>"

ENV XGB_HOME /home
ENV PYTHONPATH=$XGB_HOME/xgboost/python-package

RUN apt update && \

    # Installing debian packages
    apt install -y git make g++ libssl-dev libffi-dev && \

    # xgboost setup
    cd $XGB_HOME && \
    git clone --recursive https://github.com/dmlc/xgboost && \
    cd $XGB_HOME/xgboost && \
    make -j4 && \
    cd $XGB_HOME/xgboost/python-package && \
    pip install scipy scikit-learn matplotlib && \
    python setup.py install && \

    # Cleaning deb packages
    apt remove -y git make g++ libssl-dev libffi-dev && \
    apt-get autoremove -y && \
    apt install -y libgomp1 libtk8.6

WORKDIR $XGB_HOME
