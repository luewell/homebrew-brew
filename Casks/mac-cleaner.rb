cask "mac-cleaner" do
  version "0.1.0"
  sha256 "ccd6238117e6e8506dd68513e49b0d9133fb27f424f6e6e039c874376f99e04c"

  url "https://github.com/luewell/stack-binaries/releases/download/mac-cleaner-#{version}/MacCleaner-#{version}.dmg"
  name "Mac Cleaner"
  desc "Cleans caches, finds clutter, uninstalls apps, and monitors your Mac"
  homepage "https://github.com/luewell/stack-binaries"

  auto_updates true
  depends_on macos: ">= :tahoe"

  app "Mac Cleaner.app"

  zap trash: [
    "~/Library/Caches/com.luewell.mac-cleaner",
    "~/Library/HTTPStorages/com.luewell.mac-cleaner",
    "~/Library/Preferences/com.luewell.mac-cleaner.plist",
    "~/Library/Saved Application State/com.luewell.mac-cleaner.savedState",
  ]
end
