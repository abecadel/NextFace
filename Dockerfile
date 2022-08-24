FROM nvidia/cuda:11.7.0-devel-ubuntu18.04
WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt-get update
RUN apt-get install -y wget git libgl1 libglib2.0-0 ffmpeg build-essential curl libtbb-dev

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda update -n base -c defaults conda -y
RUN conda init
RUN conda create --name faceNext python=3.6

SHELL ["conda", "run", "-n", "faceNext", "/bin/bash", "-c"]

RUN conda install -y mamba -n base -c conda-forge
RUN mamba install -y opencv -c conda-forge
RUN mamba install -y pytorch==1.3.1 torchvision torchaudio cudatoolkit=11.6 -c pytorch -c conda-forge

RUN pip install tensorflow mediapipe face_alignment==1.2.0 h5py pybind11 scikit-image jupyter

RUN git clone --recursive https://github.com/abecadel/redner.git
RUN wget https://github.com/Kitware/CMake/releases/download/v3.24.1/cmake-3.24.1-linux-x86_64.sh
RUN bash cmake-3.24.1-linux-x86_64.sh --skip-license --prefix=/usr/local
RUN cd redner && python setup.py install

#RUN git clone --recursive https://github.com/abecadel/NextFace.git
#RUN cd NextFace && python optimizer.py

