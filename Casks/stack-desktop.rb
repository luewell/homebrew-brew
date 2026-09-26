cask "stack-desktop" do
  version "0.3.0"
  sha256 "ecf9e4fa9caad0c0f3711a0b14db77c4903932c30346ae29b8645c7a5eb999e8"

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
    Stack Desktop is signed ad hoc and not notarized, so macOS asks before it
    first opens: approve it under System Settings > Privacy & Security.

    Prepare this machine once, from the app's Setup page or with:

      stack setup
  TEXT
end
