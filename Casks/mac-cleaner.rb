cask "mac-cleaner" do
  version "0.1.1"
  sha256 "71c78c18810378615670ef4d37e2c38b66212c2653680158655a06f39637610f"

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
