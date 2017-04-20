require "formula"

class NODEDependency < Requirement
  fatal true
  default_formula "node"
  satisfy { which("node") }
end

class S2s3 < Formula
  homepage "https://github.com/jfromaniello/s2s3"
  url "https://github.com/jfromaniello/s2s3/archive/v2.2.0.tar.gz"
  sha256 "58c97d88ddce5063169dfaecb26a215f7e9b6fc8fab2b05abb9ddc1af6e275ac"
  head "https://github.com/jfromaniello/s2s3.git"

  depends_on NODEDependency

  def install
    libexec.install Dir["*"]

    node_bin = "#{Formula["node"].opt_bin}/node"
    node_bin = which("node") unless File.exists?(node_bin)

    (bin/"s2s3").write <<-EOS.undent
      #!/bin/sh
      exec "#{node_bin}" "#{libexec}/bin/main" "$@"
    EOS
  end

  test do
    system "#{bin}/ss-to-s3", "--version"
  end
end
