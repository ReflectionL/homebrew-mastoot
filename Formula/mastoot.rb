class Mastoot < Formula
  desc "An aesthetically-driven Mastodon TUI client"
  homepage "https://github.com/ReflectionL/mastoot"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.3.2/mastoot-aarch64-apple-darwin.tar.xz"
      sha256 "987b060e3f63c66cbca6c414045e87939feaefc5f54bd50d6fa5ca12e9b4fa28"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.3.2/mastoot-x86_64-apple-darwin.tar.xz"
      sha256 "13ba7c633953e1c9e1aa66847bd8e9a6a9bdd2430d6de916feaaa62938f6c777"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.3.2/mastoot-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cb1aa6d0a0369fc690776be19000b68da432f8ec054dd2a23397117977b66387"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.3.2/mastoot-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4ffe762002a09dee78063799d6fe5796a872da35a9fc167f18c0a051c05807b8"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mastoot"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mastoot"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mastoot"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mastoot"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
