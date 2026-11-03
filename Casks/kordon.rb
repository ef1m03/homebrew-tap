cask "kordon" do
  version "1.3.3"
  sha256 "5f036b2012775e72f642019d32eb1022ff26af9d69a2130e524b3baed074c614"

  url "https://github.com/ef1m03/kordon/releases/download/v#{version}/Kordon-macos.zip"
  name "Kordon"
  desc "Kill switch for apps: freezes them when the network or public IP changes"
  homepage "https://github.com/ef1m03/kordon"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Kordon updates itself from its menu.
  auto_updates true
  depends_on macos: ">= :big_sur"

  app "Kordon.app"

  # Not notarized (that costs $99/year); every release file is scanned by VirusTotal and Kaspersky instead.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Kordon.app"]
  end

  uninstall launchctl: "dev.efimov.kordon",
            signal:    ["TERM", "dev.efimov.kordon"]

  zap trash: [
    "~/Library/Application Support/Kordon",
    "~/Library/LaunchAgents/dev.efimov.kordon.plist",
  ]
end
