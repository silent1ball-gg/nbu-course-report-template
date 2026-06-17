# Course Paper Template

这是一个课程论文 LaTeX 模板。结构设计原则是：`main.tex` 只组织全文，导言区配置拆分到 `config/`，论文信息放在 `info.tex`，正文按章节拆分到 `sections/`。

## 目录结构

```text
course-paper-template/
├── main.tex
├── info.tex
├── references.bib
├── README.md
├── config/
│   ├── packages.tex
│   ├── format.tex
│   └── titlepage.tex
├── sections/
├── figures/
├── tables/
├── code/
└── build/
```

## 快速使用

1. 修改 `info.tex` 中的题目、姓名、课程、学号等信息。
2. 在 `sections/` 中写正文。
3. 把最终要插入论文的图片放到 `figures/final/`。
4. 把原始图片、截图或实验输出放到 `figures/raw/`。
5. 较大的表格可以单独放在 `tables/`，再用 `\input{tables/parameters}` 插入。
6. 参考文献写入 `references.bib`，正文中使用 `\cite{...}` 引用。

## 导言区结构

- `config/packages.tex`：只放宏包。
- `config/format.tex`：页面格式、标题格式、行距、参考文献和常用命令。
- `config/titlepage.tex`：封面样式和 `\makecoursetitle` 命令。

## 编译

### 在 VSCode 中编译

推荐使用 VSCode + LaTeX Workshop：

1. 用 VSCode 打开 `course-paper-template/` 文件夹。
2. 安装扩展 `LaTeX Workshop`。
3. 打开 `main.tex`。
4. 点击左侧 TeX 图标，选择 `Build LaTeX project`。
5. 默认 recipe 是 `latexmk (xelatex + biber)`，生成的 PDF 在 `build/main.pdf`。

模板已经包含 `.vscode/settings.json`，会自动使用 XeLaTeX，并在需要时调用 Biber 处理参考文献。

也可以在 VSCode 中按 `Ctrl+Shift+B`，运行默认任务 `Build LaTeX paper`。

### 使用 Makefile

模板内置了 Makefile，提供以下常用命令（在项目根目录下运行）：

| 命令 | 说明 |
|------|------|
| `make` 或 `make build` | 编译生成 PDF |
| `make clean` | 删除中间文件，保留 PDF |
| `make distclean` | 彻底清理所有生成文件（包括 PDF） |
| `make view` | 打开生成的 PDF |
| `make watch` | 持续监听模式，源文件变化后自动重新编译 |
| `make fresh` | 彻底清理后重新编译（`distclean` + `build`） |

> **Windows 用户注意**：系统不自带 `make` 命令。可以用以下两种方式之一：
>
> **方式一：安装 make**
> ```powershell
> # 用 Chocolatey
> choco install make
> # 或用 Scoop
> scoop install make
> ```
>
> **方式二：不用 make，直接用 `latexmk`（等价命令对照）**
>
> | make 命令 | 等价 latexmk / PowerShell 命令 |
> |-----------|-------------------------------|
> | `make build` | `latexmk -cd -xelatex -outdir=build main.tex` |
> | `make clean` | `latexmk -c -outdir=build main.tex` |
> | `make distclean` | `latexmk -C -outdir=build main.tex` |
> | `make view` | `start "" "build\main.pdf"` |
> | `make watch` | `latexmk -pvc -cd -xelatex -outdir=build main.tex` |
> | `make fresh` | `latexmk -C -outdir=build main.tex` 再 `latexmk -cd -xelatex -outdir=build main.tex` |

Makefile 使用 `latexmk` + XeLaTeX，编译产物输出到 `build/` 目录。

### 直接使用 latexmk

```powershell
latexmk -cd -xelatex -outdir=build main.tex
```

如果没有 `latexmk`，可以手动编译：

```powershell
xelatex -output-directory=build main.tex
biber --input-directory=build --output-directory=build main
xelatex -output-directory=build main.tex
xelatex -output-directory=build main.tex
```

编译得到的 PDF 会在 `build/main.pdf`。

## 插入图片

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.75\linewidth]{example.pdf}
  \caption{图片标题}
  \label{fig:example}
\end{figure}
```

因为 `config/format.tex` 中已经设置了：

```latex
\graphicspath{{figures/final/}}
```

所以图片文件放在 `figures/final/` 后，正文里可以直接写文件名。

## 插入表格

小表格可以直接写在正文中。较大的表格建议放进 `tables/parameters.tex`，然后在正文中写：

```latex
\input{tables/parameters}
```

## 参考文献

在 `references.bib` 中添加条目：

```bibtex
@article{key,
  author  = {Author Name},
  title   = {Paper Title},
  journal = {Journal Name},
  year    = {2026}
}
```

正文引用：

```latex
这里引用一篇文献 \cite{key}。
```

## 代码目录

`code/matlab/` 和 `code/python/` 用来存放和论文相关的计算、作图、数据处理脚本。建议把可以复现实验结果的核心脚本放在这里，不要只保存最终图片。
