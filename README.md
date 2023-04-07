# dimage
```bash
docker build -f 12.1.0-devel-ubuntu20.04-python -t dimage-cuda .
docker run -itd --rm -p PORT:22 -e PASSWORD=PASSWORD dimage-cuda
ssh -p PORT dimage@HOST
```