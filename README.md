# uvm-verilator-tbs
UVM testbench example using verilator

-----------------
git clone https://github.com/antmicro/verilator-verification-features-tests.git

cd verilator-verification-features-tests

git submodule update --init --recursive uvm

cd tests/uvm-testbenches/mem-tb
make


-----------------

https://github.com/antmicro/uvm-verilator

-----------------------------
https://github.com/chipsalliance/Cores-Veer-EL2


git clone https://github.com/chipsalliance/Cores-Veer-EL2

cd Cores-Veer-EL2
make -c testbenc/uvm/mem -j$(nproc)


-----------------------------

https://verilator.org/guide/latest/install.html

# Prerequisites:
#sudo apt-get install git help2man perl python3 make autoconf g++ flex bison ccache
#sudo apt-get install libgoogle-perftools-dev numactl perl-doc
#sudo apt-get install libfl2  # Ubuntu only (ignore if gives error)
#sudo apt-get install libfl-dev  # Ubuntu only (ignore if gives error)
#sudo apt-get install zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)

git clone https://github.com/verilator/verilator   # Only first time

# Every time you need to build:
unsetenv VERILATOR_ROOT  # For csh; ignore error if on bash
unset VERILATOR_ROOT  # For bash
cd verilator
git pull         # Make sure git repository is up-to-date
git tag          # See what versions exist
#git checkout master      # Use development branch (e.g. recent bug fixes)
#git checkout stable      # Use most recent stable release
#git checkout v{version}  # Switch to specified release version

autoconf         # Create ./configure script
./configure      # Configure and create Makefile
make -j `nproc`  # Build Verilator itself (if error, try just 'make')
sudo make install

...
Installed binaries to /usr/local/bin/verilator
Installed man to /usr/local/share/man/man1
Installed examples to /usr/local/share/verilator/examples

For documentation see 'man verilator' or 'verilator --help'
For forums and to report bugs see https://verilator.org

--------------------------------------------------


Update UVM_ROOT in the MAKEFILE witht the path to verilator-verification-features-tests/uvm

UVM_ROOT ?=../../verilator-verification-features-tests/uvm

