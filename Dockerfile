# docker build -t a:dev .
# docker run --rm -it -v $HOME/work/pytorch:/p a:dev /p/scripts/build_android.sh
FROM circleci/android:api-29-ndk

RUN sudo apt-get -qq update -y \
 && sudo apt-get -qq install -y python3-pip cmake

# The script/build_android.sh requires Python 3.  However, the CircleCI image
# contains /usr/bin/python as Python 2, whose importlib package doesn't have
# subpackage importlib.machinery required by build_android.sh.
RUN sudo cp /usr/bin/python3 /usr/bin/python

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -qq pyyaml typing

ENV ANDROID_NDK=/opt/android/android-ndk-r20
