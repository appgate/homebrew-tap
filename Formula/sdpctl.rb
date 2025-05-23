# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Sdpctl < Formula
  desc "Official CLI tool for managing Appgate SDP Collectives"
  homepage "https://github.com/appgate/sdpctl/releases"
  version "2025.05.19"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/appgate/sdpctl/releases/download/2025.05.19/sdpctl_2025.05.19_darwin_amd64.tar.gz"
      sha256 "70e189f012f23c8387b5e871f8037cc5e2a5629b07eb3ea481df276a49a94ee1"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/appgate/sdpctl/releases/download/2025.05.19/sdpctl_2025.05.19_darwin_arm64.tar.gz"
      sha256 "1c68fec8fdabc93ee817212abe508cfb83534cff25b8239647e143a925792b7d"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/appgate/sdpctl/releases/download/2025.05.19/sdpctl_2025.05.19_linux_arm64.tar.gz"
      sha256 "f8088342f70fa253893bc7be3680460a6f14b67031a918e3f5ccf573239bcced"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/appgate/sdpctl/releases/download/2025.05.19/sdpctl_2025.05.19_linux_amd64.tar.gz"
      sha256 "802cb58c7d7c5d97de16fbfedce218782939391a1a85905cda8a0984204a1ced"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
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
