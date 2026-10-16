class MattersThatMatter < Formula
  desc "Command-line tool and MCP server for Matters that Matter in Obsidian"
  homepage "https://matters-that-matter.app/"
  url "https://registry.npmjs.org/matters-that-matter/-/matters-that-matter-0.4.0.tgz"
  sha256 "e53a6e6ce8c3cb0dbb09db0c8eeda38d5b69b7e22bc8aba5299bb5ca64d3d5b7"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/matters-that-matter --version")

    settings = testpath/"vault/.obsidian/plugins/matters-that-matter/data.json"
    settings.dirname.mkpath
    settings.write '{"schemaVersion":7,"setupDone":true}'

    output = shell_output("#{bin}/matters-that-matter add 'Call the plumber /call !1' --vault #{testpath}/vault")
    assert_match "Call the plumber", output

    note = (testpath/"vault/MTM/Actions/Call the plumber.md").read
    assert_match "mtm-type: call", note
    assert_match "mtm-priority: 1", note
  end
end
