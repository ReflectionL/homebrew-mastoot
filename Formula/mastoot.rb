class Mastoot < Formula
  desc "An aesthetically-driven Mastodon TUI client"
  homepage "https://github.com/ReflectionL/mastoot"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.2.0/mastoot-aarch64-apple-darwin.tar.xz"
      sha256 "37d3a6d2b87a81bf6556f719c9674a3402dfdda34474819f8c43e771a3c6d2ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.2.0/mastoot-x86_64-apple-darwin.tar.xz"
      sha256 "f63b0670ed5981ab36fe0840e0b6ad48219b4b0cc8b54047a47fcb651e007d0b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.2.0/mastoot-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2260374ed31b418e763cb546d224f838128570a67d565b73a00fab0107a1725a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.2.0/mastoot-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "08aa7cf799caeff17013711c8fef972982f65c5f075a809115fa2cf5f260cf18"
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
