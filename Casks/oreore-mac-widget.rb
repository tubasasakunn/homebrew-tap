cask "oreore-mac-widget" do
  version "1.3.0"
  sha256 "6db229671899f2348ba00097d6a347be7666012ac7343a5203bd1ff2e051641d"

  url "https://github.com/tubasasakunn/oreore-mac-widget/releases/download/v#{version}/oreore-mac-widget-#{version}.zip"
  name "oreore-mac-widget"
  desc "Notification Center widget that shows Claude Code usage and scheduled routines"
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
