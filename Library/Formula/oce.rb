require 'formula'

class Oce < Formula
  homepage 'https://github.com/tpaviot/oce'
  url 'https://github.com/tpaviot/oce/archive/OCE-0.13.zip'
  sha1 'e98356628903c08a0103be86a2116bb8029fb51a'
  head 'https://github.com/tpaviot/oce.git'

  depends_on 'cmake' => :build
  depends_on :x11
  depends_on 'ftgl'

  def install
    mkdir 'build' do
      system "cmake", "..",  "-DOCE_WITH_FREEIMAGE:BOOL=ON",
      "-DOCE_WITH_GL2PS:BOOL=ON", *std_cmake_args
      system "make", "install/strip"
    end
  end

  test do
    (testpath/'CMakeLists.txt').write <<-EOS.undent
      cmake_minimum_required(VERSION 2.6)
      find_package(OCE)
      if(OCE_FOUND)
          message(STATUS "Found OCE.")
      else(OCE_FOUND)
          message(FATAL_ERROR "OCE not found.")
      endif(OCE_FOUND)
    EOS
    system 'cmake', testpath
  end
end
