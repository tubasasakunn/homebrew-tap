class Vela < Formula
  desc "File-configured macOS launcher, clipboard, hotkey, and window utility"
  homepage "https://github.com/tubasasakunn/vela"
  url "https://github.com/tubasasakunn/vela/releases/download/v0.2.8/vela-0.2.8-darwin-arm64.tar.gz"
  sha256 "abadbaed037b8e2df9d6a64379499c9cae34f0d945dc3da86b75d0ab5ea62ecc"
  version "0.2.8"

  def install
    bin.install "vela"
    libexec.install "Vela.app"
  end

  service do
    run [opt_libexec/"Vela.app/Contents/MacOS/Vela"]
    keep_alive successful_exit: false
  end

  def caveats
    <<~EOS
      Start Vela as a login service:
        brew services start vela

      Create and validate its Git-manageable configuration:
        vela init
        vela check

      Grant Vela Accessibility access in System Settings for window actions.
    EOS
  end
end
