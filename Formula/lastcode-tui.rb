class LastcodeTui < Formula
  desc "An interactive Terminal User Interface (TUI) for real-time algorithm visualization"
  homepage "https://github.com/sunil-kumarr/lastcode" # Update with your main repo link
  url "https://files.pythonhosted.org/packages/f2/e4/fdc63397ad0abd76ef8ff74252be6ca3341299bc1d73f32935b8422360ad/lastcode_tui-0.1.1.tar.gz"
  sha256 "9b6a93ba1303fac0cab61cfaeee32237d09aaa64a2cac618b82e4ca549449708"

  depends_on "python@3.12"

  # We vendor Textual directly as a standalone resource
  resource "textual" do
    url "https://files.pythonhosted.org/packages/source/t/textual/textual-0.47.0.tar.gz"
    sha256 "05b45151b7fa093c1cf786937517c24097491d90060e227fc66d34bde5cfb61d"
  end

  # We also include 'markdown-it-py' and 'linkify-it-py' which textual needs to render text
  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/source/m/markdown-it-py/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f6ee041839e599aae64082269e2df3415606764f147b420f86af53c6ad3c0c"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/source/m/mdurl/mdurl-0.1.2.tar.gz"
    sha256 "5133656e4773a1ba84512b1a9e920d36ef534a8190022f462f6b472e00def751"
  end

  include Language::Python::Virtualenv

  def install
    # Creates an isolated Python virtualenv directly inside the Homebrew cellar location
    virtualenv_create(libexec, "python3.12")
    
    # Installs the packaged dependencies first
    resources.each do |r|
      libexec.pip_install r
    end
    
    # Installs your primary TUI binary app
    libexec.pip_install_and_link buildpath
  end

  test do
    # Ensures the binary command built and can run
    assert_match "0.1.1", shell_output("#{bin}/algo-vis --version")
  end
end