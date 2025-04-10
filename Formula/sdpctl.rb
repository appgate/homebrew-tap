# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Sdpctl < Formula
  desc "Official CLI tool for managing Appgate SDP Collectives"
  homepage "https://github.com/appgate/sdpctl/releases"
  version "2025.04.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/appgate/sdpctl/releases/download/2025.04.10/sdpctl_2025.04.10_darwin_arm64.tar.gz"
      sha256 "cedd0f4c75823c755e2cf19285fd79ee8a4f20ced5d0d51551e16be470dbbd3a"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/appgate/sdpctl/releases/download/2025.04.10/sdpctl_2025.04.10_darwin_amd64.tar.gz"
      sha256 "8eaef6d6153f55a614d2fd28720c95addf7aeef07a368303e236e9e75f835acc"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/appgate/sdpctl/releases/download/2025.04.10/sdpctl_2025.04.10_linux_amd64.tar.gz"
      sha256 "82881d66d252a326a93b8b6fdcd3147d8baf809d5ac347732feea5508868546c"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/appgate/sdpctl/releases/download/2025.04.10/sdpctl_2025.04.10_linux_arm64.tar.gz"
      sha256 "700610f82dc744476f6ee094fa88ca93f6a313b2d7fe95bd12d939cf29d3d3cb"

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
