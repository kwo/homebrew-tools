# typed: false
# frozen_string_literal: true

class Gfa < Formula
  desc "Git Fetch All CLI for scanning and updating repos in bulk"
  homepage "https://github.com/kwo/gfa-go"
  version "1.3.0"

  on_macos do
    on_intel do
      url "https://github.com/kwo/gfa-go/releases/download/v1.3.0/gfa_v1.3.0_darwin_amd64.tar.gz"
      sha256 "aeeca56c529e90aebad8b996e1adb9030cbf4a2ea4508ff096570608d790a9c2"
    end
    on_arm do
      url "https://github.com/kwo/gfa-go/releases/download/v1.3.0/gfa_v1.3.0_darwin_arm64.tar.gz"
      sha256 "60fd57b7d403c4691dbefc017236412967b005fd5d87979cd23008fe59ae1d85"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/kwo/gfa-go/releases/download/v1.3.0/gfa_v1.3.0_linux_amd64.tar.gz"
      sha256 "66735931ea598914b21218fe794f7867e55a73af16cc9647f553ab676a50b596"
    end
    on_arm do
      url "https://github.com/kwo/gfa-go/releases/download/v1.3.0/gfa_v1.3.0_linux_arm64.tar.gz"
      sha256 "3ab9c20a20def0d0bb420007e0c6907df3a76dd09f0b486d85069bda20de1268"
    end
  end

  def install
    bin.install "gfa"
  end
end
