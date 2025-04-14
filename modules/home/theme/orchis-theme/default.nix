{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  gnome-themes-extra,
  gtk-engine-murrine,
  sassc,
  theme ? "all", # can be "default" "purple" "pink" "red" "orange" "yellow" "green" "teal" "grey" "all"
  color ? "dark", # can be "standard" "light" "dark"
  size ? "standard", # can be "standard" "compact"
  icon ? "default", # can be "default" "apple" "simple" "gnome" "ubuntu" "arch" "manjaro" "fedora" "debian" "void" "opensuse" "popos" "mxlinux" "zorin" "endeavouros" "tux" "nixos" "gentoo" "budgie" "solus"
  lib-adwaita ? true,
  tweaks ? [ ], # can be "solid" "compact" "black" "primary" "macos" "submenu" "nord" "dracula"
  round ? null, # Suggested: 2 < value < 16
  withWallpapers ? false,
}:

let
  pname = "orchis-theme";

  validTweaks = [
    "solid"
    "compact"
    "black"
    "primary"
    "macos"
    "submenu"
    "nord"
    "dracula"
  ];

  nordXorDracula =
    with builtins;
    lib.assertMsg (!(elem "nord" tweaks) || !(elem "dracula" tweaks)) ''
      ${pname}: dracula and nord cannot be mixed. Tweaks ${toString tweaks}
    '';
in

assert nordXorDracula;
lib.checkListOfEnum "${pname}: theme tweaks" validTweaks tweaks

  stdenvNoCC.mkDerivation
  rec {
    inherit pname;
    version = "2024-11-03";

    src = fetchFromGitHub {
      repo = "Orchis-theme";
      owner = "vinceliuice";
      rev = version;
      hash = "sha256-K8FiS1AiFMhVaz2Jbr0pudQJGqpwBkQ/4NZdZACtM9Q=";
    };

    nativeBuildInputs = [
      gtk3
      sassc
    ];

    buildInputs = [ gnome-themes-extra ];

    propagatedUserEnvPkgs = [ gtk-engine-murrine ];

    preInstall = ''
      mkdir -p $out/share/themes
    '';

    installPhase = ''
      runHook preInstall
      bash install.sh -d $out/share/themes \
        --theme ${builtins.toString theme} \
        --color ${builtins.toString color} \
        --size ${builtins.toString size} \
        --icon ${builtins.toString icon} \
        ${lib.optionalString (lib-adwaita == true) "--libadwaita"} \
        ${lib.optionalString (tweaks != [ ]) "--tweaks " + builtins.toString tweaks} \
        ${lib.optionalString (round != null) (
          "--round " + builtins.toString round + "px"
        )}
      ${lib.optionalString withWallpapers ''
        mkdir -p $out/share/backgrounds
        cp src/wallpaper/{1080p,2k,4k}.jpg $out/share/backgrounds
      ''}
      runHook postInstall
    '';

    meta = with lib; {
      description = "Material Design theme for GNOME/GTK based desktop environments";
      homepage = "https://github.com/vinceliuice/Orchis-theme";
      license = licenses.gpl3Plus;
      platforms = platforms.linux;
      maintainers = [ maintainers.fufexan ];
    };
  }