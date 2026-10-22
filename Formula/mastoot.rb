class Mastoot < Formula
  desc "An aesthetically-driven Mastodon TUI client"
  homepage "https://github.com/ReflectionL/mastoot"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.1.1/mastoot-aarch64-apple-darwin.tar.xz"
      sha256 "a4cb765a5edd773e102ed0cf6442aeda6c0792cc897fdd29f8ae3eb99af111b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.1.1/mastoot-x86_64-apple-darwin.tar.xz"
      sha256 "e9a23c68757818d5881bd96577d13c6420ebdcb3dec1038284bcdcf2a09a2951"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.1.1/mastoot-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0fc7ee6361ac7e1a5d9e398c4735203e18339d9e1ade0bd01c777e3d07e6a971"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.1.1/mastoot-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21df12a60fdef570741ac77fa9229de3c4c9302df0e2189194f85ad03a4e1888"
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
