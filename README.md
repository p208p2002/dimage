# dockerfiles
### nlp-pytorch2.0.0-cuda11.7
NLP,LLM 開發環境

python, lightning, transformers, deepspeed, cuda-devel

#### 指令
```bash
docker build -f nlp-pytorch2.0.0-cuda11.7 -t dimage-cuda .
docker run --gpus all --restart=always -itd -p PORT:22 -e PASSWORD=PASSWORD dimage-cuda
ssh -p PORT dimage@HOST
```
