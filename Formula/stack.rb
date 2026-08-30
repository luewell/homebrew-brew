class Stack < Formula
  desc "Per-project runtimes, shared services and secure .test domains"
  homepage "https://github.com/luewell/stack-binaries"
  version "0.8.0"

  on_macos do
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-darwin-arm64.tar.gz"
      sha256 "56f2e7a6b20a26aef62803283598819d8bc8add27b7ccda2cd8b35179a808cd7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-amd64.tar.gz"
      sha256 "06cb655bf1145e1df5f10101cc3cb19129a3f8c2f3fdf9f58d0de1d8e8410589"
    end
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-arm64.tar.gz"
      sha256 "0d08bef4705bf4f852d2182182fffa7b35347b9b74d0cf86ddee5f9738291f1b"
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
