# 作业

## 背景
1. ollama 在 windows 中执行 (wsl 内存不足以加载这么大的模型)
```
1. 在 Windows 设置 Ollama 监听所有网卡 【永久生效】
 在 Windows PowerShell 执行：

setx OLLAMA_HOST "0.0.0.0:11434"

2. 在 WSL 验证连通 : 能返回 HTTP/1.1 200 OK 才算通。
curl -I http://172.20.32.1:11434
```

2. 脚本
run_assignment.sh 是执行 python 作业的脚本，如下

```shell
./run_assignment.sh week1/k_shot_prompting.py
```

3. 参考
[学习笔记] (https://zhuanlan.zhihu.com/c_1982583296274744891)

