class Stack < Formula
  desc "Per-project runtimes, shared services and secure .test domains"
  homepage "https://github.com/luewell/stack-binaries"
  version "1.1.0"

  on_macos do
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-darwin-arm64.tar.gz"
      sha256 "27423f63b2b800d218e429b33dfd0df0d129519c797410a4643e9d2352da008b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-amd64.tar.gz"
      sha256 "5458e51ce49ca2278da257a714ffc1ba4cc2fb386d4fced7a67ff534b81c35bc"
    end
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-arm64.tar.gz"
      sha256 "6f090fd4fb8c69adc2f74cee88e887d76bde77b1db152f3b47724190a9f98f7b"
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
  def caveats
    <<~TEXT
      Prepare this machine once, then work in any repository with a stack.yaml:

        stack setup
        stack up

      After upgrading, run this once so the daemon is the version just
      installed. Homebrew cannot do it: it runs with a home and a temporary
      directory of its own, and the daemon is reachable through neither.

        stack daemon restart

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
