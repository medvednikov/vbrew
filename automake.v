struct AutoMake {}

fn (x &AutoMake) mod() Module { return .automake }
fn (x &AutoMake) depends_on() []Module { return [] }
fn (x &AutoMake) name() string { return 'automake' }
fn (x &AutoMake) url() string { return 'https://ftp.gnu.org/gnu/automake/automake-1.16.3.tar.xz' }

fn (x &AutoMake) install() {
	/*
	chdir('automake')
	system('./configure --prefix=$prefix')
	system('make install')
	*/
}
