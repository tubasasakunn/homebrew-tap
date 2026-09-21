class Vela < Formula
  desc "File-configured macOS launcher, clipboard, hotkey, and window utility"
  homepage "https://github.com/tubasasakunn/vela"
  url "https://github.com/tubasasakunn/vela/releases/download/v0.2.9/vela-0.2.9-darwin-arm64.tar.gz"
  sha256 "fff52ad9b091e0b0431b3fc7b73f4033fb62fd1cb74d1ccf9cf8a4eca47bdcd5"
  version "0.2.9"

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
