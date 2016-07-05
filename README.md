# Ada Runtime System (RTS; ZFP Profile) for nRF51

## Usage

Rebuilding the RTS is not required before use.

1. Copy / git submodule the repository to your project

2. `gnatmake --RTS=$PWD/zfp-nrf51` or add to your gprbuild project
   file:
~~~ Ada
package Builder is
    for Switches ("Ada") use ("--RTS=" & Project'project_dir & zfp-nrf51);
end Builder;
~~~

## Building

1. Download / install [GNAT GPL from AdaCore]() (ARM-ELF)

2. `gprbuild runtime_build.gpr`

