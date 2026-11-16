cask "xihomo" do
  version "0.1.0"
  sha256 "9b8d7191af52882a3bad228a7e86a47c02aec3512866083b063db67a13aa1a4d"

  url "https://github.com/ross508/xihomo/releases/download/v#{version}/xihomo-#{version}.dmg"
  name "xihomo"
  desc "Native menu bar GUI for Mihomo"
  homepage "https://github.com/ross508/xihomo"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "xihomo.app"

  # Ad-hoc signed and not notarized: without this, Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/xihomo.app"]
  end

  # Quitting releases the system proxy and stops the core before the app is replaced.
  uninstall quit: "io.github.ross508.xihomo"

  zap trash: [
    "~/.config/xihomo",
    "~/Library/Application Support/xihomo",
  ]
end
