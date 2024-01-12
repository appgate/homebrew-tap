class Sdpctl < Formula
  desc "Official CLI tool for managing Appgate SDP Collectives"
  homepage "https://github.com/appgate/sdpctl/releases"
  version "2023.11.07"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/appgate/sdpctl/releases/download/2023.11.07/sdpctl_2023.11.07_darwin_amd64.tar.gz"
    sha256 "71f3a52dc5ec1cd9f7c9915a4d53aec5ef4aa0d62e3bf47b4f1eaaafe0d1dee0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/appgate/sdpctl/releases/download/2023.11.07/sdpctl_2023.11.07_darwin_arm64.tar.gz"
    sha256 "99d0f0cf2fef5e415641046ce5e8cc5292d1c6f22db921684a7a5c689c0efec3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/appgate/sdpctl/releases/download/2023.11.07/sdpctl_2023.11.07_linux_amd64.deb"
    sha256 "388889321d6aaf389ee87acc247ea9885e684a1581c8ebfbeab7348abd7c0214"
  end
  
  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/appgate/sdpctl/releases/download/2023.11.07/sdpctl_2023.11.07_linux_arm64.tar.gz"
    sha256 "2f441756194ca67f11e5cf18f182a6bbd233e26f0ca96faff6dd70bcfe6e51b9"
  end

  conflicts_with "sdpctl"

  def install
    bin.install "sdpctl"
    generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
  end

  test do
    version_output = shell_output("#{bin}/sdpctl --version")
    assert_match "sdpctl version #{version}", version_output.split("\n")[0]

    profile_add = shell_output("#{bin}/sdpctl profile add test")
    expected = "Created profile test, run 'sdpctl profile list' to see all available profiles\n" \
               "run 'sdpctl profile set test' to select the new profile"
    assert_match expected, profile_add

    profile_set = shell_output("#{bin}/sdpctl profile set test")
    expected = "test is selected as current sdp profile\n" \
               "test is not configured yet, run 'sdpctl configure'"
    assert_match expected, profile_set

    configure = shell_output("#{bin}/sdpctl configure https://example.com:8443")
    expected = "Configuration updated successfully"
    assert_match expected, configure
  end
end
