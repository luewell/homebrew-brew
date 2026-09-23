class Stack < Formula
  desc "Per-project runtimes, shared services and secure .test domains"
  homepage "https://github.com/luewell/stack-binaries"
  version "2.10.0"

  on_macos do
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-darwin-arm64.tar.gz"
      sha256 "70ee17f1349af0659275eb4d42019f395ba879446fdc38112110fbe0184276bb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-amd64.tar.gz"
      sha256 "693786f732507e1cbd2c65bfc3a53188b4e3dbbd6c66f7a533c4294aff1e3ea0"
    end
    on_arm do
      url "https://github.com/luewell/stack-binaries/releases/download/stack-#{version}/stack-#{version}-linux-arm64.tar.gz"
      sha256 "1fbe672d76ac2baeac9309a22e23604394d0aa2f20ec7d9566f6044ce4e4073e"
    end
  end

  # All five together: each finds the others beside itself, so installing one
  # without the rest leaves it unable to serve anything.
  def install
    bin.install "stack", "stackd", "stack-shim", "stack-helper", "stack-hosts"

    # Where each shell already looks, rather than a line in somebody's profile.
    generate_completions_from_executable(bin/"stack", "completion")
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

      After upgrading, continue using Stack normally. The next command that needs
      the daemon refreshes changed native services automatically. It asks for
      administrative access only when a protected helper actually changed.

      Run stack doctor any time you want to inspect the machine without changing it.

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
