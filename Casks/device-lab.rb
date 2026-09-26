cask "device-lab" do
  version "0.1.0"
  sha256 "0d35be2b64ea88910ebd5c04b05bdcf0d611c58a0bc037b60c90db2e77b802ac"

  url "https://github.com/luewell/stack-binaries/releases/download/device-lab-#{version}/device-lab-#{version}-darwin-arm64.dmg"
  name "Device Lab"
  desc "Preview websites on simulated mobile browsers side by side"
  homepage "https://github.com/luewell/stack-binaries"

  depends_on arch: :arm64
  depends_on :macos

  app "Device Lab.app"

  zap trash: [
    "~/Library/Application Support/Device Lab",
    "~/Library/Caches/Device Lab",
    "~/Library/Logs/Device Lab",
    "~/Library/Preferences/dev.luewell.device-lab.plist",
    "~/Library/Saved Application State/dev.luewell.device-lab.savedState",
  ]
end
