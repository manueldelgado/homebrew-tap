class MattersThatMatter < Formula
  desc "Command-line tool and MCP server for Matters that Matter in Obsidian"
  homepage "https://matters-that-matter.app/"
  url "https://registry.npmjs.org/matters-that-matter/-/matters-that-matter-0.5.0.tgz"
  sha256 "875d5661c1bf2572ee00fe621aa3d61e1a62bc263ebc151aa14bfb96028141a1"
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
