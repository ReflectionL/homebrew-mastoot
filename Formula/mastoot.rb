class Mastoot < Formula
  desc "An aesthetically-driven Mastodon TUI client"
  homepage "https://github.com/ReflectionL/mastoot"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.3.3/mastoot-aarch64-apple-darwin.tar.xz"
      sha256 "ec6adac849655c2679a0525be5949dda727a393af63239310999e67ec6b9e408"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.3.3/mastoot-x86_64-apple-darwin.tar.xz"
      sha256 "4aaa79c9d7203fb804b22f6e580b45530e721810d906472f1f4208e4381afa9a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.3.3/mastoot-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "151b4070e19db8169007eaeaa4ecb5bcc2f393aea37300ff57b1389a4e070f30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReflectionL/mastoot/releases/download/v0.3.3/mastoot-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "540f3d4bfed0c41def080760ab4d6c596fdddd92d589bbb5618eaab0e91664d7"
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
