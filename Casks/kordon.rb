cask "kordon" do
  version "1.4.7"
  sha256 "a4cca82ceca422eacf1bc031f1148fffa8491e539752f20730a3ea14da43ec9f"

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

  uninstall launchctl: "dev.efimov.kordon",
            signal:    ["TERM", "dev.efimov.kordon"]

  zap trash: [
    "~/Library/Application Support/Kordon",
    "~/Library/LaunchAgents/dev.efimov.kordon.plist",
  ]
end
