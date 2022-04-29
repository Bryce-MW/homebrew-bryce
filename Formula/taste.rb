class Paste < Formula
  desc "Simple command to view and retrieve the clipboard in multiple formats"
  homepage "https://github.com/Bryce-MW/taste"
  url "https://github.com/Bryce-MW/taste/archive/refs/tags/20220429071648.tar.gz"
  version "0.1.1"
  sha256 "b28b3f31799e76cf61b4eb280e5263c3aac537c990d7036e0cba58de3ee42315"
  license "BSD-3-Clause"
  head "https://github.com/Bryce-MW/taste.git", branch: "main"

  def install
    system ENV.cc, "taste.m", "-framework", "AppKit", "-framework", "CoreFoundation", "-o", "taste", "-O3"
    # The C version of taste
    # system ENV.cc, "taste.c", "-fuse-ld=lld", "-framework", "AppKit", "-framework", "CoreFoundation",
    #  "-o", "taste", "-O3"
    bin.install "taste"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test paste`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/taste"
    assert_equal "(null)", shell_output("#{bin}/taste some").strip
    assert_equal "test", shell_output("echo test | pbcopy; #{bin}/taste public.utf8-plain-text").strip
    system "#{bin}/taste", "--all"
    system "#{bin}/taste", "-a"
  end
end
