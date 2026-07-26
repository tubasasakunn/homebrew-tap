cask "oreore-mac-widget" do
  version "1.1.0"
  sha256 "7dbe1cab82f5bfafcb8537b5bfc21e820a815a402b228b0e3a7d34250ad07475"

  url "https://github.com/tubasasakunn/oreore-mac-widget/releases/download/v#{version}/oreore-mac-widget-#{version}.zip"
  name "oreore-mac-widget"
  desc "Notification Center widget that shows Claude Code usage (5-hour and weekly limits)"
  homepage "https://github.com/tubasasakunn/oreore-mac-widget"

  depends_on macos: :sonoma

  app "oreore-mac-widget.app"

  # Developer ID 署名済みだが公証は通していないため、quarantine 属性を外す。
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/oreore-mac-widget.app"]
  end

  uninstall quit: "com.tubasasakun.oreore-mac-widget"

  zap trash: [
    "~/Library/Application Scripts/com.tubasasakun.oreore-mac-widget",
    "~/Library/Caches/com.tubasasakun.oreore-mac-widget",
    "~/Library/Containers/com.tubasasakun.oreore-mac-widget",
    "~/Library/HTTPStorages/com.tubasasakun.oreore-mac-widget",
    "~/Library/Preferences/com.tubasasakun.oreore-mac-widget.plist",
  ]
end
