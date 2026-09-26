cask "device-lab" do
  version "0.1.1"
  sha256 "a1b14d5c5c03d13a9b34400f9e041abc75232e7a0739d84f44ae50a44f2b3712"

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
