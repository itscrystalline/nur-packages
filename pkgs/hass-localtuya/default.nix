{
  lib,
  buildHomeAssistantComponent,
  fetchFromGitHub,
}:
buildHomeAssistantComponent rec {
  owner = "xZetsubou";
  domain = "hass-localtuya";
  version = "2025.5.1";

  src = fetchFromGitHub {
    inherit owner;
    repo = domain;
    rev = version;
    hash = "sha256-cYaMHh16dmjO8UrpBZScGoHDNqvmQ5ceAq/lP6qazxA=";
  };

  meta = with lib; {
    changelog = "https://github.com/rospogrigio/localtuya/releases/tag/${version}";
    description = "Home Assistant custom Integration for local handling of Tuya-based devices";
    homepage = "https://github.com/rospogrigio/localtuya";
    maintainers = with maintainers; [rhoriguchi];
    license = licenses.gpl3Only;
  };
}
