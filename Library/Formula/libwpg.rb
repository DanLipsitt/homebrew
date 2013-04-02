require 'formula'

class Libwpg < Formula
  homepage 'http://libwpg.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/libwpg/libwpg/libwpg-0.2.1/libwpg-0.2.1.tar.bz2'
  sha1 'b8d89f4032475018c5f25e1d4419d23b806381d0'

  depends_on 'pkg-config' => :build
  depends_on 'libwpd'
  depends_on 'pkg-config' => :build

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # Separate steps or install can fail due to folders not existing
    system "make"
    ENV.j1
    system "make install"
  end
end
