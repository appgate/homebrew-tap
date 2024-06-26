# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Sdpctl < Formula
  desc "Official CLI tool for managing Appgate SDP Collectives"
  homepage "https://github.com/appgate/sdpctl/releases"
  version "2024.04.29"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/appgate/sdpctl/releases/download/2024.04.29/sdpctl_2024.04.29_darwin_amd64.tar.gz"
      sha256 "71d28aa7103effa5b36d668029f3449975c6837025677c0d67f61c587ceea1a9"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/appgate/sdpctl/releases/download/2024.04.29/sdpctl_2024.04.29_darwin_arm64.tar.gz"
      sha256 "b1393ad38cb1950ef4a15e7037d0fe1863891c556c1647ed33d8ba791f3f7b49"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/appgate/sdpctl/releases/download/2024.04.29/sdpctl_2024.04.29_linux_arm64.tar.gz"
      sha256 "12eae9703265eaf8bad096c31791d780cb6a335bf5f53f3ad6f40dd56486c7ed"

      def install
        bin.install "sdpctl"
        generate_completions_from_executable("#{bin}/sdpctl", "completion", shells: [:bash, :zsh, :fish])
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/appgate/sdpctl/releases/download/2024.04.29/sdpctl_2024.04.29_linux_amd64.tar.gz"
      sha256 "ee6705e165e34244010ee39d02dd4a7e5e78a5137d1309074845c0212ba32600"

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
