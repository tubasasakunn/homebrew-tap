cask "oreore-mac-widget" do
  version "1.2.0"
  sha256 "7bd68637dd691a7846cf8424f02af5e32551b45d0c18cc5601a58dbe3cf1a8e2"

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
