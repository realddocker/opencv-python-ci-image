# A Ubuntu 16.04 image with opencv.
FROM        ubuntu:16.04
MAINTAINER  realddocker


run     apt-get update

# clang and cppcheck have been added perform code quality checks.
RUN apt-get update && \
        apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libavformat-dev \
        libpq-dev \
        clang \
        swig \
	python-dev \
	python-tk \
	python-numpy \
	python3-dev \
	python3-tk \
	python3-numpy \
        cppcheck
	
# Install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
	python get-pip.py && \
	rm get-pip.py

# Install useful Python packages using apt-get to avoid version incompatibilities with Tensorflow binary
# especially numpy, scipy, skimage and sklearn (see https://github.com/tensorflow/tensorflow/issues/2034)
RUN apt-get update && apt-get install -y \
		python-numpy \
		python-scipy \
		python-nose \
		python-h5py \
		python-skimage \
		python-matplotlib \
		python-pandas \
		python-sklearn \
		python-sympy \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

# Install other useful Python packages using pip
RUN pip --no-cache-dir install --upgrade ipython && \
	pip --no-cache-dir install \
		Cython \
		ipykernel \
		jupyter \
		path.py \
		Pillow \
		pygments \
		six \
		sphinx \
		wheel \
		zmq \
		&& \
	python -m ipykernel.kernelspec

run     apt-get install -y -q libavformat-dev libavcodec-dev libavfilter-dev libswscale-dev
run     apt-get install -y -q libjpeg-dev libpng-dev libtiff-dev libjasper-dev zlib1g-dev libopenexr-dev libeigen3-dev libtbb-dev
run wget -q https://github.com/opencv/opencv/archive/3.3.1.zip
run unzip -q 3.3.1.zip
run mkdir opencvbuild
run cd opencvbuild && cmake ../opencv-3.3.1/
run cd opencvbuild && make
