require "language/go"

class DockerMachine < Formula
  homepage "https://github.com/docker/machine"
  version "0.0.2"
  ## Version 0.0.2 doesn't build, so we install a downloaded binary
  ## unless this is a HEAD build.
  # url "https://github.com/docker/machine/archive/0.0.2.tar.gz"
  # sha1 "adcc7128abdbaae60ba3c58d6485df939c7e5510"
  url "https://github.com/docker/machine/releases/download/0.0.2/machine_darwin_amd64"
  sha1 "daecfe7e86a7c6a8dc444e03c5527f9db36b9c3e"
  head "https://github.com/docker/machine.git"

  depends_on "go" => :build
  depends_on :hg => :build

  go_resource "code.google.com/p/goauth2" do
    url "https://code.google.com/p/goauth2", :revision => "afe77d958c701557ec5dc56f6936fcc194d15520", using => :hg
  end
  go_resource "github.com/MSOpenTech/azure-sdk-for-go" do
    url "https://github.com/MSOpenTech/azure-sdk-for-go.git", :revision => "5c339391be6b347eccb2addcb779d38940db5b44", using => :git
  end
  go_resource "github.com/Sirupsen/logrus" do
    url "https://github.com/Sirupsen/logrus.git", :revision => "d2f9ffa1d9cf25b25191b221229effac1b6de526", using => :git
  end
  go_resource "github.com/codegangsta/cli" do
    url "https://github.com/codegangsta/cli.git", :revision => "bf4a526f48af7badd25d2cb02d587e1b01be3b50", using => :git
  end
  go_resource "github.com/digitalocean/godo" do
    url "https://github.com/digitalocean/godo.git", :revision => "c467db591ad9218663c089428955f2fad88a0b57", using => :git
  end
  go_resource "github.com/docker/docker" do
    url "https://github.com/docker/docker.git", :revision => "de9783980be2a7b3ca10eb8183ea5989acbd3e7e", using => :git
  end
  go_resource "github.com/docker/libtrust" do
    url "https://github.com/docker/libtrust.git", :revision => "1dc3c57f6be6c80ea80441e6fb11b320f6da8a6a", using => :git
  end
  go_resource "github.com/docker/machine" do
    url "https://github.com/docker/machine.git", :revision => "4c285dcffa860a795edc6b4af00feb65648a3345", using => :git
  end
  go_resource "github.com/google/go-querystring" do
    url "https://github.com/google/go-querystring.git", :revision => "d8840cbb2baa915f4836edda4750050a2c0b7aea", using => :git
  end
  go_resource "github.com/smartystreets/go-aws-auth" do
    url "https://github.com/smartystreets/go-aws-auth.git", :revision => "1f0db8c0ee6362470abe06a94e3385927ed72a4b", using => :git
  end
  go_resource "github.com/tent/http-link-go" do
    url "https://github.com/tent/http-link-go.git", :revision => "ac974c61c2f990f4115b119354b5e0b47550e888", using => :git
  end
  go_resource "github.com/vmware/govcloudair" do
    url "https://github.com/vmware/govcloudair.git", :revision => "9672590d5e5795b2d29fce97084fd5810665fc27", using => :git
  end
  go_resource "google.golang.org/api" do
    url "https://github.com/google/google-api-go-client.git", :revision => "aa91ac681e18e52b1a0dfe29b9d8354e88c0dcf5", using => :git
  end

  def install
    if build.head?
      ENV["GOPATH"] = buildpath
      Language::Go.stage_deps resources, buildpath/"src"
      system "go", "build", "-o", name
    else
      mv "machine_darwin_amd64", name
    end
    bin.install name
  end

  test do
    system "#{bin}/#{name}", "ls"
  end
end
