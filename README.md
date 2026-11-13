# 元素周期表 · 蓝河手表应用（v1.3.0）

蓝河（BlueOS）手表应用，覆盖 **1–36 号元素**，**一行三个**，青色主题。上下滑动浏览，无分页、无搜索。
按 iQOO WATCH GT 调版：**390 × 450 px 方屏**，`designWidth: 390`（1 design px = 1 物理 px）。

## v1.3.0 改动

- **元素符号改为纯白**（`#ffffff`）。v1.2.0 里 `.sym` 没写 `color`，只靠 `.sym.alkali` 这类组合类选择器上色；手表侧组合选择器未生效，符号就退回了默认黑色。
- 现在 `.sym` 单类规则里直接写死白色，模板里的 `class` 也去掉了族别类名，符号颜色不再依赖任何组合选择器。
- 族别区分改由卡片左侧 3 px 色条承担（`.card.xxx { border-left-color }`），8 条色条规则仍在。
- 版式、数据、尺寸不变。

v1.2.0 的一行三个 + 青色主题、v1.1.0 修掉的死机问题（模板 `for` 块重复 18 份）均保持不变，`versionCode` 已到 4。

## 界面

| | |
|---|---|
| 首屏 | `preview-1.png` |
| 滑动中段 | `preview-m2.png` |
| 可交互预览 | `preview.html`（浏览器打开，1:1 模拟 390×450 表盘） |

```
17            Cl      ← 原子序数 / 元素符号（白色，族别看左侧色条）
氯          35.45     ← 中文名 / 相对原子质量
质子17·中子18          ← 质子数 / 中子数
3s²3p⁵                ← 价层电子排布
```

## 数据口径

- **相对原子质量**：IUPAC 标准原子量，保留两位小数。
- **中子数**：取自然界丰度最高的同位素，`中子数 = 质量数 − 质子数`。Cl 取 ³⁵Cl → 18；Ni 取 ⁵⁸Ni → 30；氢取 ¹H，中子数为 0。
- **价层电子排布**：只写价层；过渡金属 `(n−1)d + ns`，Cr `3d⁵4s¹`、Cu `3d¹⁰4s¹` 为洪特规则特例。

## 配色

| 用途 | 值 |
|---|---|
| 页面底 | `#05090b` |
| 卡片底 | `#0b1417` |
| 卡片描边 | `#16333b` |
| 标题 | `#e8feff` |
| 元素符号 | `#ffffff` |
| 中文名 | `#d7f2f6` |
| 原子序数 | `#6f949b` |
| 质子中子 | `#7fa3aa` |
| 价层排布 | `#a9e9f2` |

族别色条（左 3 px）：碱金属 `#67e8f9`、碱土 `#22d3ee`、过渡 `#38bdf8`、主族金属 `#2dd4bf`、类金属 `#7dd3fc`、非金属 `#5eead4`、卤素 `#06b6d4`、稀有气体 `#a5f3fc`。

## 目录

```
periodic-table/
├── src/
│   ├── manifest.json          # com.blueos.periodic v1.3.0(4)，watch-square，designWidth 390
│   ├── app.ux
│   ├── assets/images/icon.png
│   └── pages/Home/index.ux    # 数据 + 模板 + 样式
├── dist/watch-square/
│   ├── debug/com.blueos.periodic.debug.1.3.0.rpk
│   └── release/com.blueos.periodic.release.1.3.0.rpk
├── sign/                      # 自签证书，与前几版同一份，可覆盖升级
├── preview.html
└── package.json
```

## 重新打包

```bash
JAX=~/.blueos/toolchain/blueos-pack/bin/index.js bash <skill>/scripts/build.sh .
python3 <skill>/scripts/verify_rpk.py ./dist
```

`versionCode` 已为 4；下次发版必须再 +1，否则可能无法覆盖安装。

## 布局余量

内容区 342 px，三张卡片 108×3 = 324，剩下 18 px 平分成两道 9 px 间隙。
卡片内可用宽 91 px，实测最长内容（`质子24·中子28`、`3d¹⁰4s¹`）不换行、不溢出。
若之后把字号调大，先跑 `preview.html` 里量 `scrollHeight - clientHeight`，别超过 0。
