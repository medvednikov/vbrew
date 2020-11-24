struct CoreUtils {}

fn (x &CoreUtils) mod() Module { return .coreutils }
fn (x &CoreUtils) depends_on() []Module { return [.autoconf, .automake] }
fn (x &CoreUtils) name() string { return 'coreutils' }
fn (x &CoreUtils) url() string { return 'https://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz'}

fn (x &CoreUtils) install() {
	download_and_extract(x.url(), x.name())
	// if x.is_head() {
	// system('./bootstrap')
	// }
	args := '--prefix=$prefix --program-prefix=g --without-gmp'
	system('./configure $args')
	system('make install')
}
