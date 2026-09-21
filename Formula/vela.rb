require "etc"

class Vela < Formula
  desc "File-configured macOS launcher, clipboard, hotkey, and window utility"
  homepage "https://github.com/tubasasakunn/vela"
  url "https://github.com/tubasasakunn/vela/archive/refs/tags/v0.2.6.tar.gz"
  sha256 "3934d5cea4a6c47fad5c95bea68a9042ebccd17a2858f9a10bcc9e96454f944d"
  version "0.2.6"
  revision 1

  depends_on xcode: :build

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "vela"
    cli_path = Dir[".build/**/release"].find { |path| File.file?("#{path}/vela") }
    odie "SwiftPM did not produce the Vela CLI" unless cli_path
    bin.install "#{cli_path}/vela"

    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "VelaApp"
    app_path = Dir[".build/**/release"].find { |path| File.file?("#{path}/VelaApp") }
    odie "SwiftPM did not produce the Vela application" unless app_path

    app = libexec/"Vela.app"
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Resources").mkpath
    cp "Resources/Info.plist", app/"Contents/Info.plist"
    cp "#{app_path}/VelaApp", app/"Contents/MacOS/Vela"
    (app/"Contents/Helpers").mkpath
    cp bin/"vela", app/"Contents/Helpers/vela"
    developer_id = "Developer ID Application: BasaApp Technologies (7NN5KD3TSU)"
    login_keychain = "#{Etc.getpwuid(Process.uid).dir}/Library/Keychains/login.keychain-db"
    identities = Utils.safe_popen_read("security", "find-identity", "-v", "-p", "codesigning", login_keychain)
    if identities.include?(developer_id)
      system "codesign", "--force", "--options", "runtime", "--timestamp", "--sign", developer_id, app
    else
      opoo "Developer ID certificate was not found; using an ad-hoc signature"
      system "codesign", "--force", "--sign", "-", app
    end
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
