require 'formula'

class QemuLinaro < Formula
  homepage 'https://wiki.linaro.org/WorkingGroups/ToolChain/QEMU'
  head 'git://git.linaro.org/qemu/qemu-linaro.git', :using => :git
  url 'https://launchpad.net/qemu-linaro/trunk/2013.06/+download/qemu-linaro-1.5.0-2013.06.tar.gz'
  md5 'd34ce93d7c5f6b6c8d2b903fd85378a4'
  sha1 '00eae09cc4fee0017cd2cc4c53c65e22984203a9'
  sha256 '17f1a87e90a1dc41873f51b0f787eb3776f16c44c9facbc3ed43cfd7087c6ef7'

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
