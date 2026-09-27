cask "stack-desktop" do
  version "0.5.0"
  sha256 "d7eda4656affec054e1249da6c5cba9e8f193677d94d429dc0cf8bef501766a9"

  url "https://github.com/luewell/stack-binaries/releases/download/stack-desktop-#{version}/stack-desktop-#{version}-darwin-arm64.dmg"
  name "Stack Desktop"
  desc "Window and menu bar app for Stack's sites, services and repositories"
  homepage "https://stack.docs.luewell.dev/"

  depends_on arch: :arm64
  # The app is a client of Stack's daemon, which the formula installs.
  depends_on formula: "luewell/brew/stack"
  depends_on :macos

  app "Stack.app"

  zap trash: [
    "~/Library/Caches/dev.luewell.stack.desktop",
    "~/Library/Preferences/dev.luewell.stack.desktop.plist",
    "~/Library/WebKit/dev.luewell.stack.desktop",
  ]

  caveats <<~TEXT
    Prepare this machine once, from the app's Setup page or with:

      stack setup
  TEXT
end
