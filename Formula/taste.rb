class Taste < Formula
  desc "Simple command to view and retrieve the clipboard in multiple formats"
  homepage "https://github.com/Bryce-MW/taste"
  url "https://github.com/Bryce-MW/taste/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "a1c3b8aba214e1924d89e5008831cf8487f43851e38313566a70174087865f59"
  license "BSD-3-Clause"
  head "https://github.com/Bryce-MW/taste.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/bryce-mw/bryce"
    sha256 cellar: :any_skip_relocation, big_sur: "3bcecf4b4526987fc5de0093fce4ec4a01da5b2e5fdc81a678c3dbceda5cbd87"
  end

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
