# AstroImageJ, now for NixOS!
AstroImageJ is a free and open-source FITS viewer and photometry tool for amatuer and professional astronomers alike. (Source page [here](https://astroimagej.com/)).
This flake does NOT build from source. Instead, it packages the pre-built binaries available on the releases page of the [AstroImageJ github](https://github.com/AstroImageJ/astroimagej/releases). Because of the way NixOS is designed, you will not be able to run these pre-built binaries by downloading them the normal way. Hence, I made this! I have only tested this on x86_64, because I do not have any ARM devices to test it on. If anyone finds an issue with the ARM build, let me know!


# Installation
You can install this in either your ```configuration.nix``` file or your home-manager module. Just make sure that ```pkgs``` and ```inputs``` are in scope of wherever you place it. 
Add the following to your ```flake.nix```:
```
inputs = {
  astroimagej = {
    url = "github:pokemans123/astroimagej-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

OR

```
inputs.astroimagej.url = "github:pokemans123/astroimagej-flake";
```

Then, in either ```home.nix``` or ```configuration.nix```, add the following:
``` inputs.astroimagej.packages.${pkgs.system}.astroimagej ```
