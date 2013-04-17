require 'formula'

class QemuLinaro < Formula
  homepage 'https://wiki.linaro.org/WorkingGroups/ToolChain/QEMU'
  head 'git://git.linaro.org/qemu/qemu-linaro.git', :using => :git
  url 'http://launchpad.net/qemu-linaro/trunk/2013.03/+download/qemu-linaro-1.4.0-2013.03.tar.gz'
  sha1 'dd9cce8f7993a38eec85c806a2c150374a758dfd'

  depends_on 'pkg-config' => :build
  depends_on :libtool
  depends_on 'jpeg'
  depends_on 'gnutls'
  depends_on 'glib'
  depends_on 'pixman'
  depends_on 'sdl' => :optional

  def install
    # Disable the sdl backend; use CoreAudio instead.
    args = %W[
      --prefix=#{prefix}
      --cc=#{ENV.cc}
      --host-cc=#{ENV.cc}
      --enable-cocoa
      --disable-bsd-user
      --disable-guest-agent
      --target-list=arm-softmmu
    ]
    args << (build.with?('sdl') ? '--enable-sdl' : '--disable-sdl')
    ENV['LIBTOOL'] = 'glibtool'
    system "./configure", *args
    system "make install"
  end

  test do
     /QEMU emulator .+qemu-linaro/.match `qemu-system-arm --version`
  end
end
