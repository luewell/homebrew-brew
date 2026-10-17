cask "mac-cleaner" do
  version "0.1.4"
  sha256 "74fc3ed1f8e83246452e9d8968cef05e8754e78d6586ee551587447c906d9c81"

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
