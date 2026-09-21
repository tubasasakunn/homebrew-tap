class Vela < Formula
  desc "File-configured macOS launcher, clipboard, hotkey, and window utility"
  homepage "https://github.com/tubasasakunn/vela"
  url "https://github.com/tubasasakunn/vela/releases/download/v0.2.6/vela-0.2.6-darwin-arm64.tar.gz"
  sha256 "afba3cd7c65b4572aa49b0544e59705fd03e24e0ab506e1d0e7ca3dd768eac02"
  version "0.2.6"
  revision 2

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
