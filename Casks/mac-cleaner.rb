cask "mac-cleaner" do
  version "0.1.3"
  sha256 "d79fa1892eabd0e2a04fb4698064d032a57b092013f5831a45aacbb49312471a"

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
