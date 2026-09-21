class Vela < Formula
  desc "File-configured macOS launcher, clipboard, hotkey, and window utility"
  homepage "https://github.com/tubasasakunn/vela"
  url "https://github.com/tubasasakunn/vela/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "cf018395d799449a8686da726948042c5abbfe1f6746721f0df054ce35984b74"
  version "0.1.0"

  depends_on xcode: :build

  def install
    system "swift", "build", "--configuration", "release", "--product", "vela"
    system "swift", "build", "--configuration", "release", "--product", "VelaApp"

    bin.install ".build/release/vela"

    app = libexec/"Vela.app"
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Resources").mkpath
    cp "Resources/Info.plist", app/"Contents/Info.plist"
    cp ".build/release/VelaApp", app/"Contents/MacOS/Vela"
    cp ".build/release/vela", app/"Contents/Helpers/vela" if (app/"Contents/Helpers").mkpath
    system "codesign", "--force", "--sign", "-", app
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
