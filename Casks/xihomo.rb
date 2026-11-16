cask "xihomo" do
  version "0.1.1"
  sha256 "642cc225e2050dff503182ef265dd972f61eed7158ae4f46418a64ff31207177"

  url "https://github.com/ross508/xihomo/releases/download/v#{version}/xihomo-#{version}.dmg"
  name "Xihomo"
  desc "Native menu bar GUI for Mihomo"
  homepage "https://github.com/ross508/xihomo"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Xihomo.app"

  # Ad-hoc signed and not notarized: without this, Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Xihomo.app"]
  end

  # Quitting releases the system proxy and stops the core before the app is replaced.
  uninstall quit: "io.github.ross508.xihomo"

  # Never ~/.config/xihomo: it holds the user's settings and profiles, often kept in a dotfiles repo.
  zap trash: [
    "~/Library/Application Support/xihomo",
    "~/Library/Preferences/io.github.ross508.xihomo.plist",
  ]
end
