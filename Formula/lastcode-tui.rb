class LastcodeTui < Formula
  desc "An interactive Terminal User Interface (TUI) for real-time algorithm visualization"
  homepage "https://github.com/sunil-kumarr/lastcode" # Update with your main repo link
  url "https://files.pythonhosted.org/packages/f2/e4/fdc63397ad0abd76ef8ff74252be6ca3341299bc1d73f32935b8422360ad/lastcode_tui-0.1.1.tar.gz"
  sha256 "9b6a93ba1303fac0cab61cfaeee32237d09aaa64a2cac618b82e4ca549449708"

  depends_on "python@3.12"

 # We vendor Textual directly as a standalone resource
  resource "textual" do
    url "https://files.pythonhosted.org/packages/source/t/textual/textual-0.47.0.tar.gz"
    sha256 "613912041aa8739e4ef728bb298b6d00f2bfe3fe528ac64bc0ccc06f4ff656e0"
  end

  # We also include 'markdown-it-py' and 'linkify-it-py' which textual needs to render text
  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/source/m/markdown-it-py/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/source/m/mdurl/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/source/r/rich/rich-13.7.1.tar.gz"
    sha256 "9be308cb1fe2f1f57d67ce99e95af38a1e2bc71ad9813b0e247cf7ffbcc3a432"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/source/p/pygments/pygments-2.18.0.tar.gz"
    sha256 "786ff802f32e91311bff3889f6e9a86e81505fe99f2735bb6d60ae0c5004f199"
  end

  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/source/t/typing_extensions/typing_extensions-4.12.0.tar.gz"
    sha256 "8cbcdc8606ebcb0d95453ad7dc5065e6237b6aa230a31e81d0f440c30fed5fd8"
  end

  include Language::Python::Virtualenv

  def install
    # Creates the virtualenv and assigns it to the 'venv' variable
    venv = virtualenv_create(libexec, "python3.12")
    
    # Tells the virtualenv to install all defined resources (textual, etc.)
    venv.pip_install resources
    
    # Tells the virtualenv to install your app and link the binary
    venv.pip_install_and_link buildpath
  end

  test do
    # Ensures the binary command built and can run
    assert_match "0.1.1", shell_output("#{bin}/algo-vis --version")
  end
end