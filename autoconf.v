struct AutoConf {}

fn (x &AutoConf) mod() Module { return .autoconf }
fn (x &AutoConf) depends_on() []Module { return [] }
fn (x &AutoConf) name() string { return 'autoconf' }
fn (x &AutoConf) url() string { return 'https://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz' }

fn (x &AutoConf) install() {
	/*
	chdir('autoconf')
	system('./configure --prefix=$prefix')
	system('make install')
	*/
}
