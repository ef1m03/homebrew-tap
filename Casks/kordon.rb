cask "kordon" do
  version "1.2.2"
  sha256 "1d96c3887c2ee5ece71983e8d6d4c51000fbf19224d0bf61b18c73082f078ae4"

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

  # Not notarized (that costs $99/year); the build is attested on GitHub instead:
  #   gh attestation verify Kordon-macos.zip --repo ef1m03/kordon
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
