# Google GF180MCU test shuttle MPW-18H1 — Standard Cell & SRAM Density Report

**GF180MCU Process (GlobalFoundries 180nm), Shuttle GFMPW18H1**

## Introduction

This report analyzes the standard cell and SRAM density achieved by the 4 unique public chip designs on the Google GF180MCU test shuttle MPW-18H1 reticle. The reticle has 4 slots; the public layout contains 4 slot placements (some designs appear more than once, and private designs are not included).

> **Partial measurement:** parts of every die are excluded from these figures; see [Methodology](#methodology).

All designs were fabricated on GlobalFoundries' GF180MCU process, a 180-nanometer (0.18um) technology node. This is a mature, relatively large-geometry process — for comparison, modern smartphone chips use 3nm or 5nm processes with features roughly 50x smaller.

> **Note on counting methodology:** All standard cell counts in this report count only **logic cells** — cells that perform actual computation (gates, flip-flops, buffers, multiplexers, etc.). Infrastructure cells are excluded: filler cells (fill, fillcap, endcap, filltie), well taps, antenna fix diodes, ESD diodes, and tie-high/tie-low cells. These infrastructure cells are inserted by automated tools to satisfy manufacturing rules but perform no logic function. On this reticle there are 55k infrastructure cell instances and 8k logic cell instances across the unique designs — 6.5 infrastructure cells for every logic cell.

## What Are Standard Cells?

A "standard cell" is a pre-designed, pre-verified building block used to construct digital circuits. Think of them like LEGO bricks for chip design: each cell performs one simple logic function (an AND gate, a flip-flop for storing one bit, a buffer for boosting signal strength), and a chip designer assembles thousands or millions of them to build complex circuits.

Standard cells in a library all share the same height (so they line up in rows) but vary in width depending on their function. Automated tools place these cells in rows and then route wires between them.

The "density" of standard cells — how many fit per square millimeter — is a key measure of how efficiently a design uses its silicon area. Higher density generally means more logic functionality packed into less chip area, which reduces cost.

## Standard Cell Libraries on This Reticle

| Library | Row Height | Rows per mm | Relative Density | Logic instances | Share |
|---|---|---|---|---|---|
| [osu_sc_gp9t3v3 (OSU 9-track, 3.3V)](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 6.35 um | 157 rows | 62% | 7k | 88% |
| [mcu7t5v0 (7-track, 5V)](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) | 3.92 um | 255 rows | 100% | 1k | 12% |

Row height is the height of the cells' placement boundary, which is what rows are stacked at. Taller rows hold fewer cells per mm² but leave more room for wiring inside the cell.

## Theoretical Maximum Standard Cell Density

If you filled an entire square millimeter with nothing but one type of logic standard cell (no wiring, no gaps, no infrastructure cells), the theoretical maximum density would be:

| Cell Type | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) | What it does |
|---|---|---|---|
| Inverter | — | 114k/mm² ([`inv_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/inv/gf180mcu_fd_sc_mcu7t5v0__inv_1.html), 2.24um) | Flips a signal |
| NAND gate | 51k/mm² ([`nand2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=127), 3.10um) | 91k/mm² ([`nand2_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/nand2/gf180mcu_fd_sc_mcu7t5v0__nand2_1.html), 2.80um) | Basic logic gate |
| Buffer | 49k/mm² ([`buf_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=31), 3.20um) | 76k/mm² ([`buf_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/buf/gf180mcu_fd_sc_mcu7t5v0__buf_1.html), 3.36um) | Strengthens a signal |
| Flip-flop | 11k/mm² ([`dff_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=91), 14.50um) | 16k/mm² ([`dffq_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/dffq/gf180mcu_fd_sc_mcu7t5v0__dffq_1.html), 16.24um) | Stores one bit |

These are hard upper bounds — the density if you packed cells edge-to-edge with zero routing overhead. For each library the smallest cell of that kind is used; the 3.3V library has no drive strength 1 cells, so its smallest cells are the `_2` variants.

In practice, real designs achieve significantly less because:

- **(a) Routing overhead** — wires connecting cells need room, which limits how tightly cells can be placed
- **(b) Infrastructure cells** — fillers, taps, antenna diodes, and tie cells make up 87% of cell instances on this reticle
- **(c) Mixed cell types** — designs use a mix of small and large cells
- **(d) Power planning** — power/ground straps consume area
- **(e) Clock distribution** — clock tree buffers and wiring take space

## Achieved Standard Cell Density — Design Averages

The following tables show the average logic standard cell density for each design's "core area" — the interior of the chip excluding the I/O pad ring (a 442um border of large pads around the perimeter used for external connections).

"% of max" compares against the buffer theoretical maximum for the design's primary library. "Cell area" is the share of the core area actually covered by logic cells — the placement utilisation of the die as a whole, including any area left empty or given to SRAM.

### Low Density (below 3k logic SC/mm² core average)

| Design | Library | Core SC/mm² | % of max | Cell area | Logic SC | SRAM | Project |
|---|---|---|---|---|---|---|---|
| [0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 1k | 2% | 2% | 7k | 0 | [OSU 3.3V standard cell test (vlsiffra adder)](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1/slot-002) |

### Minimal (analog, custom or test structures)

These designs contain fewer than 1,000 logic standard cells:

| Design | Logic SC | Transistors | SRAM | Pads | Project |
|---|---|---|---|---|---|
| [0001](https://wafer.space/google-gf180mcu-mpw18h1/projects/0001.html) | 0 | 0 | 0 | 63 + 460 probe | [LibreSilicon Danube River test tile](https://github.com/thesourcerer8/gf180teststructure) |
| [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html) | 800 | 113k | 0 | 63 + 44 probe | [Fitbit test IC 1](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1/slot-003) |
| [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) | 248 | 104k | 0 | 136 | [Analog front-end for sensor readout (OpenFASoC)](https://github.com/idea-fasoc/openfasoc-tapeouts/tree/main/mpw18h1) |

## Achieved Density — Peak 1mm x 1mm Regions

While the averages above include sparse regions, the densest 1mm x 1mm square found anywhere on a design shows the highest density it achieved. The square slides over the die in 100um steps and may not touch an SRAM macro.

| Design | Peak Logic SC/mm² | % of buffer max | Library |
|---|---|---|---|
| [0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html) | 7k | 15% of 49k | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) |
| [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html) | 1k | 1% of 76k | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) |
| [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) | <1k | <1% of 76k | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) |

The highest achieved density on this reticle is 15% of the buffer theoretical maximum, observed in the densest 1mm² region of [0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html). The rest of that area is consumed by larger cells, infrastructure cells and the gaps left for routing.

## Library Comparison

Comparing designs that use one library exclusively:

| Metric | [osu_sc_gp9t3v3 (OSU 9-track, 3.3V)](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | [mcu7t5v0 (7-track, 5V)](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) |
|---|---|---|
| Designs using this library | 1 | 2 |
| Best core density | 1k SC/mm² · 2% of max ([0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html)) | <1k SC/mm² · <1% of max ([0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html)) |
| Best peak grid cell | 7k SC/mm² · 15% of max ([0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html)) | 1k SC/mm² · 1% of max ([0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html)) |
| Median core density | 1k SC/mm² · 2% of max | <1k SC/mm² · <1% of max |

Differences between libraries here reflect which designs chose which library as much as the libraries themselves; the theoretical difference from row height alone is in the table above.

## Most Common Logic Cell Types

The 15 most-used logic cell types across all unique designs on the reticle:

| Cell Type | Library | Instances | What it does |
|---|---|---|---|
| [`nand2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=127) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 1k | 2-input NAND gate |
| [`xnor2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=167) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 1k | 2-input XNOR gate |
| [`nor2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=131) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 1k | 2-input NOR gate |
| [`xor2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=170) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 890 | 2-input XOR gate |
| [`clkbuf_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=46) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 715 | Clock buffer |
| [`aoi21_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=17) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 445 | AND-OR-Invert compound gate |
| [`oai21_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=135) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 375 | OR-AND-Invert compound gate |
| [`clkinv_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=61) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 274 | Clock inverter |
| [`and2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=11) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 263 | 2-input AND gate |
| [`dff_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=91) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 256 | D flip-flop (1 bit storage) |
| [`buf_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=31) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 180 | Buffer |
| [`clkbuf_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/clkbuf/gf180mcu_fd_sc_mcu7t5v0__clkbuf_1.html) | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) | 176 | Clock buffer |
| [`clkbuf_3`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/clkbuf/gf180mcu_fd_sc_mcu7t5v0__clkbuf_3.html) | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) | 136 | Clock buffer (3x drive) |
| [`or2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=153) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 117 | 2-input OR gate |
| [`oai22_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=140) | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) | 101 | OR-AND-Invert (2x2 inputs) |

Across the reticle there are 1k 2-input NAND gates and 336 flip-flops — 3.9 NAND2 gates per flip-flop.

## SRAM Block Usage

SRAM (Static Random-Access Memory) blocks are pre-designed memory macros. Unlike standard cells, which are composed by automated tools, SRAM blocks are hand-optimized fixed-size units designed to store data as densely as possible.

None of the designs on this reticle include SRAM blocks.

## SRAM vs Standard Cell Transistor Density

"Transistor density" here counts the number of distinct regions where a gate electrode (polysilicon, [GDS 30/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) crosses an active area (diffusion, [GDS 22/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) — each such crossing forms one transistor.

### Theoretical Maximum Transistor Density for Standard Cells

| Cell ([OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3)) | Width | Cells/mm² | Trans/cell | Trans/mm² theoretical max |
|---|---|---|---|---|
| [`nand2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=127) | 3.10 um | 51k | 4 | 203k/mm² |
| [`buf_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=31) | 3.20 um | 49k | 4 | 197k/mm² |
| [`dff_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=91) | 14.50 um | 11k | 26 | 282k/mm² |

| Cell ([7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html)) | Width | Cells/mm² | Trans/cell | Trans/mm² theoretical max |
|---|---|---|---|---|
| [`inv_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/inv/gf180mcu_fd_sc_mcu7t5v0__inv_1.html) | 2.24 um | 114k | 2 | 228k/mm² |
| [`nand2_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/nand2/gf180mcu_fd_sc_mcu7t5v0__nand2_1.html) | 2.80 um | 91k | 4 | 364k/mm² |
| [`buf_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/buf/gf180mcu_fd_sc_mcu7t5v0__buf_1.html) | 3.36 um | 76k | 4 | 304k/mm² |
| [`dffq_1`](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/cells/dffq/gf180mcu_fd_sc_mcu7t5v0__dffq_1.html) | 16.24 um | 16k | 24 | 377k/mm² |

### SRAM Macros

| Macro | Size | Trans/mm² | % of flip-flop max | Placements |
|---|---|---|---|---|
| [`gf180mcu_fd_ip_sram__sram512x8m8wm1`](https://gf180mcu-pdk.readthedocs.io/en/latest/IPs/SRAM/gf180mcu_fd_ip_sram/cells/gf180mcu_fd_ip_sram__sram512x8m8wm1/gf180mcu_fd_ip_sram__sram512x8m8wm1.html) | 432 x 485 um | 154k/mm² | 41% | 0 |

The macro density includes the peripheral circuits (address decoders, sense amplifiers, I/O drivers) around the bitcell array, which is why larger macros of a family are denser than smaller ones.

### Best Standard Cell Regions

| Design | Peak 1mm² Trans/mm² | % of flip-flop max | Library |
|---|---|---|---|
| [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html) | 73k/mm² | 19% | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) |
| [0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html) | 55k/mm² | 14% | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3) |
| [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) | 9k/mm² | 2% | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html) |

Infrastructure cells are excluded from logic cell counts but their transistors (decoupling capacitors in particular) are included in transistor counts.

## Process Features and Voltages

Which transistor voltages and optional devices of the GF180MCU process the 4 designs use. Voltages count both the libraries a design chose (standard cells and SRAM) and transistors the designer drew. Devices count only what the designer drew: standard cells, SRAM macros, I/O pads and fill are left out, because every die has them. A single test structure counts the same as a large block.

| Transistor voltage | Designs | Which |
|---|---|---|
| [3.3 V](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/spice/elec_specs/elec_specs_1.html) | 3 of 4 | [0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html), [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html), [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) |
| [5 V](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/spice/elec_specs/elec_specs_3.html) | 2 of 4 | [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html), [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) |
| [6 V](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/spice/elec_specs/elec_specs_2.html) | 1 of 4 | [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) |

| Device | Designs drawing it | Which |
|---|---|---|
| [MIM capacitors](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_10_4_2.html) | 2 of 4 | [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html), [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) |
| [Unsalicided poly resistors](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_10_01.html) | 2 of 4 | [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html), [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) |
| [High-resistance poly resistors](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_10_03.html) | 1 of 4 | [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) |
| [Diodes](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/model_parameters/LV/LV_3.html) | 1 of 4 | [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) |
| [Deep N-well](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_07_03.html) | 1 of 4 | [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) |
| [Native transistors](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_10_05.html) | 0 of 4 | — |
| [10 V LDMOS](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_10_12_1.html) | 0 of 4 | — |
| [MOS capacitors](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/model_parameters/LV/LV_6.html) | 0 of 4 | — |
| [Salicided poly resistors](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/model_parameters/LV/LV_4.html) | 0 of 4 | — |
| [Diffusion resistors](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/model_parameters/LV/LV_4.html) | 0 of 4 | — |
| [N-well resistors](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/model_parameters/LV/LV_4.html) | 0 of 4 | — |
| [Metal resistors](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/model_parameters/LV/LV_4.html) | 0 of 4 | — |
| [Well diodes](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/model_parameters/LV/LV_3.html) | 0 of 4 | — |
| [Bipolar transistors](https://gf180mcu-pdk.readthedocs.io/en/latest/analog/model_parameters/LV/LV_5.html) | 0 of 4 | — |
| [Schottky diodes](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_10_14.html) | 0 of 4 | — |
| [Zener diodes](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html) | 0 of 4 | — |
| [eFuses](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_10_11.html) | 0 of 4 | — |
| [One-time programmable memory](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_10_10.html) | 0 of 4 | — |
| [Inductors](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html) | 0 of 4 | — |

| Design | Voltages | Custom transistors 3.3 / 5 / 6 V | Devices drawn | I/O library |
|---|---|---|---|---|
| [0001](https://wafer.space/google-gf180mcu-mpw18h1/projects/0001.html) | — | 0 / 0 / 0 | — | — |
| [0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html) | 3.3 V | 0 / 0 / 0 | — | — |
| [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html) | 3.3 V, 5 V | 7,590 / 0 / 0 | MIM capacitors (Metal4-Metal5), Unsalicided poly resistors | — |
| [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) | 3.3 V, 5 V, 6 V | 39,217 / 20 / 18,462 | MIM capacitors (Metal4-Metal5), High-resistance poly resistors, Unsalicided poly resistors, Diodes, Deep N-well | fd_io |

Detection uses the open GF180MCU layers: a transistor is gate polysilicon ([30/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) over diffusion ([22/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)), thick oxide inside Dualgate ([55/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)), 5 V where V5_XTOR ([112/1](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) also covers it and 6 V where it does not; MIM capacitors are FuseTop ([75/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) shapes; poly resistors are Poly2 under RES_MK ([110/5](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)), high resistance under the Resistor layer ([62/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) and otherwise unsalicided under SAB ([49/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) or salicided. Other devices are found by their marker layers.

## Key Findings

1. The densest logic standard cell design, [0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html) (OSU 3.3V standard cell test (vlsiffra adder)), achieves **1k logic SC/mm²** averaged over its core (2% of buffer max), with a peak of **7k logic SC/mm²** in its densest 1mm² region.

2. Standard cell libraries in use: **[OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3)** (88% of logic cells), **[7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html)** (12% of logic cells).

3. The median digital design achieves **1k logic SC/mm²** over its core. 0 of 1 designs exceed 10k logic SC/mm².

4. The best standard cell region reaches **73k transistors/mm²** ([0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html)); the most used SRAM macro, [`gf180mcu_fd_ip_sram__sram512x8m8wm1`](https://gf180mcu-pdk.readthedocs.io/en/latest/IPs/SRAM/gf180mcu_fd_ip_sram/cells/gf180mcu_fd_ip_sram__sram512x8m8wm1/gf180mcu_fd_ip_sram__sram512x8m8wm1.html), is 154k transistors/mm².

5. Infrastructure cells (fillers, taps, antenna diodes, ties) outnumber logic cells **6.5 to 1** across the reticle (55k vs 8k). Any density analysis must exclude these to avoid dramatically overstating actual logic content.

6. The most common logic cell is **[`nand2_1`](https://cdn.jsdelivr.net/gh/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc@8a2f58f283a2eaa725314c9e1b8b7d1d343f23a3/docs/gf180mcu_osu_sc_gp9t3v3_TT_25C.ccs.pdf#page=127)** (1k instances in [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3)).

## Per-Design Details

| Design | Cell | Die (mm) | Core mm² | Placements | Pads | Logic SC | Infra SC | Transistors | SRAM | Libraries |
|---|---|---|---|---|---|---|---|---|---|---|
| [0001](https://wafer.space/google-gf180mcu-mpw18h1/projects/0001.html) | `0001_caravel_0_2` | 3.93 x 5.12 | 9.0 | 1 | 63 + 460 probe | 0 | 0 | 0 | 0 | — |
| [0002](https://wafer.space/google-gf180mcu-mpw18h1/projects/0002.html) | `0002_caravel_2_2` | 3.93 x 5.12 | 9.0 | 1 | 63 | 7,341 | 35,623 | 54,594 | 0 | [OSU 9t-3.3V](https://github.com/stineje/globalfoundries-pdk-libs-gf180mcu_osu_sc/tree/main/gf180mcu_osu_sc_gp9t3v3): 7,341 |
| [0003](https://wafer.space/google-gf180mcu-mpw18h1/projects/0003.html) | `0003_caravel_0_0` | 3.93 x 5.12 | 9.0 | 1 | 63 + 44 probe | 800 | 17,709 | 113,117 | 0 | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html): 800 |
| [0004](https://wafer.space/google-gf180mcu-mpw18h1/projects/0004.html) | `0004_caravel_2_0` | 3.93 x 5.12 | 9.0 | 1 | 136 | 248 | 1,433 | 104,169 | 0 | [7t-5V](https://gf180mcu-pdk.readthedocs.io/en/latest/digital/standard_cells/gf180mcu_fd_sc_mcu7t5v0/index.html): 248 |

## Methodology

- **Logic cell counts** come from walking the layout hierarchy and counting instances of every cell whose name contains a standard cell library prefix, excluding types starting with `fill`, `endcap`, `filltie`, `fillcap`, `decap`, `tap`, `antenna`, `diode`, `tiel`, `tieh`.
- **Transistor counts** are the number of merged polygons in the boolean AND of the diffusion ([22/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) and gate polysilicon ([30/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) layers, leaving out dummy fill cells, whose diffusion and polysilicon squares overlap without forming transistors.
- **Core area** is the area of each design's `user_project_wrapper` cell.
- **Cell dimensions** are the width and height of each standard cell's placement boundary ([GDS 0/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)), measured from the cells present in this layout.
- **Theoretical maximum** = (1000um / cell width) x (1000um / row height).
- **Pads** are openings on the pad layer ([37/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)) at least 20um across. Those in the pad ring (within 400um of the die edge) or in a second ring of pads inside it are bond pads; the others are probe pads, shown as "+ N probe". Letters and logos on the pad layer are not pads.
- **Missing placement boundaries:** 159 standard cells in this layout have no placement boundary ([GDS 0/0](https://gf180mcu-pdk.readthedocs.io/en/latest/physical_verification/design_manual/drm_04_1.html#drawn-layer-definition-and-abbreviation)). For 137 of them the boundary measured from the wafer.space Run 1 and Run 2 layouts of the same cell is used. For 22 no reference exists and the cell's bounding box is used, which overstates its size.
- **Peak figures** are the densest 1mm x 1mm square anywhere inside each die, found by sliding the square in 100um steps over the die and skipping positions that touch an SRAM macro. Logic cells are placed by their origin and transistors by the centre of their gate.
- **SRAM macros** are counted by cell name. The `sram_block_count` column of the summary CSV is kept for comparison with earlier results; it counts SramCore marker shapes, of which each GF180MCU macro has two.
- Designs placed more than once on the reticle are counted once.
- **Excluded from the measurements:** pad ring (`gf180mcu_*_io__*`); caravel harness (`caravel_core`, `caravel_power_routing`, `chip_io`, `caravel_logo`, `caravel_motto`, `copyright_block`, `open_source`, `user_id_textblock`); seal ring (`sealring`). Cells matching `user_project_wrapper` are measured even inside those. Logic cell, transistor and SRAM figures therefore cover only part of each die and are not directly comparable with reports that measure whole dies. Die sizes are measured on the whole die, and bond pads on the whole die apart from its seal ring.

---

*Generated by [ws-run-reports](https://github.com/wafer-space/ws-run-reports) from `GFMPW18H1.oas` (md5 `e65f93005a41a1c997298f8b4abfc07c`) in [wafer-space/google-gf180mcu-mpw18h1](https://github.com/wafer-space/google-gf180mcu-mpw18h1). Analysis method: [KLayout](https://www.klayout.de/) boolean geometry operations on GDS layers. Grid resolution: 1mm x 1mm. Density figures are rounded to the nearest 1k.*
