# Google / Efabless GF180MCU micro-shuttle MPW-18H1

MPW-18H1 was a four-project GF180MCU micro-shuttle from the Google-sponsored program, run by Efabless; the final dies were committed in December 2023. Every project is a [Caravel](https://github.com/efabless/caravel-gf180mcu) die: the user design in `user_project_wrapper`, surrounded by the same management SoC, padframe and power routing on every die.

- Shuttle ID: GFMPW-18H1
- Process: GF180MCU
- Number of slots: 4 (4x 1×1, as a 2 × 2 grid)

<div align="center">
<table width="100%">
  <tr>
  <td width="50%"><img src="images/GFMPW18H1.png" width="95%"/></td>
  <td width="50%"><img src="images/GFMPW18H1.svg" width="95%"/></td>
  </tr>
</table>
</div>

This repository presents the shuttle in the same format as the [wafer.space](https://wafer.space/) run repositories ([ws-run1](https://github.com/wafer-space/ws-run1), [ws-run2](https://github.com/wafer-space/ws-run2)), so the same tools can analyse it. The "reticle" in `layout/` is synthetic: it was assembled from the individual final dies published at [https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1), placed in wafer.space 1×1 slot positions. It is not the mask set as manufactured. `images/GFMPW18H1.png` is rendered from it with `scripts/lay2img.py` and `reticle.lyp` from [reticle-stitcher](https://github.com/wafer-space/reticle-stitcher) (`--width 4096 --oversampling 4`), the same way as the ws-run images.

In the layout, every cell of a die is renamed `<CODE>_<original name>` and each die's top cell is `<CODE>_caravel_<column>_<row>`. The code is the last four hex digits of the Efabless user ID.

# Public Projects

| Code | Project | Slot Size | Project Details | Repository | Efabless ID | Efabless name | Position |
|---|---|---|---|---|---|---|---|
| 0001 | PG standard cells test | 1x1 | GF180MCU test structures. By Philipp Gühring. | https://github.com/thesourcerer8/gf180teststructure | 18100001 | MPW18H1_PGSTDCELLS.01 | A1 (slot-001) |
| 0002 | OSU 3.3V standard cell test (vlsiffra adder) | 1x1 | 32-bit adder using Anton Blanchard's vlsiffra architecture with the OSU gf180mcuC 3.3V standard cells. | https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1/slot-002 | 18100002 | MPW18H1_OSUSTDCELLS.01 | B1 (slot-002) |
| 0003 | Fitbit test IC 1 | 1x1 |  | https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1/slot-003 | 18100003 | MPW18H1_FITBITTESTIC1.01 | C1 (slot-003) |
| 0004 | OpenFASoC sensor harness | 1x1 | OpenFASoC sensor harness. | https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1/slot-004 | 18100004 | MPW18H1_OPENFASOC.01 | D1 (slot-004) |

# View the Reticle Layout

1. To view the reticle layout, please install [KLayout](https://www.klayout.de/).
2. Next, assemble `GFMPW18H1.oas` from the individual files: `cd layout; ./create-reticle-oas.sh`
3. The assembled `GFMPW18H1.oas` file can then be opened with KLayout.
4. Finally, load the layer properties file in KLayout: "File → Load Layer Properties" and choose `lyp/gf180mcu.lyp`.

Note: The `GFMPW18H1.oas` file was split with `split -b 90M GFMPW18H1.oas GFMPW18H1-part-` (it is small enough to fit in one part)

# Provenance

- Source: the shuttle mirrors at [https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1](https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1): one repository per slot plus `foundry`, which holds `manifest-gfmpw-18h1.csv`.
- Each die is `tapeout/outputs/gds/caravel_<ID>.gds.gz` at the head of `main` in its slot repository; all four match the SHA1 in the manifest. (The manifest's download links all point at `slot-001`; the files are in their own slots.)
- The manifest lists the four projects as A1 to D1; here they are arranged as a 2 × 2 micro-shuttle, A1 and B1 on the top row.
- These dies keep their PR boundary (0/0) shapes.
- Repository links point to the designer's GitHub repository where one in a public mirror contains the slot's three newest non-Efabless commits; otherwise to the slot repository at googlesource.
- All four slot repositories are Apache-2.0 licensed.

# License

The projects shown here are public. Each project's slot repository at googlesource contains its licence; for information on licences, please refer to the individual repositories.
