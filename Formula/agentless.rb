class Agentless < Formula
  desc "Declarative agent.yaml deployments of ADK agents to Google Cloud Agent Runtime"
  homepage "https://github.com/Aymen2518/agentless"
  url "https://github.com/Aymen2518/agentless/releases/download/v0.13.1/agentless_cli-0.13.1.tar.gz"
  sha256 "8d2207998d043cd48662d74c419319490a40d2b98fcaa7369451d06724ab92b8"
  license "Apache-2.0"

  depends_on "python@3.11"

  # Dependencies (google-cloud-*, grpcio, ...) come from PyPI as prebuilt wheels into a private virtualenv.
  def install
    python = Formula["python@3.11"].opt_bin/"python3.11"
    system python, "-m", "venv", libexec
    system libexec/"bin/python", "-m", "pip", "install", "--no-cache-dir", "--disable-pip-version-check", buildpath
    bin.install_symlink libexec/"bin/agentless"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentless version")
    (testpath/"agent.yaml").write "service: x\n"
    assert_match "agent.yaml", shell_output("#{bin}/agentless validate -c #{testpath}/agent.yaml 2>&1", 1)
  end
end
