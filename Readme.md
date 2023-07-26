# Purpose, Description

This is the int2lm tool of the IOW earth-system model. 
The original source code is from the starter package v2.0 
(https://redc.clm-community.eu/projects/cclm-sp/files/cclm-sp_2.0.tgz)
This tool can be used to prepare boundary files for the CCLM (and ICON) model.
The necessary input for this tool are so-called `caf` files that are available on DKRZ servers.
These `caf` files are converted output files from global models or reanalysis data, 
e.g. MPI-ESM or ERA5, respectively.


# Authors

* SK      (sven.karsten@io-warnemuende.de)


# Versions

## 1.00.02 (latest release)

| date        | author(s)   | link      |
|---          |---          |---        |
| 2023-07-26  | SK          | [1.00.02](https://git.io-warnemuende.de/iow_esm/tools.i2lm/src/branch/1.00.02)     | 

<details>

### changes
* added build script templates
* added release meachanism of patch original source code
* added patch-merging mechnanism in build script
    
### dependencies
* see build scripts for more dependencies  
  
### known issues
* None

### tested with
* intensively tested on both HLRN machines
  * using example setups available under:
    * /scratch/usr/mviowmod/IOW_ESM/setups/I2LM_Eurocordex/example_ERAI_0.22deg/1.00.00
  
</details>


<details>
<summary><b><i>older versions</i></b></summary>

## 1.00.01

| date        | author(s)   | link      |
|---          |---          |---        |
| 2022-12-22  | SK          | [1.00.01](https://git.io-warnemuende.de/iow_esm/tools.i2lm/src/branch/1.00.01)     | 

<details>

### changes
* updated build.sh script
* mainly a release for a new version of main
    
### dependencies
* see build scripts for more dependencies  
  
### known issues
* None

### tested with
* intensively tested on both HLRN machines
  * using example setups available under:
    * /scratch/usr/mviowmod/IOW_ESM/setups/I2LM_Eurocordex/example_ERAI_0.22deg/1.00.00
  
</details>


## 1.00.00 

| date        | author(s)   | link      |
|---          |---          |---        |
| 2022-01-28  | SK          | [1.00.00](https://git.io-warnemuende.de/iow_esm/tools.i2lm/src/branch/1.00.00)  |  

<details> 

### changes
* initial release
* main codes is based on starter package v2.0: 
  https://redc.clm-community.eu/projects/cclm-sp/files/cclm-sp_2.0.tgz
* adaptions for IOW ESM are just build scripts

### dependencies
* see build scripts for more dependencies  

### known issues
* None

### tested with
* intensively tested on both HLRN machines
  * using example setups available under:
    * /scratch/usr/mviowmod/IOW_ESM/setups/I2LM_Eurocordex/example_ERAI_0.22deg/1.00.00

</details>

</details>