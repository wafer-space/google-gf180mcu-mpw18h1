# Google MPW-18H1

[Google](https://opensource.google/) GF180MCU test shuttle MPW-18H1, a private run on GlobalFoundries' MPW service

- Shuttle ID: GFMPW18H1
- Process: GF180MCU
- Number of slots: 4

<div align="center">
<table width="100%">
  <tr>
  <td width="50%"><img src="images/GFMPW18H1.png" width="95%"/></td>
  <td width="50%"><img src="images/GFMPW18H1.svg" width="95%"/></td>
  </tr>
</table>
</div>

This shuttle was not run by wafer.space, and it was not an Efabless Open MPW shuttle: Google ran it as a private test shuttle on GlobalFoundries' own MPW service. See [PROVENANCE.md](PROVENANCE.md) for where the layouts come from and how this repository was generated.

# Public Projects

| Code | Project | Slot Size | Project Details | Repository |
|---|---|---|---|---|
| 0001 | LibreSilicon Danube River test tile | 1x1 | GF180MCU test structures by Philipp Gühring of LibreSilicon; Silicon Prawn identifies the die as LibreSilicon's Danube River test tile (https://gitlab.libresilicon.com/generator-tools/danube-river). | https://github.com/thesourcerer8/gf180teststructure |
| 0002 | OSU 3.3V standard cell test (vlsiffra adder) | 1x1 | 32-bit adder using Anton Blanchard's vlsiffra architecture with the OSU gf180mcuC 3.3V standard cells. | https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1/slot-002 |
| 0003 | Fitbit test IC 1 | 1x1 |  | https://foss-eda-tools.googlesource.com/third_party/shuttle/gf180mcu/mpw-18h1/slot-003 |
| 0004 | Analog front-end for sensor readout (OpenFASoC) | 1x1 | Analog front-end for reading out flexible laser-induced graphene sensors: a 14-bit SAR ADC, folded-cascode op-amps with programmable bias and bias generation, designed with open-source tools by Brown University. Published as A. Li et al., IEEE Solid-State Circuits Magazine 16(2), 2024 (doi:10.1109/MSSC.2024.3380586). | https://github.com/idea-fasoc/openfasoc-tapeouts/tree/main/mpw18h1 |

# Die Photographs

[Silicon Prawn](https://siliconprawn.org/) has optical photographs of two of these dies, taken by John McMaster
(CC BY 4.0), with zoomable viewers and further details:

| Code | Silicon Prawn page | Copy on data.wafer.space |
|---|---|---|
| 0001 | [gf180mcu-mpw18h1-18100001](https://siliconprawn.org/archive/doku.php?id=mcmaster:efabless:gf180mcu-mpw18h1-18100001) | [mz_mit20x](https://data.wafer.space/big-storage/siliconprawn.org/efabless/efabless_gf180mcu-mpw18h1-18100001_mcmaster_mz_mit20x.jpg) |
| 0004 | [gf180mcu-mpw18h1-18100004](https://siliconprawn.org/archive/doku.php?id=mcmaster:efabless:gf180mcu-mpw18h1-18100004) | [mit20x](https://data.wafer.space/big-storage/siliconprawn.org/efabless/efabless_gf180mcu-mpw18h1-18100004_mcmaster_mit20x.jpg) |

# View the Reticle Layout

1. To view the reticle layout, please install [KLayout](https://www.klayout.de/).
2. Next, assemble `GFMPW18H1.oas` from the individual files: `cd layout; cat GFMPW18H1-part-?? >GFMPW18H1.oas`
3. The assembled `GFMPW18H1.oas` file can then be opened with KLayout.
4. Finally, load the layer properties file in KLayout: "File → Load Layer Properties" and choose `lyp/gf180mcu.lyp`.

Note: The `GFMPW18H1.oas` file was split with `split -b 90M GFMPW18H1.oas GFMPW18H1-part-`

# License

The projects shown here are public. For information on licences, please refer to the individual repositories.
