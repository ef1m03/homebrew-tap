cask "kordon" do
  version "1.4.6"
  sha256 "8faafe0e501bb72867de932a2799a8ac68ab4a74ba5fdb7a8aa838be65e10fd3"

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
