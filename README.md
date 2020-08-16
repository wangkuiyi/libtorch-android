# Build and Release libtorch for Android

This project shows how to build libtorch for Android.

PyTorch team releases [PyTorch Mobile](https://pytorch.org/mobile/home/)
packages, which can be installed using Graddle and CocoaPods.  These packages
includes the `.so` files of libtorch.  However, as we are going to try build
GoTorch, we are not going to use Gradle or CocoaPods; instead, the gomobile tool
prefers `libtorch.tar.gz` as those can be downloaded from
https://pytorch.org/get-started/locally.

This project uses a Docker image of Android SDK and NDK to build libtorch for
Android.  The base image is the one used by CircleCI.  The included Dockerfile
selects Python 3 as the default version and install required packages.  To
choose a different version of Android SDK or NDK, please change the base image.

## Build the Docker Image

```bash
docker build -t a:dev .
```

## Get libtorch Source Code

We can clone the source code in any directory, say, `$HOME/work`.

```bash
cd $HOME/work
git clone --recursive https://github.com/pytorch/pytorch
``

and select the version we are to build.

```bash
cd pytorch
git checkout v1.6.0
```

## Build libtorch for Android

To build libtorch for Android, we run the `build_android.sh` script provided by
PyTorch mobile team in the Docker container.

```bash
docker run --rm -it -v $HOME/work/pytorch:/p a:dev /p/scripts/build_android.sh
```

## Zip the Binary

After the building, we will see a directory
`$HOME/work/pytorch/build_android/install`, this is what we need to pack.

```bash
cd $HOME/work/pytorch/build_android/
mv install libtorch
zip libtorch-android-1.6.0.zip -r libtorch
```
