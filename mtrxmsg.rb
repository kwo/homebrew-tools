# typed: false
# frozen_string_literal: true

class Mtrxmsg < Formula
  desc "Send and read messages in Matrix rooms"
  homepage "https://github.com/kwo/mtrxmsg"
  version "0.1.1"

  on_macos do
    on_intel do
      url "https://github.com/kwo/mtrxmsg/releases/download/v0.1.1/mtrxmsg_v0.1.1_darwin_amd64.tar.gz"
      sha256 "d512353746d00ec5be59a81ee29be7b5f38511a3b3c2e27ebcbaa38bb3ee101d"
    end
    on_arm do
      url "https://github.com/kwo/mtrxmsg/releases/download/v0.1.1/mtrxmsg_v0.1.1_darwin_arm64.tar.gz"
      sha256 "d6318ba2fc97d371eb267c9c66d78181cf4727005b88a0b995515934adae74ab"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/kwo/mtrxmsg/releases/download/v0.1.1/mtrxmsg_v0.1.1_linux_amd64.tar.gz"
      sha256 "6a05251c057b31fbc48701d6d54671c4717c0fe655319494dbeebf51107c4743"
    end
    on_arm do
      url "https://github.com/kwo/mtrxmsg/releases/download/v0.1.1/mtrxmsg_v0.1.1_linux_arm64.tar.gz"
      sha256 "2cecb826c70259c9457358e3f3f2f7eba2e8f730e0b6b574945220e2920a0a9a"
    end
  end

  def install
    bin.install "mtrxmsg"
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/mtrxmsg version").strip
  end
end
