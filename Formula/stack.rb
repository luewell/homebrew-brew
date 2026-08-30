class Stack < Formula
  desc "Per-project runtimes, shared services and secure .test domains"
  homepage "https://github.com/luewell/stack-binaries"
  version "0.5.0"

  on_macos do
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-darwin-arm64.tar.gz"
      sha256 "9d3b56da19e3aa8f2848b9ed62a113fc65005ccec85cb51529c02ba5ec796c19"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-amd64.tar.gz"
      sha256 "ec871bf4b620693120783c7300fc9ca1e6aa66abb3d23c7f00a865962ee72a01"
    end
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-arm64.tar.gz"
      sha256 "266d0b79f8215f42bd6e432c6ebfd461ed23d56c6cc9af80350d029f5538a1ba"
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

  def caveats
    <<~TEXT
      Prepare this machine once, then work in any repository with a stack.yaml:

        stack setup
        stack up

      To remove it, undo the machine changes before uninstalling:

        stack uninstall --purge
        brew uninstall stack

      --purge also deletes the databases and object storage your projects used.
      Leave it off to keep them.
    TEXT
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stack --version")
  end
end
