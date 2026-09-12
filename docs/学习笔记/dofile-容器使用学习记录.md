---
type: note
tags:
  - Dofile
  - Docker
  - Scan-Insertion
source_type: 聊天整理
date: 2026-09-11
status: active
---

# Dofile 容器使用学习记录

本文记录本次侧聊天中关于官方 Docker 容器、Dofile 和容器内文件读取的问答。

## 1. 容器是什么

容器可以理解成一个已经安装好 Linux、`dftexp_scan`、Yosys 和工具手册的独立实验环境。Windows 主机上的项目文件通过 Docker 挂载映射到容器内部。

## 2. 启动官方容器

先确认 Docker 镜像存在：

```powershell
docker images scan-agent-base
```

如果没有镜像，需要先加载官方提供的 `.tar` 文件：

```powershell
docker load -i "你的镜像文件路径\scan-agent-base-ubuntu24.tar"
```

以 `task_2/case1` 为例启动容器：

```powershell
docker run --rm -it `
  --entrypoint bash `
  -v "D:\research\2026-NCTIEDA-Semitronix\官方材料\public_cases\task_2\case1\input:/input:ro" `
  -v "D:\research\2026-NCTIEDA-Semitronix\temp\dofile-learning\case1:/output:rw" `
  scan-agent-base:ubuntu24
```

看到类似下面的提示，说明已经进入容器：

```text
root@xxxx:/#
```

参数含义：

| 参数 | 含义 |
|---|---|
| `--rm` | 容器退出后自动删除临时容器 |
| `-it` | 进入交互式终端 |
| `--entrypoint bash` | 启动 Bash，方便手工执行命令 |
| `/input:ro` | 输入目录只读挂载，防止修改官方材料 |
| `/output:rw` | 输出目录可写，结果保存回 Windows |

## 3. Windows 与容器路径对应关系

| Windows 主机路径 | 容器内部路径 |
|---|---|
| `...\case1\input` | `/input` |
| `...\temp\dofile-learning\case1` | `/output` |
| 无对应主机路径 | `/opt/dftexp_scan` |

工具手册在容器内：

```text
/opt/dftexp_scan/doc/Scan_User_Manual.pdf
```

## 4. 读取容器里的文件

进入容器后，文件要使用 Linux 路径。

读取 Dofile：

```bash
cat /input/golden.dofile
```

内容较长时使用分页查看：

```bash
less /input/golden.dofile
```

按 `q` 退出 `less`。

显示行号：

```bash
nl -ba /input/golden.dofile
```

只看前 50 行：

```bash
head -n 50 /input/golden.dofile
```

搜索命令及其行号：

```bash
grep -n "set_scan_signal" /input/golden.dofile
```

查看目录：

```bash
ls -lah /input
find /output -type f
```

查看日志：

```bash
cat /output/golden.log
tail -f /output/golden.log
```

按 `Ctrl+C` 停止 `tail -f`。

## 5. 读取工具手册

如果容器中有 `pdftotext`，可以把 PDF 转成文本：

```bash
pdftotext \
  /opt/dftexp_scan/doc/Scan_User_Manual.pdf \
  /output/Scan_User_Manual.txt
```

然后阅读：

```bash
less /output/Scan_User_Manual.txt
```

如果 `pdftotext` 不存在，可以先把 PDF 复制到挂载输出目录：

```bash
cp /opt/dftexp_scan/doc/Scan_User_Manual.pdf /output/
```

退出容器后，在 Windows 目录中打开：

```text
D:\research\2026-NCTIEDA-Semitronix\temp\dofile-learning\case1
```

## 6. 执行 Dofile

查看工具版本：

```bash
dftexp_scan -version
```

运行官方黄金脚本并保存日志：

```bash
dftexp_scan -f /input/golden.dofile 2>&1 | tee /output/golden.log
```

运行结束后，日志和工具生成的文件会保存在 Windows 的：

```text
D:\research\2026-NCTIEDA-Semitronix\temp\dofile-learning\case1
```

退出容器：

```bash
exit
```

`--rm` 只删除临时容器，不删除挂载到 `/output` 的结果。容器内部未挂载的临时文件，例如 `/tmp` 中的文件，在退出后不会保留。

## 7. 最小操作顺序

```text
启动 Docker Desktop
  → 检查镜像
  → 启动容器并挂载 input/output
  → 在容器内使用 /input 和 /output
  → 执行 dftexp_scan
  → 在 Windows 的 output 目录查看结果
  → exit 退出容器
```

## 参考资料

- [项目 Docker 使用指南](../../docs/Docker使用指南.md)
- [官方 task_2/case1 黄金 Dofile](../../官方材料/public_cases/task_2/case1/input/golden.dofile)
