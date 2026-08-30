class Stack < Formula
  desc "Per-project runtimes, shared services and secure .test domains"
  homepage "https://github.com/luewell/stack-binaries"
  version "0.9.0"

  on_macos do
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-darwin-arm64.tar.gz"
      sha256 "c5f544885371802ba204cc0f04951250b355c892d0de84ed487f9cc94ecc0c5e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-amd64.tar.gz"
      sha256 "e0f63a8b877a22d526628e456b762d49f95b8b6dee7438c6e38856e713ee4522"
    end
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-arm64.tar.gz"
      sha256 "e17c45e194517387de7cac9c6ae9e242c03f2254b9d860df1ee0ec0b7555b701"
    end
  end

  # All five together: each finds the others beside itself, so installing one
  # without the rest leaves it unable to serve anything.
  def install
    bin.install "stack", "stackd", "stack-shim", "stack-helper", "stack-hosts"
  end

  # Homebrew has no "zap" for a formula, and could not do this one anyway: what
  # has to be undone is a resolver file, two system services and a trusted root,
  # each reversed from the record written when it was installed. So it is said
  # here, and it has to happen first: afterwards the tool that undoes it is gone.
  # Upgrading replaces the files and leaves the daemon that was already running
  # exactly where it was, answering as the version just replaced. The archive's
  # own installer does this; Homebrew never runs that, so the formula does.
  def post_install
    system bin/"stack", "daemon", "restart"
  rescue
    opoo "could not replace the running daemon; run \"stack daemon restart\""
  end

  # Named in full: "stack" alone is also a cask, so Homebrew answers a bare name
  # with "Cask 'stack' is not installed" — and an instruction that does not work
  # is worse than none.
  def caveats
    <<~TEXT
      Prepare this machine once, then work in any repository with a stack.yaml:

        stack setup
        stack up

      To remove it, undo the machine changes before uninstalling:

        stack uninstall --purge
        brew uninstall luewell/brew/stack

      --purge also deletes the databases and object storage your projects used.
      Leave it off to keep them.
    TEXT
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stack --version")
  end
end
