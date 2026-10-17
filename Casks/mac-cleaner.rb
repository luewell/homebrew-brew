cask "mac-cleaner" do
  version "0.1.5"
  sha256 "3843cda64bb6a3e8bd97fb8d40924eb5cf6f1b452727fedb89c2bdaec0335b77"

  url "https://github.com/luewell/stack-binaries/releases/download/mac-cleaner-#{version}/MacCleaner-#{version}.dmg"
  name "Mac Cleaner"
  desc "Cleans caches, finds clutter, uninstalls apps, and monitors your Mac"
  homepage "https://github.com/luewell/stack-binaries"

  auto_updates true
  depends_on macos: :tahoe

  app "Mac Cleaner.app"

  zap trash: [
    "~/Library/Caches/com.luewell.mac-cleaner",
    "~/Library/HTTPStorages/com.luewell.mac-cleaner",
    "~/Library/Preferences/com.luewell.mac-cleaner.plist",
    "~/Library/Saved Application State/com.luewell.mac-cleaner.savedState",
  ]
end
