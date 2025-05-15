{
  lib,
  buildHomeAssistantComponent,
  fetchFromGitHub,
}:
buildHomeAssistantComponent rec {
  owner = "xZetsubou";
  domain = "localtuya";
  version = "2025.5.1";

  src = fetchFromGitHub {
    inherit owner;
    repo = "hass-localtuya";
    rev = version;
    hash = "sha256-cYaMHh16dmjO8UrpBZScGoHDNqvmQ5ceAq/lP6qazxA=";
  };

  meta = with lib; {
    changelog = "https://github.com/xZetsubou/hass-localtuya/releases/tag/${version}";
    description = "Home Assistant custom Integration for local handling of Tuya-based devices";
    homepage = "https://github.com/xZetsubou/hass-localtuya";
    maintainers = [];
    license = licenses.gpl3Only;
  };
}
