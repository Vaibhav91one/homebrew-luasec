class Luasec < Formula
  desc "Static security scanner for Lua in embedded firmware: finds remote code execution"
  homepage "https://github.com/Vaibhav91one/luasec"
  url "https://github.com/Vaibhav91one/luasec/releases/download/v0.5.1/luasec-0.5.1.tar.gz"
  sha256 "b004d2d727a9d48c10755277105e625596ad5fa7c1c1f3cfb1d5a319e9bd126c"
  license "MIT"

  depends_on "lua"

  def install
    libexec.install Dir["*"]
    (bin/"luasec").write_env_script libexec/"bin/luasec", LUA: Formula["lua"].opt_bin/"lua"
  end

  test do
    assert_match "luasec #{version}", shell_output("#{bin}/luasec --version")
    (testpath/"t.lua").write "os.execute(io.read())\n"
    assert_match "[709] critical", shell_output("#{bin}/luasec #{testpath}/t.lua", 1)
  end
end
