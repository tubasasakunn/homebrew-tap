class Vela < Formula
  desc "File-configured macOS launcher, clipboard, hotkey, and window utility"
  homepage "https://github.com/tubasasakunn/vela"
  url "https://github.com/tubasasakunn/vela/releases/download/v0.3.2/vela-0.3.2-darwin-arm64.tar.gz"
  sha256 "4ab2383663cb5be26421c2d2fb95796285df2b6579f41b0a37357f843e1c918c"

  depends_on arch: :arm64
  depends_on macos: :sonoma

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
      Start Vela's guided setup:
        vela init

      Grant Vela Accessibility access in System Settings for window actions.
    EOS
  end

  test do
    assert_match "Usage: vela <command>", shell_output(bin/"vela")
  end
end
